////
////  ProfileRow.swift
////  Serene
////
////  Created by MSVI on 2.05.22.
////
//
//import SwiftUI
//import CoreData
//import FirebaseAuth
//import CloudKit
//
//struct ProfileRow: View {
//    @State private var alertTitle: String =  ""
//    @State private var alertMessage: String = ""
//    @State private var showSettingsView: Bool = false
//    @State private var showAlertView: Bool = false
//    @State private var updater: Bool = true
//    @State private var showLoader: Bool = false
//    @Environment(\.managedObjectContext) private var viewContext
//    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Account.userSince, ascending: true)], predicate: NSPredicate(format: "userID == %@", Auth.auth().currentUser!.uid), animation: .default) private var  savedAccounts: FetchedResults<Account>
//    @State private var currentAccount : Account?
//    var body: some View {
//        ZStack(){
//            VStack {
//                VStack(alignment: .leading, spacing: 16){
//                    HStack(spacing: 16){
//                        if  currentAccount?.profileImage != nil {
//                            GradientProfilePictureView(profilePicture: UIImage(data:currentAccount!.profileImage!)!)
//                                .frame(width: 66, height: 66, alignment: .center)
//                                .frame(width: 66, height: 66, alignment: .center)
//                        } else{
//                            ZStack {
//                                Circle()
//                                    .foregroundColor(Color("pink-gradient-1"))
//                                    .frame(width: 66, height: 66, alignment: .center)
//                                Image(systemName: "person.fill")
//                                    .foregroundColor(.white)
//                                    .font(.system(size: 24, weight: .medium, design: .rounded))
//                            }
//                        }
//                        
//                        VStack(alignment: .leading) {
//                            Text(currentAccount?.name  ??  "Name")
//                                .foregroundColor(.white)
//                                .font(.title2)
//                                .bold()
//                            Text(currentAccount?.surname  ??  "Surname")
//                                .foregroundColor(.white .opacity(0.7))
//                                .font(.footnote)
//                        }
//                        Spacer()
//                        Button(action: {
//                            showSettingsView.toggle()
//                            
//                        }
//                               , label: {
//                            TextFieldIcon(iconName: "gearshape.fill", currentlyEditing: .constant(true), passedImage: .constant(nil))
//                        })
//                    }
//                }
//                .padding(20)
//            }
//           // .background(Color("secondaryBackground").opacity(0.3))
//            .background(VisualEffectBlur(blurStyle: .systemThinMaterialDark))
//            .overlay(RoundedRectangle(cornerRadius: 20,style: .continuous).stroke(Color.white,lineWidth: 1).blendMode(.overlay))
//            .mask(RoundedRectangle(cornerRadius: 20,style: .continuous))
//            .padding(.top,20)
//            
//            .cornerRadius(20)
//            
//            .padding(.horizontal, 20)
//          //  .padding(.top, 40)
//            if showLoader {
//                progressViewStyle(CircularProgressViewStyle())
//            }
//        
//        }
//        .colorScheme(updater ? .dark : .dark)
//        .alert(isPresented: $showAlertView){
//            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .cancel())
//        }
//        .sheet(isPresented: $showSettingsView, content: {
//            SettingsView()
//                .environment(\.managedObjectContext, self.viewContext)
//                .onDisappear(){
//                    currentAccount = savedAccounts.first!
//                    updater.toggle()
//                }
//        })
//        .onAppear(){
//            currentAccount = savedAccounts.first
//            if currentAccount == nil{
//                let userDataToSave = Account(context: viewContext)
//                userDataToSave.name = Auth.auth().currentUser!.displayName
//                userDataToSave.userID = Auth.auth().currentUser!.uid
//                userDataToSave.userSince = Date()
//                userDataToSave.surname = nil
//                userDataToSave.profileImage = nil
//                do{
//                    try viewContext.save()
//                }
//                catch let error {
//                    alertTitle = "Could not create an account!"
//                    alertMessage = error.localizedDescription
//                    showAlertView.toggle()
//                }
//            }
//        }
//    }
//}
//
//struct ProfileRow_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileRow()
//    }
//}
