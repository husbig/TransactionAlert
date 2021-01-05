//
//  TransactionAlertView.swift
//  TransactionAlert
//
//  Created by Hüseyin Bagana on 3.01.2021.
//

import SwiftUI
import PartialSheet

struct TransactionAlert: View {
    @EnvironmentObject var taViewModel : TAViewModel
    var stateStyle : TAStateStyle{
        return taViewModel.state.style
    }
    var body : some View{
        ZStack(alignment:.topTrailing){
            
            Image.init(systemName: "xmark.circle.fill")
                .resizable()
                .frame(width: 24, height: 24)
                .padding(.top, -12)
                .padding(.trailing, 16)
                .foregroundColor(stateStyle.iconTint)
                .onTapGesture {
                    taViewModel.hide()
                    stateStyle.stateDismissEvent?(taViewModel.state)
                }
                .opacity(stateStyle.showCloseButton ? 1 : 0)
            if TAAlertState.start() == taViewModel.state{
                VStack(spacing: 16){
                    
                    taViewModel.state.style.icon?
                        .resizable()
                        .frame(width:64,height:64)
                        .foregroundColor(stateStyle.iconTint)
                    if !stateStyle.title.isBlank {
                        Text(stateStyle.title)
                            .font(stateStyle.titleFont)
                            .foregroundColor(stateStyle.titleColor)
                            .lineLimit(nil)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                        
                    }
                    if !stateStyle.description.isBlank {
                        Rectangle()
                            .frame(width:75,height:3)
                            .foregroundColor(stateStyle.titleColor)
                        Text(stateStyle.description)
                            .font(stateStyle.descriptionFont)
                            .foregroundColor(stateStyle.descriptionColor)
                            .lineLimit(nil)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    HStack(spacing:16){
                        if stateStyle.secondaryButton != nil{
                            Button(stateStyle.secondaryButton?.title ?? ""){
                                stateStyle.secondaryButton?.action?()
                            }
                            .buttonStyle(TASecondaryButton())
                        }
                        if stateStyle.primaryButton != nil{
                            Button(stateStyle.primaryButton?.title ?? ""){
                                stateStyle.primaryButton?.action?()
                            }
                            .buttonStyle(TAPrimaryButton())
                        }
                        
                    }
                    
                    
                }
                .padding(16)
                .opacity(TAAlertState.start() == taViewModel.state ? 1 : 0 )
                .frame(minWidth: 0, maxWidth: .infinity)
            }
            
            if TAAlertState.start() != taViewModel.state{
                VStack(spacing: 16){
                    if TAAlertState.loading() == taViewModel.state || TAAlertState.error() == taViewModel.state || TAAlertState.success() == taViewModel.state{
                        if stateStyle.showAnimation{
                            TAAnimationView(state: $taViewModel.state)
                                .frame(width:64,height:64)
                                .padding(.top, 16)
                                .animation(.easeInOut(duration: 0.3))
                                .transition(.opacity)
                        }
                    }
                    
                    if !stateStyle.title.isBlank {
                        Text(stateStyle.title)
                            .font(stateStyle.titleFont)
                            .foregroundColor(stateStyle.titleColor)
                            .lineLimit(nil)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    if !stateStyle.description.isBlank {
                        Rectangle()
                            .frame(width:75,height:3)
                            .foregroundColor(stateStyle.titleColor)
                        Text(stateStyle.description)
                            .font(stateStyle.descriptionFont)
                            .foregroundColor(stateStyle.descriptionColor)
                            .lineLimit(nil)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    if case TAAlertState.custom(_,_, _) = taViewModel.state{
                        taViewModel.state.customView
                    }
                    if stateStyle.primaryButton != nil || stateStyle.secondaryButton != nil{
                        HStack(spacing:16){
                            if stateStyle.primaryButton != nil{
                                Button(stateStyle.primaryButton?.title ?? ""){
                                    stateStyle.primaryButton?.action?()
                                }
                                .buttonStyle(TAPrimaryButton())
                            }
                            if stateStyle.secondaryButton != nil{
                                Button(stateStyle.secondaryButton?.title ?? ""){
                                    stateStyle.secondaryButton?.action?()
                                }
                                .buttonStyle(TASecondaryButton())
                            }
                        }
                    }
                    
                }
                .padding(16)
                .opacity(TAAlertState.start() != taViewModel.state ? 1 : 0 )
                .frame(minWidth: 0, maxWidth: .infinity)
            }
            
        }
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}
public class TAViewModel: ObservableObject {
    @Published public fileprivate(set) var state : TAAlertState = .none{
        willSet{
            DispatchQueue.main.async {
                if self.showAlert && newValue == TAAlertState.none{
                    self.showAlert = false
                }
                else if newValue != TAAlertState.none{
                    self.showAlert = true
                }
            }
        }
    }
    public func set(_ state:TAAlertState) {
        withAnimation {
            self.state = state
        }
    }
    public func hide() {
        self.showAlert = false
        
    }
    @Published fileprivate var showAlert = false
    public init() {
        print(self.showAlert)
    }
}
public enum TAAlertState : Equatable {
    public static func == (lhs: TAAlertState, rhs: TAAlertState) -> Bool {
        switch (lhs,rhs) {
        case (.none,.none):
            return true
        case (.start(_),.start(_)):
            return true
        case (.loading(_),.loading(_)):
            return true
        case (.error(_),.error(_)):
            return true
        case (.success(_),.success(_)):
            return true
        case (let .custom(id,_,_),let .custom(id2,_,_)):
            return id == id2
        default:
            return false
        }
    }
    
    case none ,start(style:TAStateStyle=TAStateStyle.defaultStyle),loading(style:TAStateStyle=TAStateStyle.defaultStyle),error(style:TAStateStyle=TAStateStyle.defaultStyle),success(style:TAStateStyle? = nil),custom(id:String,style:TAStateStyle = .defaultStyle,view:AnyView)
    public var style : TAStateStyle{
        switch self {
        case let .start(style):
            return style
        case let .loading(style):
            return style
        case let .error(style):
            return style
        case let .success(style):
            return style ?? .defaultStyle
        case let .custom(_,style,_):
            return style
        default:
            return .defaultStyle
        }
    }
    public var customView : AnyView{
        switch self {
        case let .custom(_,_,view):
            return view
        default:
            return AnyView(EmptyView())
        }
    }
    
}

public class TAStateStyle {
    public static var defaultStyle = TAStateStyle.init()
    fileprivate var showCloseButton = true
    fileprivate var showAnimation = true
    fileprivate var titleFont = Font.system(size: 14)
    fileprivate var descriptionFont = Font.system(size: 14)
    fileprivate var icon : Image? = nil
    fileprivate var iconTint : Color = Color.black
    fileprivate var title : String = ""
    fileprivate var description : String = ""
    fileprivate var descriptionColor = Color.black
    fileprivate var titleColor = Color.black
    fileprivate var primaryButton : TAButton? = nil
    fileprivate var secondaryButton : TAButton? = nil
    fileprivate var stateDismissEvent : ((TAAlertState) -> (Void))? = nil
    public init() {
        
    }
    public func titleFont(font:Font) -> TAStateStyle {
        
        self.titleFont = font
        return self
    }
    public func descriptionFont(font:Font) -> TAStateStyle {
        self.descriptionFont = font
        return self
    }
    public func closeButtonHidden(isHidden:Bool) -> TAStateStyle {
        self.showCloseButton = !isHidden
        return self
    }
    public func icon(image:Image) -> TAStateStyle {
        self.icon = image
        return self
    }
    public func iconTint(color:Color) -> TAStateStyle {
        self.iconTint = color
        return self
    }
    public func title(text:String) -> TAStateStyle {
        self.title = text
        return self
    }
    public func description(text:String) -> TAStateStyle {
        self.description = text
        return self
    }
    public func descriptionColor(color:Color) -> TAStateStyle {
        self.descriptionColor = color
        return self
    }
    public func titleColor(color:Color) -> TAStateStyle {
        self.titleColor = color
        return self
    }
    public func primaryButton(button:TAButton?) -> TAStateStyle {
        self.primaryButton = button
        return self
    }
    public func secondaryButton(button:TAButton?) -> TAStateStyle {
        self.secondaryButton = button
        return self
    }
    
}
extension String{
    static var blank = ""
    var isBlank : Bool{
        self == String.blank
    }
}

public extension View {
    func transactionAlert(backgroundColor:Color = .white,cornerRadius :CGFloat=16) -> some View {
        
        ViewWithTransactionAlertView(root: NavigationView{
            self
        }
        .addPartialSheet(style: PartialSheetStyle.init(background: .solid(backgroundColor), handlerBarColor: .clear, enableCover: true, coverColor: .clear, cornerRadius: cornerRadius, minTopDistance: 16)))
        
        
    }
}
fileprivate struct ViewWithTransactionAlertView<Root:View> : View {
    @EnvironmentObject var taViewModel : TAViewModel
    @StateObject var manager = PartialSheetManager.init()
    let root: Root
    var body: some View{
        
        root
            .partialSheet(isPresented: $taViewModel.showAlert, content: {
                TransactionAlert()
                    .environmentObject(taViewModel)
                
            })
            .environmentObject(self.manager)
            .highPriorityGesture(DragGesture())
    }
}
