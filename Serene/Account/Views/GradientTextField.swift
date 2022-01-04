//
//  GradientTextField.swift
//  Authorization(iOS)
//
//  Created by MSVI on 19.10.21.
//

import SwiftUI

struct GradientTextField: View {
    @Binding var editingTextField: Bool
    @Binding var textFieldString: String
    @Binding var iconBounce: Bool
    var textfieldPlaceHolder: String //sf symbol
    var textfieldIconString: String
    private let generator = UISelectionFeedbackGenerator()
    var body: some View {
        HStack (spacing: 12.0){
            TextFieldIcon(iconName: textfieldIconString, currentlyEditing: $editingTextField, passedImage: .constant(nil))
                .scaleEffect(iconBounce ? 1.2 : 1.0)
            TextField(textfieldPlaceHolder, text:$textFieldString){
                isEditing  in
                editingTextField = isEditing
                generator.selectionChanged()
                if isEditing {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.5)){
                        iconBounce.toggle()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25)
                    {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.5)){
                            iconBounce.toggle()
                        }
                    }
                }
            }
            .colorScheme(.dark)
            .foregroundColor(Color.white.opacity(0.7))
          
        }
        
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white,lineWidth: 1.0)
                .blendMode(.overlay)
        )
        .background(
            Color(red:26/255 , green: 20/255, blue: 51/255)
                .cornerRadius(16)
              
        )
    }
}

struct GradientTextField_Previews: PreviewProvider {
    static var previews: some View {
        GradientTextField(editingTextField: .constant(true), textFieldString: .constant("some string here"), iconBounce: .constant(false), textfieldPlaceHolder: "Test text field", textfieldIconString: "textformat.alt")
    }
}
