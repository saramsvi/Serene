//
//  FAQView.swift
//  Serene
//
//  Created by MSVI on 15.01.22.
//

import SwiftUI

struct FAQView: View {
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
        .navigationTitle("FAQ")
        .background(Color(("Background(WP)"))
                        .edgesIgnoringSafeArea(.all))
    }
    var content: some View{
        VStack(alignment: .leading, spacing: 16.0){
            ForEach(faqData,id: \.id){
                faq in
                FAQRow(faq: faq)
            }
            Text("Have any questions?")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.subheadline)
                .opacity(0.7)
        }
        .padding(.horizontal,20)
        .padding(.bottom,65)
    }
}

struct FAQView_Previews: PreviewProvider {
    static var previews: some View {
        FAQView()
    }
}
