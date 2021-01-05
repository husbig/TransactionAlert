//
//  TAButton.swift
//  TransactionAlert
//
//  Created by Hüseyin Bagana on 4.01.2021.
//

import SwiftUI

public struct TAPrimaryButton : ButtonStyle {
    public var font : Font
    public var tint : Color
    public init(font:Font = .body,tint:Color = .blue){
        self.font = font
        self.tint = tint
    }
    public func makeBody(configuration: Self.Configuration) -> some View {
      configuration.label
        .padding(.top, 12)
        .padding(.bottom, 12)
        .font(font)
        .frame(minWidth:0.0,maxWidth: .infinity)
        .foregroundColor(.white)
        .background(tint)
        .cornerRadius(4.0)
        
    }
}
public struct TASecondaryButton : ButtonStyle {
    public var font : Font
    public var tint : Color
    public init(font:Font = .body,tint:Color = .red){
        self.font = font
        self.tint = tint
    }
    public func makeBody(configuration: Self.Configuration) -> some View {
      configuration.label
        .padding(.top, 12)
        .padding(.bottom, 12)
        .font(font)
        .frame(minWidth:0.0,maxWidth: .infinity)
        .foregroundColor(tint)
        .background(Color.white)
        .cornerRadius(4.0)
        .overlay(RoundedRectangle(cornerRadius: 4.0).stroke(tint.opacity(0.33), lineWidth: 1))
                
    }
}
public class TAButton {
    public let tintColor : Color
    public let title : String
    public let action : (()->Void)?
    public init(tint:Color,title:String = "",action:(()->Void)?=nil) {
        self.tintColor = tint
        self.title = title
        self.action = action
    }
}
