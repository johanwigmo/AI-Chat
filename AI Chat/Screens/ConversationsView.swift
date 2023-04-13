//
//  ConversationsView.swift
//  AI Chat
//
//  Created by Johan Wigmo on 2023-04-10.
//

import SwiftUI
import Combine

struct ConversationsView: View {

    @State private var showSettings = false
    @State private var conversations: [Conversation]

    init(conversations: [Conversation]) {
        self.conversations = conversations
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(conversations) { conversation in
                    NavigationLink(destination: ChatView(conversation: conversation, completion: addOrUpdateConversation)
                        .toolbarRole(.editor)) {
                        ConversationRow(conversation: conversation)
                    }
                }
                .onDelete { indexSet in
                    conversations.remove(atOffsets: indexSet)
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Conversations")
            .navigationBarItems(
                leading:
                    Button(action: {
                        self.showSettings.toggle()
                    }) {
                        Image(systemName: "gear")
                    },
                trailing:
                    NavigationLink(destination: ChatView(conversation: Conversation(), completion: addOrUpdateConversation).toolbarRole(.editor)) {
                        Image(systemName: "square.and.pencil")
                    }
            )
        }

        .sheet(isPresented: $showSettings) {
            SettingsView()
        }
    }
}

private extension ConversationsView {

    func addOrUpdateConversation(conversation: Conversation) {
        if let index = conversations.firstIndex(where: { $0.id == conversation.id }) {
            conversations[index] = conversation
        } else {
            conversations.insert(conversation, at: 0)
        }
        ConversationPersistenceManager.save(conversations: conversations)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        let conversations = [
            Conversation(messages: [Message(role: "user", content: "Hey, how's it going?")]),
            Conversation(messages: [Message(role: "user", content: "Can we meet up tomorrow?")]),
            Conversation(messages: [Message(role: "user", content: "Check out this cool article!")])
        ]
        return ConversationsView(conversations: conversations)
    }
}
