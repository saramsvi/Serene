//
//  CoursesView.swift
//  SereneBeta
//
//  Created by MSVI on 28.08.21.
//
import SwiftUI
public struct EntriesView: View {
    public init() {}
    @State var search = ""
    @State var show = false
    @Namespace var namespace
    @Namespace var namespace2
    @State var selectedItem: Entry? = nil
    @State var isDisabled = false
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    public var body: some View {
        ZStack {

            if horizontalSizeClass == .compact {
                // tabBar
                //MenuView()
              //  CustomTabBar()
                content
                    .navigationBarHidden(true)
                    .background(GlassBackground())
                    
            }
//            } else {
//                //SideBar
//                //MenuView()
////                CustomTabBar()
//            }
            fullContent
                .background(VisualEffectBlur(blurStyle: .systemMaterial).edgesIgnoringSafeArea(.all))
               
        }
        .navigationTitle("Entries")
        //added for tabbar
        .padding(.bottom,55)
    }
    //SEARCHING BY DATE SHOULD BE ADDED HERE
    
    var content: some View{
        ScrollView {
            VStack(spacing: 0) {
                LazyVGrid(
                    columns: [GridItem(.adaptive(minimum: 160), spacing: 16)],
                    spacing: 16
                ) {
                    ForEach(entries) { item in
                        VStack {
                            EntryItem(entry: item)
                                .matchedGeometryEffect(id: item.id, in: namespace, isSource: !show)
                                .frame(height: 200)
                                .onTapGesture {
                                    withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0)) {
                                        show.toggle()
                                        selectedItem = item
                                        isDisabled = true
                                    }
                                }
                                .disabled(isDisabled)
                        }
                        .matchedGeometryEffect(id: "container\(item.id)", in: namespace, isSource: !show)
                    }
                }
                .padding(16)
                .frame(maxWidth: .infinity)
                
            }
            
//            .background(GlassBackground())
            
        }
        .zIndex(1)
        .navigationTitle("Entries")
        .edgesIgnoringSafeArea(.horizontal)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(
                    action:{
                        print("I was clicked!")
                    }){
                        Image(systemName: "calendar")
                    }
                Button(
                    action:{
                        print("I was clicked!")
                    }){
                        Image(systemName: "arrow.up.arrow.down")
                    }
                 }
             }
    }  
    @ViewBuilder
    var fullContent: some View {
        if selectedItem != nil {
            ZStack(alignment: .topTrailing) {
                //EntryDetail(course: selectedItem!, namespace: namespace)
                //ehtemalan inja bayad avaz beshe
                EntryDetail(entry: selectedItem!, namespace: namespace)
                CloseButton()
                    .padding(16)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            show.toggle()
                            selectedItem = nil
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                isDisabled = false
                            }
                        }
                    }
            }
        
            .zIndex(2)
            .frame(maxWidth: 712)
            .frame(maxWidth: .infinity)
        }
    }
    

//    var tabBar: some View {
//        TabView {
//            NavigationView {
//                // CourseList()
//               // signoutView()
//            }
//            .tabItem {
//                Image(systemName: "house")
//                Text("Home")
//            }
//            NavigationView {
//                // CourseList()
//            }
//            .tabItem {
//                Image(systemName: "chart.bar.doc.horizontal")
//                Text("Analyze")
//            }
//            NavigationView {
//                content
//            }
//            .tabItem {
//                Image(systemName: "books.vertical")
//                Text("Entries")
//            }
//
////            NavigationView {
////                AccountView().body
////            }
//            AccountView()
//            .tabItem {
//                Image(systemName: "person")
//                Text("Account")
//
//            }
//        }
//    }
   // @ViewBuilder
//  //  var SideBar: some View {
//        NavigationView {
//            List {
//                NavigationLink(destination: AccountView()) {
//                    Label("Account", systemImage: "person")
//                }
////                NavigationLink(destination: signoutView()) {
////                    Label("Home", systemImage: "house")                }
//
//                Label("Analyze", systemImage: "chart.bar.doc.horizontal")
//                NavigationLink(destination: content) {
//                    Label("Entries", systemImage: "books.vertical")
//                }
//            }
//            .listStyle(SidebarListStyle())
//            .navigationTitle("Serene Diary")
//
//            content
//        }
//
//    }
}
    

struct EntriesView_Previews: PreviewProvider {
    static var previews: some View {
        EntriesView()
            .previewInterfaceOrientation(.portrait)
    }
}
