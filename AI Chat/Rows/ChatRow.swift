//
//  ChatRow.swift
//  AI Chat
//
//  Created by Johan Wigmo on 2023-04-11.
//

import SwiftUI

struct ChatRow : View {

    var message: Message
    var body: some View {
        HStack {
            if message.isMe {
                Spacer()
                Text(message.content)
                    .padding(10)
                    .background(.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            } else {
                Text(message.content)
                    .padding(10)
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                Spacer()
            }
        }.padding(.vertical, 5)
    }
}

struct ChatRow_Previews: PreviewProvider {
    static var previews: some View {
        let message = Message(role: "user", content: "Hello, how are you?")
        ChatRow(message: message)
    }
}
