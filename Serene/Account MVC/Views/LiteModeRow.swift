//
//  LiteModeView.swift
//  Serene
//
//  Created by MSVI on 2.05.22.
//

import SwiftUI

struct LiteModeRow: View {
    
    @AppStorage ("isLiteMode") var isLiteMode : Bool = false
    
    var body: some View {
        Toggle(isOn: $isLiteMode, label: {
            HStack(spacing: 12){
                TextFieldIcon(iconName: "speedometer", currentlyEditing: .constant(true), passedImage: .constant(nil))
                VStack(alignment: .leading){
                    Text("Lite Mode")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Text("Better performance. Recommended for iPhone X and older.")
                        .font(.caption2)
                        .opacity(0.2)
                }
            }
        })
            .toggleStyle(SwitchToggleStyle(tint: Color(#colorLiteral(red: 0.3099882007, green: 0.2201374471, blue: 0.8097378612, alpha: 1))))
    }
}

struct LiteModeView_Previews: PreviewProvider {
    static var previews: some View {
        LiteModeRow()
    }
}
