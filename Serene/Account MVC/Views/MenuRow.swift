//
//  MenuRow.swift
//  Serene
//
//  Created by MSVI on 15.01.22.
//

import SwiftUI

struct MenuRow: View {
    var rowTitle: String = "Row name"
    var leftIcon: TextFieldIcon
    var rightIcon: String = "chevron.right"
    
    var body: some View {
        HStack (spacing: 12.0){
            leftIcon
            
            Text(rowTitle)
                .font(.subheadline)
                .fontWeight(.semibold)
            
            Spacer()
            
            Image(systemName: rightIcon)
                .font(.system(size: 15, weight: .semibold))
                .opacity(0.3)
        }
        .frame(maxWidth: .infinity,  alignment: .leading)
    }
}

struct MenuRow_Previews: PreviewProvider {
    static var previews: some View {
        MenuRow(rowTitle: "Row Title", leftIcon: TextFieldIcon(iconName: "questionmark", currentlyEditing: .constant(true), passedImage: .constant(nil)), rightIcon: "chevron.right")
    }
}
