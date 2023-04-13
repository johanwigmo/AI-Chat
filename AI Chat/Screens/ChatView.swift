//
//  ChatView.swift
//  AI Chat
//
//  Created by Johan Wigmo on 2023-04-10.
//

import SwiftUI
import Combine

struct ChatView : View {

    private static let defaultTitle = "Chat"

    @State private var title: String
    @State private var conversation: Conversation
    @State private var textMessage = ""
    @State private var isLoading = false
    @State private var showEdit = false
    private let addOrUpdateConversation: (Conversation) -> Void

    init(conversation: Conversation, completion: @escaping (Conversation) -> Void) {
        _title = State(initialValue: conversation.name ?? Self.defaultTitle)
        _conversation = State(initialValue: conversation)
        self.addOrUpdateConversation = completion
    }

    var body: some View {
        VStack {
            List {
                ForEach(conversation.messages, id: \.self) { message in
                    ChatRow(message: message)
                        .listRowSeparator(.hidden)
                }
                if isLoading {
                    LoadingChatRow()
                        .listRowSeparator(.hidden)
                }
            }
            .listStyle(PlainListStyle())
            VStack {
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)
                
                HStack {
                    TextField("Enter message...", text: $textMessage)
                    Button(action: {
                        self.sendMessage()
                    }) {
                        Text("Send")
                    }
                    .disabled(isLoading)
                }.padding()
            }
        }
        .navigationBarTitle(title)
        .navigationBarItems(
            trailing:
                Button(action: {
                    self.showEdit.toggle()
                }, label: {
                    Image(systemName: "pencil")
                })
        )

        .sheet(isPresented: $showEdit) {
            EditChatView(title: $title)
        }

        .onChange(of: showEdit) { newValue in
            if !newValue && title != Self.defaultTitle && title != conversation.name {
                conversation.name = title
            }
        }

        .onDisappear {
            guard !conversation.messages.isEmpty else {
                return
            }
            addOrUpdateConversation(conversation)
        }
    }
}

private extension ChatView {

    func sendMessage() {
        if !textMessage.isEmpty {
            add(textMessage: textMessage)
            textMessage = ""
        }
    }

    func add(textMessage: String) {
        isLoading = true
        let message = Message(role: "user", content: textMessage)
        conversation.messages.append(message)

        API.shared.chat(conversation: conversation) { message, error in
            self.isLoading = false

            if let error {
                print(error.localizedDescription)
                return
            }

            if let message {
                conversation.messages.append(message)
            }
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        let messages = [
            Message(role: "user", content: "Hello, how are you?"),
            Message(role: "assistant", content: "I'm doing well. How are you?"),
            Message(role: "user", content: "I'm good too. Thanks for asking.")
        ]
        ChatView(conversation: Conversation(name: "Chat", messages: messages), completion: {_ in })
    }
}
