//
//  BlurView.swift
//  Serene
//
//  Created by MSVI on 2.05.22.
//


import SwiftUI

struct BlurView : UIViewRepresentable {
    typealias UIViewType = UIView
    var style: UIBlurEffect.Style
    //creating basic ui
    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = .clear
        //systemmaterial is  best  for dark/light mode
        let blurEffect = UIBlurEffect(style: style)
        let  blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate([
                                        blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
                                        blurView.heightAnchor.constraint(equalTo: view.heightAnchor)
                           ])
        
        return view
    }
    //something more dynamic [animations, binding,...]
    func updateUIView(_ uiView: UIView, context:
                        UIViewRepresentableContext<BlurView>) {
            
    }
}
