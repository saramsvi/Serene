//
//  AccountView.swift
//  Serene
//
//  Created by MSVI on 13.01.22.
//

import SwiftUI
import CloudKit
import CoreData
import FirebaseAuth
struct AccountView: View  {
    @State private var currentAccount : Account?

    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Account.userSince, ascending: true)], predicate: NSPredicate(format: "userID == %@", Auth.auth().currentUser!.uid), animation: .default) private var  savedAccounts: FetchedResults<Account>
    
    @State private var contentOffset = CGFloat(0)
    private let generator = UISelectionFeedbackGenerator()
    @State private var showAlertView: Bool = false
    @State private var alertTitle: String =  ""
    @State private var alertMessage: String = ""
    @State private var showSettingsView: Bool = false
    @State private var showMenuView: Bool = false
    @State private var updater: Bool = true
    @State private var showLoader: Bool = false
    
    
    var body: some View {
        
        ZStack(alignment: .top){
            TrackableScrollView(offsetChanged: {
                offset in
                contentOffset = offset.y
            })
            {
                
                profileContent
                settingsContent
                content
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(AccountBackground())
        .navigationBarHidden(true)
    }
    @ViewBuilder
    var settingsContent: some View{
        VStack {
            VStack(spacing: 0){
                LanguageRow()
                divider
                NotificationsRow()
                divider
                LiteModeRow()
                
            }
            .padding(7)
            .background(VisualEffectBlur(blurStyle: .systemThinMaterialDark))
            .overlay(RoundedRectangle(cornerRadius: 20,style: .continuous).stroke(Color.white,lineWidth: 1).blendMode(.overlay))
            .mask(RoundedRectangle(cornerRadius: 20,style: .continuous))
            
        }
        .foregroundColor(Color.white)
        .padding(.top,20)
        .padding(.horizontal,20)
    }
 
    @ViewBuilder
    var content: some View {
        VStack {
            VStack(spacing: 0){
                
                NavigationLink(destination: FAQView()){
                    let localizedFAQ = LocalizedStringKey("FAQ")
                    MenuRow(rowTitle: localizedFAQ.stringValue(),leftIcon: TextFieldIcon(iconName: "questionmark", currentlyEditing: .constant(true), passedImage:.constant(nil)), rightIcon: "chevron.right")
                }
                divider
                NavigationLink(destination: ContactView()){
                    let localizedContacts = LocalizedStringKey("Contacts")
                    MenuRow(rowTitle: localizedContacts.stringValue(),leftIcon: TextFieldIcon(iconName: "mail", currentlyEditing: .constant(true), passedImage:.constant(nil)), rightIcon: "chevron.right")
                    
                }
                divider
                
                Link(destination: URL(string: "https://www.apple.com")!,
                     label: {
                    let localizedRate = LocalizedStringKey("RateUs")
                    MenuRow(rowTitle: localizedRate.stringValue(),leftIcon: TextFieldIcon(iconName: "applelogo", currentlyEditing: .constant(true), passedImage:.constant(nil)), rightIcon: "link")
                })
                
            }
            .padding(7)
            // .background(Color("secondaryBackground").opacity(0.3))
            .background(VisualEffectBlur(blurStyle: .systemThinMaterialDark))
            .overlay(RoundedRectangle(cornerRadius: 20,style: .continuous).stroke(Color.white,lineWidth: 1).blendMode(.overlay))
            .mask(RoundedRectangle(cornerRadius: 20,style: .continuous))
            .padding(.top,-10)
            let localizedButton = LocalizedStringKey("Sign Out")
            GradientButton(buttonTitle: localizedButton.stringValue(), buttonAction: {
                generator.selectionChanged()
                signout()
                
            })
                .padding(.top,20)
            
            Text("Version")
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
    
    
    
    @ViewBuilder
    var profileContent: some View{
        ZStack{
            VStack {
                VStack(alignment: .leading, spacing: 16){
                    HStack(spacing: 16){
                        if  currentAccount?.profileImage != nil {
                            GradientProfilePictureView(profilePicture: UIImage(data:currentAccount!.profileImage!)!)
                                .frame(width: 66, height: 66, alignment: .center)
                                .frame(width: 66, height: 66, alignment: .center)
                        } else{
                            ZStack {
                                Circle()
                                    .foregroundColor(Color("pink-gradient-1"))
                                    .frame(width: 66, height: 66, alignment: .center)
                                Image(systemName: "person.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size: 24, weight: .medium, design: .rounded))
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            Text(currentAccount?.name  ??  "Name")
                                .foregroundColor(.white)
                                .font(.title2)
                                .bold()
                            Text(currentAccount?.surname  ??  "Surname")
                                .foregroundColor(.white .opacity(0.7))
                                .font(.footnote)
                        }
                        Spacer()
                        Button(action: {
                            showSettingsView.toggle()
                            
                        }
                               , label: {
                            TextFieldIcon(iconName: "gearshape.fill", currentlyEditing: .constant(true), passedImage: .constant(nil))
                        })
                    }
                }
                .padding(20)
            }
            // .background(Color("secondaryBackground").opacity(0.3))
            .background(VisualEffectBlur(blurStyle: .systemThinMaterialDark))
            .overlay(RoundedRectangle(cornerRadius: 20,style: .continuous).stroke(Color.white,lineWidth: 1).blendMode(.overlay))
            .mask(RoundedRectangle(cornerRadius: 20,style: .continuous))
            .padding(.top,20)
            
            .cornerRadius(20)
            
            .padding(.horizontal, 20)
            //  .padding(.top, 40)
            if showLoader {
                progressViewStyle(CircularProgressViewStyle())
            }
            
        }
        .colorScheme(updater ? .dark : .dark)
        
        .alert(isPresented: $showAlertView){
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .cancel())
        }
        .sheet(isPresented: $showSettingsView, content: {
            SettingsView()
                .environment(\.managedObjectContext, self.viewContext)
                .onDisappear(){
                    currentAccount = savedAccounts.first!
                    updater.toggle()
                }
        })
        .onAppear(){
            
            currentAccount = savedAccounts.first
            if currentAccount == nil{
                let userDataToSave = Account(context: viewContext)
                userDataToSave.name = Auth.auth().currentUser!.displayName
                userDataToSave.userID = Auth.auth().currentUser!.uid
                userDataToSave.userSince = Date()
                userDataToSave.surname = nil
                userDataToSave.profileImage = nil
                do{
                    try viewContext.save()
                }
                catch let error {
                    alertTitle = "Could not create an account!"
                    alertMessage = error.localizedDescription
                    showAlertView.toggle()
                }
            }
        }
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
