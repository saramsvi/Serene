//
//  SignInWithAppleObject.swift
//  Authorization(iOS)
//
//  Created by MSVI on 15.09.21.
//

import Foundation
import AuthenticationServices
import CryptoKit
import FirebaseAuth
public class SigninWithAppleObject: NSObject{
    private var currentNonce: String?
   public  func signInWithApple(){
        let  request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.email,.fullName]
        //nonce is a random string that is normally generated when you want to make sure the data is the one that you requested
        let nonce = randomNonceString()
        currentNonce = nonce
            request.nonce =  sha256(currentNonce!)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
    // Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    private func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        return String(format: "%02x", $0)
      }.joined()

      return hashString
    }
}

extension SigninWithAppleObject: ASAuthorizationControllerDelegate{
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        //sign in using firebase auth
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential{
            guard  let nonce = currentNonce else {
                print("invalid state: a login callback was received but no login was sent.")
            return
                
            }
            guard let appleIDToken = appleIDCredential.identityToken else{
                print("unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else{
                print("unable to serialize token string from data")
                return
            }
            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
            Auth.auth().signIn(with: credential){
                result ,error in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
            }
        }
    }
}
