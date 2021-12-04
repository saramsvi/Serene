//
//  SereneApp.swift
//  Serene
//
//  Created by MSVI on 4.12.21.
//

import SwiftUI

@main
struct SereneApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
