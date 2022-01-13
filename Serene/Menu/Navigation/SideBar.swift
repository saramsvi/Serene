////
////  SideBar.swift
////  SereneBeta
////
////  Created by MSVI on 28.08.21.
////for macos
//
//import SwiftUI
//
//
//struct SideBar: View {
//    var body: some View {
//        NavigationView {
//          //  #if os(iOS)
//            content
//                .navigationTitle("Serene Diary")
////                .toolbar {
////                    ToolbarItem(placement: .navigationBarTrailing) {
////                        Image(systemName: "person.crop.circle")
////                    }
////               }
////            #else
////            content
////                .frame(minWidth: 200, idealWidth: 250, maxWidth: 300)
//////                .toolbar {
//////                    ToolbarItem(placement: .automatic) {
//////                        Button(action: {}) {
//////                            Image(systemName: "person.crop.circle")
//////                        }
//////                    }
////               // }
////            #endif
//            EntriesView()
//        }
//    }
//    var content: some View {
//        List {
//            NavigationLink(destination: AccountView()) {
//                Label("Account", systemImage: "person")
//                Rectangle()
//                    .frame(height: 0.5)
//                    .foregroundColor(.white.opacity(0.1))
//            }
//            Label("Home", systemImage: "house")
//            Label("Analyze", systemImage: "chart.bar.doc.horizontal")
//            
//            NavigationLink(destination: EntriesView()) {
//                Label("Entries", systemImage: "books.vertical")
//            }
//            
//            Label("FAQ", systemImage: "questionmark.square")
//        }
//        .listStyle(SidebarListStyle())
//    }
//}
//
//struct SideBar_Previews: PreviewProvider {
//    static var previews: some View {
//        SideBar()
//    }
//}
