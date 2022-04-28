//
//  ContactView.swift
//  Serene
//
//  Created by MSVI on 15.01.22.
//

import SwiftUI

struct ContactView: View {
    @State private var contentOffset = CGFloat(0)
    var body: some View {
        ZStack (alignment:.top){
            TrackableScrollView(offsetChanged: {
                offsetPoint in
                contentOffset = offsetPoint.y
            }) {
            content
            }
            VisualEffectBlur(blurStyle: .systemMaterial)
                .opacity(contentOffset < -18 ? 0.6 : 0)
                .animation(.easeIn, value: contentOffset)
                .ignoresSafeArea()
                .frame(height: 30)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .navigationTitle("Contacts")
        .background(Color(("Background(WP)"))
        .edgesIgnoringSafeArea(.all))
    }
    var content: some View {
        VStack(alignment: .leading,spacing: 16.0) {
            Text("Whether you're curious about features, have suggestions for improving Serene or the answer you're looking for isn't in FAQ, contact us and let's have a talk!")
                .font(.subheadline)
                .opacity(0.7)
                .frame(maxWidth: .infinity,  alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)
            
            ForEach(ContactData, id: \.id){
                Contact in
                ContactRow(contact: Contact)
            }
                
        }
        .padding(.horizontal,20)
    }
}

struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactView()
    }
}
