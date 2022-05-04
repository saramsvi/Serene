//
//              SettingsView.swift
//  Authorization(iOS)
//
//  Created by MSVI on 19.10.21.
//


import SwiftUI
import FirebaseAuth


struct SettingsView: View {
    @State private var editingNameTextField = false
    @State private var editingSurnameTextField = false

    @State private var nameIconBounce = false
    @State private var surnameIconBounce = false
    //    @State private var bioIconBounce = false
    //    @State private var siteIconBounce = false
    
    @State private var name = ""
    @State private var surname = ""
    //    @State private var bio = ""
    //    @State private var site = ""
    
    @State private var  showImagePicker = false
    @State  private var inputImage: UIImage?
    
    @State private var currentAccount: Account?
    @State private var showActionAlert = false
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    let generator = UISelectionFeedbackGenerator()
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Account.userSince, ascending: true)],
        predicate: NSPredicate(format: "userID == %@", Auth.auth().currentUser!.uid),
        animation: .default
    ) private var savedAccounts: FetchedResults<Account>

    let localizedSavedAlertTitle = LocalizedStringKey("Saved!")
    let localizedSavedAlertMsg = LocalizedStringKey("СhangesSaved")
    let localizedErrorAlertTitle = LocalizedStringKey("Uh-oh!")
    let localizedErrorAlertMsg = LocalizedStringKey("Tryagain")

    let localizedPhotoButton = LocalizedStringKey("ChoosePhoto")
    let localizedSaveButton = LocalizedStringKey("SaveButton")
    var body: some View {
        HStack() {
            
            VStack (alignment: .leading, spacing: 16){
                
                Text("Settings")
                    .foregroundColor(.white)
                    .font(.largeTitle.bold())
                    .padding(.top)
                Text("Manage your account!")
                    .foregroundColor(.white.opacity(0.7))
                    .font(.callout)
                
                Button{
                    self.showImagePicker = true
                    
                } label:{
                    HStack(spacing:12){

                        TextFieldIcon(iconName: "person.crop.circle", currentlyEditing: .constant(false), passedImage: $inputImage)
                        GradientText(text: localizedPhotoButton.stringValue())
                        Spacer()
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white
                                        .opacity(0.1),lineWidth: 1)
                    )
                    .background(
                        Color.init(red: 26/255, green: 20/255, blue: 51/255)
                            .cornerRadius(16)
                    )
                }
                
                GradientTextField(editingTextField: $editingNameTextField, textFieldString: $name, iconBounce: $nameIconBounce, textfieldPlaceHolder: "Name", textfieldIconString: "textformat.alt")
                    .autocapitalization(.words)
                    .textContentType(.name)
                    .disableAutocorrection(true)
                //Twitter TextField
                GradientTextField(editingTextField: $editingSurnameTextField, textFieldString: $surname, iconBounce: $surnameIconBounce, textfieldPlaceHolder: "Surname", textfieldIconString: "at")
                    .autocapitalization(.words)
                    .textContentType(.name)
                    .disableAutocorrection(true)
                

                GradientButton(buttonTitle: localizedSaveButton.stringValue()){
                    //save changes to Core Data
                    generator.selectionChanged()
                    currentAccount?.name = self.name
                    // currentAccount?.bio = self.bio
                    currentAccount?.surname = self.surname
                    currentAccount?.profileImage = self.inputImage?.pngData()
                    //   currentAccount?.website = self.site
                    do {
                        try viewContext.save()
                        alertTitle = localizedSavedAlertTitle.stringValue()
                        alertMessage = localizedSavedAlertMsg.stringValue()
                        showActionAlert.toggle()
                    } catch let error {
                        alertTitle = localizedErrorAlertTitle.stringValue()
                        alertMessage = localizedErrorAlertMsg.stringValue() + error.localizedDescription
                        showActionAlert.toggle()
                    }
                }
                Spacer()
            }
            .padding()
            Spacer()
        }
        //        .background(VisualEffectBlur(blurStyle: .systemUltraThinMaterial))
        .background(Color("settingsBackground"))
        
        .edgesIgnoringSafeArea(.all)
        .sheet(isPresented: $showImagePicker){
            ImagePicker(image: self.$inputImage)
        }
        .alert(isPresented: $showActionAlert, content: {
            Alert(title: Text(localizedSavedAlertTitle.stringValue()), message: Text(localizedSavedAlertMsg.stringValue()), dismissButton:  .default(Text("OK")))}
        )
        .onAppear() {
            // Check CloudKit
            currentAccount = savedAccounts.first!
            self.name = currentAccount?.name ?? ""
            //self.bio = currentAccount?.bio ?? ""
            self.surname = currentAccount?.surname ?? ""
            //  self.site = currentAccount?.website ?? ""
            self.inputImage = UIImage(data: currentAccount?.profileImage ?? Data())
        }
        
    }
}
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
