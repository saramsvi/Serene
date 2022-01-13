//
//  SereneApp.swift
//  Serene
//
//  Created by MSVI on 4.12.21.
//

import SwiftUI
import Firebase
import GoogleSignIn
@main
struct SereneApp: App {
    // Connecting App Delegate...
   // @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    let persistenceController = PersistenceController.shared
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            SignUpView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

//Google SignIn
//
//class AppDelegate: NSObject, UIApplicationDelegate{
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        
//        // Intialzing Firebase
//        FirebaseApp.configure()
//        
//        return true
//    }
//    
//    func application(_ application: UIApplication, open url: URL,
//                     options: [UIApplication.OpenURLOptionsKey: Any])
//      -> Bool {
//      return GIDSignIn.sharedInstance.handle(url)
//    }
//}
