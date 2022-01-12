//
//  ProfileView.swift
//  Authorization(iOS)
//
//  Created by MSVI on 15.09.21.
//

import SwiftUI
//import Purchases
import FirebaseAuth
import CoreData
private let generator = UISelectionFeedbackGenerator()

struct ProfileView: View {
    
    @State private var showLoader: Bool = false
    @State private var continueButtonTitle  = "Continue"
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showAlertView: Bool = false
    @State private var alertTitle: String =  ""
    @State private var alertMessage: String = ""
    @State private var showSettingsView: Bool = false
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Account.userSince, ascending: true)], predicate: NSPredicate(format: "userID == %@", Auth.auth().currentUser!.uid), animation: .default) private var  savedAccounts: FetchedResults<Account>
    @State private var currentAccount : Account?
    
    @State private var updater: Bool = true
    
    var body: some View {
        ZStack{
            Image("background-2")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
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
                            Text(currentAccount?.name  ??  "No name")
                                .foregroundColor(.white)
                                .font(.title2)
                                .bold()
                            Text(currentAccount?.surname  ??  "No surname")
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
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.white.opacity(0.1))
                   
                       
                    
//                    Rectangle()
//                        .frame(height: 1)
//                        .foregroundColor(.white.opacity(0.1))
//                    Text(currentAccount?.bio ?? "No Bio")
//                        .foregroundColor(.white)
//                        .font(.title2)
//                        .bold()
//
//                        Rectangle()
//                            .frame(height: 1)
//                            .foregroundColor(Color.white.opacity(0.1))
//
                    
                    HStack(spacing: 16) {
//                        if currentAccount?.name != nil {
//                            Image(systemName: "person.text.rectangle")
//                                .resizable()
//                                .frame(width: 24, height: 24, alignment: .center)
//                                .foregroundColor(Color.white.opacity(0.7))
//                        }
//                        if currentAccount?.website != nil {
//                            Image(systemName: "link")
//                                .foregroundColor(Color.white.opacity(0.7))
//                                .font(.system(size: 17, weight: .semibold))
//                            Text(currentAccount?.website ?? "No website")
//                                .foregroundColor(Color.white.opacity(0.7))
//                                .font(.footnote)
//                        }
                        Label("A member since \(dateFormatter(currentAccount?.userSince ?? Date()))", systemImage: "calendar")
                            .foregroundColor(.white.opacity(0.7))
                            .font(.footnote)
                    
                    }
                }
                .padding(16)
                // the button that  takes you to main menu  after registration
                GradientButton(buttonTitle: continueButtonTitle) {
                    generator.selectionChanged()
                       
                }
                .padding(.horizontal,16)
                
                .padding(.bottom)
            }
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.white.opacity(0.2))
                    .background(Color("secondaryBackground").opacity(0.5))
                    .background(VisualEffectBlur(blurStyle: .dark))
                    .shadow(color: Color("shadowColor").opacity(0.5), radius: 60, x: 0, y: 30)
            )
            .cornerRadius(30)
            .padding(.horizontal)
            
            VStack {
                Spacer()
                Button(action:{
                    //  print("sign out")
                    signout()
                    
                },
                       label: {
                    Image(systemName: "arrow.turn.up.forward.iphone.fill")
                    
                    
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .rotation3DEffect(
                            Angle(degrees: 180),
                            axis: (x: 0.0, y: 0.0, z: 1.0)
                        )
                        .background(
                            Circle()
                                .stroke(Color.white.opacity(0.2), lineWidth: 1)
                                .frame(width: 42, height: 42, alignment: .center)
                                .overlay(VisualEffectBlur(blurStyle: .dark).cornerRadius(21))
                                .frame(width: 42, height: 42, alignment: .center)
                        )
                })
            }
            .padding(.bottom,64)
            
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
        
                //add  data to core data
                let userDataToSave = Account(context: viewContext)
                userDataToSave.name = Auth.auth().currentUser!.displayName
                userDataToSave.userID = Auth.auth().currentUser!.uid
              //  userDataToSave.bio = nil
               // userDataToSave.numberOfCertificates = 0
                userDataToSave.userSince = Date()
               // userDataToSave.proMember = false
                userDataToSave.surname = nil
               // userDataToSave.website = nil
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

    func  dateFormatter(_ date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat  = "MMMM yyyy"
        return formatter.string(from: date)
    }
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
}
