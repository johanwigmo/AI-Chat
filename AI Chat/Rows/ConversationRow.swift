//
//  ConversationRow.swift
//  AI Chat
//
//  Created by Johan Wigmo on 2023-04-10.
//

import SwiftUI


struct ConversationRow: View {
    let conversation: Conversation

    var body: some View {
        VStack(alignment: .leading) {
            Text(conversation.title)
                .font(.headline)
            Text(conversation.lastMessage)
                .font(.subheadline)
                .lineLimit(1)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(height: 44)
    }
}

struct ConversationRow_Previews: PreviewProvider {
    static var previews: some View {
        let conversation = Conversation(
            messages: [Message(role: "user", content: "Hey, how's it going?")]
        )

        ConversationRow(conversation: conversation)
    }
}
