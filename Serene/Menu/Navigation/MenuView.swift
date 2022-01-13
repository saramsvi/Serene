//
//  ContentView.swift
//  Shared
//
//  Created by MSVI on 28.08.21.
//
import SwiftUI

struct MenuView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
   
    
    @ViewBuilder
    var body: some View {
        if horizontalSizeClass == .compact {
            EntriesView()
        } else {
            EntriesView()
        }
//        #else
//        SideBar()
//            .frame(minWidth: 1000, minHeight: 600)
//        #endif
    }
}
struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MenuView()
        }
    }
}
