//
//  CourseItem.swift
//  SereneBeta
//
//  Created by MSVI on 28.08.21.
//



import SwiftUI

struct EntryItem: View {
    var entry: Entry  = entries[0]
    #if os(iOS)
    var cornerRadius:CGFloat = 22
    #else
    var cornerRadius:CGFloat = 10
    #endif
    var body: some View {
        
//        let width = UIScreen.main.bounds.width
        ZStack{
            
            RoundedRectangle(cornerRadius: 25)
                .fill(.white)
                .opacity(0.1)
                .background(
                
                    Color.white
                        .opacity(0.08)
                        .blur(radius: 10)
                )
            // Strokes...
                .background(
                
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(
                        
                            .linearGradient(.init(colors: [
                            
                                Color(entry.CardColorTop),
                                Color(entry.CardColorTop).opacity(0.5),
                                .clear,
                                .clear,
                                Color(entry.CardColorDown),
                            ]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            ,lineWidth: 2.5
                        )
                        .padding(2)
                )
            // Shadows...
                .shadow(color: .black.opacity(0.1), radius: 5, x: -5, y: -5)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
            
        VStack(alignment: .leading, spacing: 4) {
            Spacer()
                    HStack {
                        Spacer()
                        Image(entry.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                    Spacer()
                }
            Text(entry.mood)
                    .fontWeight(.bold)
            Text(entry.date)
                    .font(.footnote)
                    .fontWeight(.bold)
            }
            .padding(.all)
        }
       
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius,style: .continuous))
       // .shadow(color:Color(course.CardColorDown), radius: 20)
        }
struct EntryItem_Previews: PreviewProvider {
    static var previews: some View {
        EntryItem()
    }
    }
 }



