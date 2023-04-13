//
//  EditChatView.swift
//  AI Chat
//
//  Created by Johan Wigmo on 2023-04-13.
//

import SwiftUI

struct EditChatView: View {

    @Binding var title: String

    var body: some View {
        VStack {
            Text("Edit Chat")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            TextFieldView(
                title: "Name of Chat",
                placeholder: "Name",
                text: $title
            )
            .padding(.horizontal)
            Spacer()
        }
    }
}

struct EditChatView_Previews: PreviewProvider {
    static var previews: some View {
        EditChatView(title: Binding.constant("Title"))
    }
}
