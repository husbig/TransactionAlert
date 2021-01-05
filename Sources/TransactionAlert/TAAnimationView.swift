//
//  TAAnimationView.swift
//  TransactionAlert
//
//  Created by Hüseyin Bagana on 4.01.2021.
//

import SwiftUI
import Lottie
struct TAAnimationView: UIViewRepresentable {
    var lottieCompletionBlock : LottieCompletionBlock?
    @Binding var state : TAAlertState    
    @State var animationView = AnimationView.init(name: "taAnimation", bundle:  Bundle.module)
    let backView = UIView()
    
    func makeUIView(context: UIViewRepresentableContext<TAAnimationView>) -> UIView {
        animationView.loopMode = .loop
        backView.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.heightAnchor.constraint(equalTo: backView.widthAnchor, multiplier: 1.1).isActive = true
        animationView.widthAnchor.constraint(equalTo: backView.widthAnchor, multiplier: 1.1).isActive = true
        animationView.centerXAnchor.constraint(equalTo: backView.centerXAnchor).isActive = true
        animationView.centerYAnchor.constraint(equalTo: backView.centerYAnchor).isActive = true
        animationView.contentMode = .scaleAspectFit
        animationView.animationSpeed = 1.5
        animationView.layer.masksToBounds = true
        animationView.backgroundColor = .clear
        
        return backView
    }
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<TAAnimationView>) {
        if state == .success(){
            animationView.contentMode = .scaleAspectFit
            self.animationView.play(fromProgress: 240.0/841.0, toProgress: 371.0/841.0, loopMode: .playOnce, completion:  self.lottieCompletionBlock)
            
        }
        else if state == .loading(){
            DispatchQueue.main.async {
                self.animationView.contentMode = .scaleAspectFit
                self.animationView.play(fromProgress: 2.0/841.0, toProgress: 240.0/841.0, loopMode: .loop, completion:  self.lottieCompletionBlock)
            }
            
        }
        else if state == .error(){
            DispatchQueue.main.async {
                self.animationView.contentMode = .scaleAspectFit
                self.animationView.play(fromProgress: 659.0/841.0, toProgress: 827.0/841.0, loopMode: .playOnce, completion:  self.lottieCompletionBlock)
            }
            
        }
    }
}
