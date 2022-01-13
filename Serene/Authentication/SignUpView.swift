//
//  ContentView.swift
//  Authorization(iOS)
//
//  Created by MSVI on 12.09.21.
//

import SwiftUI
//for haptic
import AudioToolbox
import FirebaseAuth
import GoogleSignIn
import Firebase
struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var editingEmailTextfield: Bool = false
    @State private var editingPasswordTextfield: Bool = false
    @State private var emailIconBounce: Bool = false
    @State private var passwordIconBounce: Bool = false
    @State private var showProfileView: Bool = false
    @State private var signUpToggle:  Bool = true
    @State private var rotationAngle = 0.0
    @State private var signInWithAppleObject = SigninWithAppleObject()
    @State private var fadeToggle : Bool = true
    //used to generate haptics
    private let generator = UISelectionFeedbackGenerator()
    
    @State private var showAlertView: Bool = false
    @State private var alertTitle: String =  ""
    @State private var alertMessage: String = ""
    
    // Loading Indicator...
    @State var isLoading: Bool = false
    
    @AppStorage("log_Status") var log_Status = false
    
    var  body: some View{
        ZStack {
            Image(signUpToggle ? "background-3" :"background-1" )
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                .opacity(fadeToggle ? 1.0 : 0.0)
            Color("Transition")
                .edgesIgnoringSafeArea(.all)
                .opacity(fadeToggle ? 0.0 : 1.0)
            
            VStack {
                VStack(alignment: .leading, spacing: 16) {
                    Text(signUpToggle ? "Sign Up" : "Sign in")
                        .font(Font.largeTitle.bold())
                        .foregroundColor(.white)
                    Text("Your personal mental health diary!")
                        .font(.subheadline)
                        .foregroundColor(Color.white.opacity(0.7))
                    HStack (spacing: 12.0){
                        TextFieldIcon(iconName: "envelope.open.fill", currentlyEditing: $editingEmailTextfield, passedImage: .constant(nil))
                            .scaleEffect(emailIconBounce ? 1.2 : 1.0)
                        TextField("Email", text:$email){
                            isEditing  in
                            editingEmailTextfield = isEditing
                            editingPasswordTextfield = false
                            generator.selectionChanged()
                            if isEditing {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.5)){
                                    emailIconBounce.toggle()
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25)
                                {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.5)){
                                        emailIconBounce.toggle()
                                    }
                                }
                            }
                        }
                        .colorScheme(.dark)
                        .foregroundColor(Color.white.opacity(0.7))
                        .autocapitalization(.none)
                        .textContentType(.emailAddress)
                    }
                    .frame(height:52)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white,lineWidth: 1.0)
                            .blendMode(.overlay)
                    )
                    .background(
                        Color("secondaryBackground")
                            .cornerRadius(16)
                            .opacity(0.8)
                    )
                    HStack (spacing: 12.0){
                        TextFieldIcon(iconName: "key.fill", currentlyEditing: $editingPasswordTextfield, passedImage: .constant(nil))
                            .scaleEffect(passwordIconBounce ? 1.2 :1.0)
                        SecureField("Password", text:$password)
                            .colorScheme(.dark)
                            .foregroundColor(Color.white.opacity(0.7))
                            .autocapitalization(.none)
                            .textContentType(.password)
                    }
                    .frame(height:52)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white,lineWidth: 1.0)
                            .blendMode(.overlay)
                    )
                    .background(
                        Color("secondaryBackground")
                            .cornerRadius(16)
                            .opacity(0.8)
                    )
                    .onTapGesture {
                        editingPasswordTextfield = true
                        editingEmailTextfield = false
                        generator.selectionChanged()
                        if editingPasswordTextfield {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.5)){
                                passwordIconBounce.toggle()
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25){
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.5)){
                                    passwordIconBounce.toggle()
                                }
                            }
                        }
                    }
                    GradientButton(buttonTitle:  signUpToggle ? "Create Account"  : "Sign in") {
                        generator.selectionChanged()
                        SignUp()
                    }
                    
                    .onAppear{
                        Auth.auth().addStateDidChangeListener{
                            auth, user in
                            if user != nil {
                                showProfileView.toggle()
                            }
                        }
                    }
                    if signUpToggle
                    { Text("By clicking on Sign up you agree to our terms of service and Privacy policy")
                        .font(.footnote)
                        .foregroundColor(.white.opacity(0.7))
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color.white.opacity(0.1))}
                    
                    VStack(alignment: .leading, spacing: 16, content: {
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.35)){
                                fadeToggle.toggle()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35){
                                    withAnimation(.easeInOut(duration: 0.35)){
                                        fadeToggle.toggle()
                                        
                                    }
                                }
                            }
                            // print("Switch to Sign in")
                            withAnimation(.easeInOut(duration: 0.7))
                            {
                                signUpToggle.toggle()
                                self.rotationAngle += 180
                            }
                        }, label: {
                            HStack(spacing: 4){
                                Text(signUpToggle ? "Already have an account?" : "Don't have  an account?")
                                    .font(.footnote)
                                    .foregroundColor(Color.white.opacity(0.7))
                                GradientText(text: signUpToggle ? "Sign in" : "Sign up")
                                    .font(Font.footnote.bold())
                            }
                        })
                        if !signUpToggle{
                            Button(action: {
                                sendPasswordResetEmail()
                            }, label: {
                                HStack(spacing: 4){
                                    Text("Forgot password?")
                                        .font(.footnote)
                                        .foregroundColor(.white.opacity(0.7))
                                    GradientText(text:"Reset Password")
                                        .font(.footnote.bold())
                                }
                            })
                            Rectangle()
                                .frame(height:1)
                                .foregroundColor(.white.opacity(0.1))
                            Button(action: {
                                //  print("Sign in with Apple")
                                signInWithAppleObject.signInWithApple()
                            }, label: {
                                SignInWithAppleButton()
                                    .frame(height:50)
                                    .cornerRadius(16)
                            })
                            Button(action: {
                                // handleLogin()
                                GoogleSignIn()
                                 print("google login")
                             },label: {
                                 HStack(spacing:0.5){
                                    Image("google")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                        .padding(1)
                                    Text("Sign in with Google")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                }
                                .foregroundColor(Color(.white))
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: 50)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color.black)
                                )
                            }
                          )
                                .onAppear(){
                                    if !log_Status{
                                        // Home View...
                                            showProfileView.toggle()
                                    }
                                }
                        }
                        
                    })
                }
                .padding(20)
            }
            .rotation3DEffect(
                Angle(degrees: self.rotationAngle),
                axis: (x: 0.0, y: 1.0, z: 0.0)
            )
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.white.opacity(0.2))
                    .background(Color("secondaryBackground").opacity(0.5))
                    .background(VisualEffectBlur(blurStyle: .systemThinMaterialDark))
                    .shadow(color: Color("shadowColor").opacity(0.5), radius: 60, x: 0, y: 30)
            )
            .cornerRadius(30)
            .padding(.horizontal)
            
            .rotation3DEffect(
                Angle(degrees: self.rotationAngle),
                axis: (x: 0.0, y: 1.0, z: 0.0)
            )
            .alert(isPresented: $showAlertView){
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .cancel() )
            }
        }
        //ino cm kon
        // ProfileView() bud (safe ke baz beshe in mimune)
                .fullScreenCover(isPresented: $showProfileView){
                  // MenuView()
                    ProfileView()
               }
        //ta inja
        
    }
    func SignUp() {
        if signUpToggle  {
            Auth.auth().createUser(withEmail: email, password: password){
                result,error  in
                guard error == nil else {
                    self.alertTitle = "Uh-oh!"
                    self.alertMessage = error!.localizedDescription
                    self.showAlertView.toggle()
                    return
                }
            }
        }
        else{
            Auth.auth().signIn(withEmail: email, password: password){
                result,error in
                guard error == nil else{
                    self.alertTitle = "Uh-oh!"
                    self.alertMessage = error!.localizedDescription
                    self.showAlertView.toggle()
                    return
                }
            }
        }
    }
    func GoogleSignIn(){
        
        // Google Sign in...
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        isLoading = true
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: getRootViewController()) {
            [self] user, err in
            
            if let error = err {
                isLoading = false
                print(error.localizedDescription)
              return
            }

            guard
              let authentication = user?.authentication,
              let idToken = authentication.idToken
            else {
                isLoading = false
              return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)
            
            // Firebase Auth...
            Auth.auth().signIn(with: credential) {
                result, err in
                
                isLoading = false
                
                if let error = err {
                    print(error.localizedDescription)
                  return
                }
                
                // Displaying User Name...
                guard let user = result?.user
                else {
                    return
                }

                print(user.displayName ?? " Google Sign In Success!")
                // Updating User as Logged in
                withAnimation {
                    log_Status = true
                }
            }
        }
    }
    
    func  sendPasswordResetEmail(){
        Auth.auth().sendPasswordReset (withEmail: email){
            error in
            guard error == nil else{
                self.alertTitle = "Uh-oh!"
                self.alertMessage = error!.localizedDescription
                self.showAlertView.toggle()
                return
            }
            alertTitle = "Password reset email sent"
            alertMessage = "Check your inbox for an email to reset your password"
            self.showAlertView.toggle()

        }
    }
}


// Extending View to get SCreen Bounds... (GSignin)
extension View{
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
    
    // Retreiving RootView COntroller...
    func getRootViewController()->UIViewController{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else{
            return .init()
        }
        
        return root
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
