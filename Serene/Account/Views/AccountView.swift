//
//  AccountView.swift
//  Serene
//
//  Created by MSVI on 13.01.22.
//

import SwiftUI
import FirebaseAuth
import CoreData

struct AccountView: View  {

    @Environment(\.presentationMode) var presentationMode
    @State private var contentOffset = CGFloat(0)
    //signout
    private let generator = UISelectionFeedbackGenerator()
    @State private var showAlertView: Bool = false
    @State private var alertTitle: String =  ""
    @State private var alertMessage: String = ""
    @ViewBuilder
    var body: some View {
        
            ZStack(alignment: .top){
                
                Spacer()
                TrackableScrollView(offsetChanged: {
                    offset in
                    contentOffset = offset.y
                  //  print("contentOffset", contentOffset)
                })
                {
               
               content
                   
              }
                
                
                VisualEffectBlur(blurStyle: .systemMaterial)
                    .opacity(contentOffset < -18 ? 0.6 : 0)
                    .animation(.easeIn, value: contentOffset)
                    .ignoresSafeArea()
                    .frame(height: 30)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .background(AccountBackground())
            .navigationBarHidden(true)
             
    }
    var content: some View {
        VStack {
                VStack(spacing: 0){
                   
                    NavigationLink(destination: FAQView()){
                        MenuRow(rowTitle: "FAQ",leftIcon: TextFieldIcon(iconName: "questionmark", currentlyEditing: .constant(true), passedImage:.constant(nil)), rightIcon: "chevron.right")
                    }
           
                    divider
                    
                    NavigationLink(destination: ContactView()){
                        
                    MenuRow(rowTitle: "Contacts",leftIcon: TextFieldIcon(iconName: "mail", currentlyEditing: .constant(true), passedImage:.constant(nil)), rightIcon: "chevron.right")
                        
                    }
                    
                    
                    
                    divider
                   
                    Link(destination: URL(string: "https://www.apple.com")!,
                         label: {
                        MenuRow(rowTitle: "Rate Serene on the App Store!",leftIcon: TextFieldIcon(iconName: "applelogo", currentlyEditing: .constant(true), passedImage:.constant(nil)), rightIcon: "link")
                    })
                    
                }
                .padding(7)
                .background(Color("secondaryBackground").opacity(0.3))
                .background(VisualEffectBlur(blurStyle: .systemThinMaterialDark))
                .overlay(RoundedRectangle(cornerRadius: 20,style: .continuous).stroke(Color.white,lineWidth: 1).blendMode(.overlay))
                .mask(RoundedRectangle(cornerRadius: 20,style: .continuous))
            .padding(.top,20)
            

            GradientButton(buttonTitle: "Sign Out", buttonAction: {
                generator.selectionChanged()
                signout()
              
            })
                .padding(.top,20)
            
            Text("Version 1.00")
                .foregroundColor(.white.opacity(0.7))
                .padding(.top,20)
                .padding(.horizontal,20)
                .padding(.bottom,10)
                .font(.footnote)
        }
        .foregroundColor(Color.white)
        .padding(.top,20)
        .padding(.horizontal,20)
        .padding(.bottom, 10)
    }
    var divider: some View {
        Divider().background(Color.white.blendMode(.overlay))
    }
    func signout(){
        do {
            try Auth.auth().signOut()
            presentationMode.wrappedValue.dismiss()
        }
        catch let error{
            alertTitle =  "Uh-oh!"
            alertMessage = error.localizedDescription
            showAlertView.toggle()
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
