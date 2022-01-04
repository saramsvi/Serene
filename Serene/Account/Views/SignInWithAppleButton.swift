//
//  SignInWithAppleButton.swift
//  Authorization(iOS)
//
//  Created by MSVI on 15.09.21.
//

import SwiftUI
import AuthenticationServices
struct SignInWithAppleButton: UIViewRepresentable {
    typealias UIViewType = ASAuthorizationAppleIDButton
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        return ASAuthorizationAppleIDButton(type: .signIn, style: .black)
    }
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {}
}
