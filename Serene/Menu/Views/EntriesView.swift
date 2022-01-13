//
//  CoursesView.swift
//  SereneBeta
//
//  Created by MSVI on 28.08.21.
//
import SwiftUI
struct EntriesView: View {
    
    @State var search = ""
    @State var show = false
    @Namespace var namespace
    @Namespace var namespace2
    @State var selectedItem: Entry? = nil
    @State var isDisabled = false
    
#if os(iOS)
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
#endif
    
    var body: some View {
        ZStack {
#if os(iOS)
            if horizontalSizeClass == .compact {
                tabBar
            } else {
                SideBar
            }
            fullContent
                .background(VisualEffectBlur(blurStyle: .systemMaterial).edgesIgnoringSafeArea(.all))
#else
            content
            fullContent
                .background(VisualEffectBlur().edgesIgnoringSafeArea(.all))
#endif
        }
        .navigationTitle("Entries")
    }
    //SEARCHING BY DATE SHOULD BE ADDED HERE
    
    var content: some View {
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
            
#if os(iOS)
            .background(GlassBackground())
#endif
        }
        .zIndex(1)
        .navigationTitle("Entries")
        .edgesIgnoringSafeArea(.horizontal)
#if os(iOS)
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
#else
        .toolbar {
            Button(
                action:{
                    print("I was clicked!!!!!!!!")
                }){
                    Image(systemName: "arrow.up.arrow.down")
                }
            
            Button(
                action:{
                    print("I was clicked!!!!!!!")
                })
            {
                    Image(systemName: "calendar")
            }
        }
   
#endif
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
    var tabBar: some View {
        TabView {
            NavigationView {
                // CourseList()
            }
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            NavigationView {
                // CourseList()
            }
            .tabItem {
                Image(systemName: "chart.bar.doc.horizontal")
                Text("Analyze")
            }
            NavigationView {
                content
            }
            .tabItem {
                Image(systemName: "books.vertical")
                Text("Entries")
            }
            NavigationView {
          //  AccountView()
            }
            .tabItem {
                Image(systemName: "person")
                Text("Account")
            }
        }
    }
    @ViewBuilder
    var SideBar: some View {
#if os(iOS)
        NavigationView {
            List {
//                NavigationLink(destination: AccountView()) {
//                    Label("Account", systemImage: "person")
//                }
                Label("Home", systemImage: "house")
                Label("Analyze", systemImage: "chart.bar.doc.horizontal")
                NavigationLink(destination: content) {
                    Label("Entries", systemImage: "books.vertical")
                }
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Serene Diary")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button {
//                        print("account page ")
//                    } label: {
//                        Image(systemName: "person.crop.circle")
//                    }
//                }
//            }
            content
        }
#endif
    }
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        EntriesView()   
    }
}
