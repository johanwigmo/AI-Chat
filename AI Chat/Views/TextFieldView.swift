//
//  TextFieldView.swift
//  AI Chat
//
//  Created by Johan Wigmo on 2023-04-11.
//

import SwiftUI

struct TextFieldView: View {
    
    let title: String
    let placeholder: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.bottom, 5)
            TextField(placeholder, text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView(title: "Title", placeholder: "Placeholder", text: .constant(""))
    }
}
