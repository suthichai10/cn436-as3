//
//  TextArea.swift
//  Instagram-Clone
//
//  Created by suthichai on 2/11/2564 BE.
//

import SwiftUI

struct TextArea: View {
    @Binding var text : String
    let placeholder : String
    
    init(_ placeholder: String , text: Binding<String>) {
        self.placeholder = placeholder
        _text = text
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color(UIColor.placeholderText))
                    .padding(.horizontal , 8)
                    .padding(.vertical , 12)
            }
            TextEditor(text: $text)
                .padding(4)
        }
        .font(.body)
    }
}
