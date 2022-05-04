//
//  CustomTabBar.swift
//  Serene
//
//  Created by MSVI on 23.01.22.
//


import SwiftUI


// This App will work for Both iOS 14/15....
struct CustomTabBar: View {
    
    // Current Tab...
    @State var currentTab: Tab = .Home
    
    // Hiding Native One...
    init(){
        UITabBar.appearance().isHidden = true
    }
    // Matched Geomtery effect..
    @Namespace var animation
    // Current Tab XValue...
    @State var currentXValue: CGFloat = 0
    @ViewBuilder
    var body: some View {
        TabView(selection: $currentTab) {
            Text("Home")
                .frame(maxWidth: .infinity,maxHeight: .infinity)
                .background(Color.black.ignoresSafeArea())
                .tag(Tab.Home)
            Text("Home")
                .frame(maxWidth: .infinity,maxHeight: .infinity)
                .background(Color.black.ignoresSafeArea())
            //inja 
           //ProfileView()
            Text("pro")

                .tag(Tab.Analyze)
                EntriesView()
               .tag(Tab.Entries)
            
            NavigationView(){
                AccountView()
            }
            .animation(nil)
            .tag(Tab.Account)
        }
     
        // Curved Tab Bar...
        .overlay(
            HStack(spacing: 0){
                
                ForEach(Tab.allCases,id: \.rawValue){tab in
                    
                    TabButton(tab: tab)
                }
            }
                .padding(.vertical)
            // Preview wont show safeArea...
                .padding(.bottom,getSafeArea().bottom == 0 ? 10 : (getSafeArea().bottom - 10))
                .background(
                    
                    MaterialEffect(style: .systemUltraThinMaterialDark)
                        .clipShape(BottomCurve(currentXValue: currentXValue))
                )
            
            ,alignment: .bottom
        )
        .ignoresSafeArea(.all, edges: .bottom)
        // Always Dark...
       // .preferredColorScheme(.dark)
    }
    
    
    // TabButton...
    @ViewBuilder
    func TabButton(tab: Tab)->some View{
        
        // Since we need XAxis Value for Curve...
        GeometryReader{proxy in
            
            Button {
                withAnimation(.spring()){
                    currentTab = tab
                    // updating Value...
                    currentXValue = proxy.frame(in: .global).midX
                }
            } label: {
                
                // Moving Button up for current Tab...
                Image(systemName: tab.rawValue)
                // Since we need perfect value for Curve...
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding(currentTab == tab ? 15 : 0)
                    .background(
                        
                        ZStack{
                            
                            if currentTab == tab{
                                
                                MaterialEffect(style: .systemChromeMaterialDark)
                                    .clipShape(Circle())
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            }
                        }
                    )
                    .contentShape(Rectangle())
                    .offset(y: currentTab == tab ? -50 : 0)
            }
            // Setting intial Curve Position...
            .onAppear {
                
                if tab == Tab.allCases.first && currentXValue == 0{
                    
                    currentXValue = proxy.frame(in: .global).midX
                }
            }
        }
        .frame(height: 30)
        // MaxSize...
    }
      
}
struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar()
    }
}
// To Iterate...
// Enum for Tab....
enum Tab: String,CaseIterable{
    case Home = "house.fill"
    case Analyze = "chart.bar.doc.horizontal"
    case Entries = "books.vertical"
    case Account = "person.fill"
}
// Getting Safe Area...
extension View{
    func getSafeArea()->UIEdgeInsets{
        
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else{
            return .zero
        }
        
        return safeArea
    }
}
