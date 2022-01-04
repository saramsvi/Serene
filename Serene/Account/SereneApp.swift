//
//  SereneApp.swift
//  Serene
//
//  Created by MSVI on 4.12.21.
//

import SwiftUI
import Firebase

@main
struct SereneApp: App {
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
