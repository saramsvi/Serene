//
//  ContactRow.swift
//  Serene
//
//  Created by MSVI on 15.01.22.
//


import SwiftUI

struct ContactRow: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var contact: Contact
    
    var body: some View {
        VStack(alignment: .leading) {
            Link(destination: URL(string: contact.link)!) {
                if colorScheme == .dark {
                    GradientText(text: contact.title)
                        .font(.subheadline)
                }
                else{
                    LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2235294118, green: 0.07450980392, blue: 0.7215686275, alpha: 1)),Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)) ]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .frame(height: 20)
                        .mask(Text(contact.title)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .textCase(.uppercase)
                                .frame(maxWidth: .infinity, alignment: .leading))
                    
                        .frame(height: 20)
                        .mask(Text(contact.title)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .textCase(.uppercase)
                                .frame(maxWidth: .infinity, alignment: .leading))
                        
              }
            }

            Divider()
        }
    }
    
}

struct ContactRow_Previews: PreviewProvider {
    static var previews: some View {
        ContactRow(contact: ContactData[0])
            .environment(\.colorScheme, .light )
    }
}


//
//
////
////  ContactRow.swift
////  Serene
////
////  Created by MSVI on 15.01.22.
////
//
//
//import SwiftUI
//
//struct ContactRow: View {
//    @Environment(\.colorScheme) var colorScheme: ColorScheme
//    var contact: Contact
//
//    var body: some View {
//        VStack(alignment: .leading) {
////            Link(destination: URL(string: contact.link)!) {
////                LinearGradient(gradient: Gradient(colors: colorScheme == .dark ? [Color(#colorLiteral(red: 0.6196078431, green: 0.6784313725, blue: 1, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.5607843137, blue: 0.9803921569, alpha: 1))] : [Color(#colorLiteral(red: 0.2235294118, green: 0.07450980392, blue: 0.7215686275, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
////                                 .frame(height: 20)
////                                 .mask(Text(contact.title)
////                                         .font(.subheadline)
////                                         .fontWeight(.medium)
////                                         .textCase(.uppercase)
////                                         .frame(maxWidth: .infinity, alignment: .leading))
////
////                    .frame(height: 20)
////                    .mask(Text(contact.title)
////                            .font(.subheadline)
////                            .fontWeight(.medium)
////                            .textCase(.uppercase)
////                            .frame(maxWidth: .infinity, alignment: .leading))
////            }
//
//            if colorScheme == .dark {
//                GradientText(text: contact.title)
//                    .font(.subheadline)
//            }
//            else{
//
//            }
//




////     Text(contact.title)
//    .gradientForeground(colors: [Color(#colorLiteral(red: 0.2235294118, green: 0.07450980392, blue: 0.7215686275, alpha: 1)),Color("LightBlue"),Color("pink-gradient")])
//            .frame(height: 20)
//            .font(.subheadline)
//            .frame(maxWidth: .infinity, alignment: .leading)
//
