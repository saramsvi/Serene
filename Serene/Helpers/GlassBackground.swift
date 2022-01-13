//
//  GlassBackground.swift
//  SereneBeta
//
//  Created by MSVI on 19.12.21.
//

import SwiftUI

struct GlassBackground: View {
    var body: some View {
//        LinearGradient(
//            colors: [Color(.white),Color("LighterBlue")],
//            startPoint: .top,
//            endPoint: .bottom)
//            .ignoresSafeArea()
        GeometryReader { proxy in
            let size = proxy.size
            // Slighlty Darkening ...
            #if os(iOS)
            Color(UIColor.systemBackground)
                .opacity(0.7)
                .blur(radius: 111)
                .ignoresSafeArea()
            #else
            Color(.white)
                .opacity(0.7)
                .blur(radius: 111)
                .ignoresSafeArea()
             #endif
            
            Circle()
                .fill(Color("Purple"))
                .padding(30)
                .blur(radius: 111)
            // Moving Top...
                .offset(x: -size.width / 1.8, y: -size.height / 5)
            Circle()
                .fill(Color("LightBlue"))
                .padding(70)
                .blur(radius: 111)
            // Moving Top...
                .offset(x: size.width / 1.8, y: -size.height / 2)
            Circle()
                .fill(Color("Purple"))
                .padding(80)
                .blur(radius: 111)
            // Moving Top...
                .offset(x: size.width / 1.8, y: size.height / 2)
            
            // Adding Purple on both botom ends...
            Circle()
                .fill(Color("Purple"))
                .padding(100)
                .blur(radius: 111)
            // Moving Top...
                .offset(x: size.width / 1.8, y: size.height / 2)
            
            Circle()
                .fill(Color("LightBlue"))
                .padding(100)
                .blur(radius: 111)
            // Moving Top...
                .offset(x: -size.width / 1.8, y: size.height / 2)
        }
    }
}
