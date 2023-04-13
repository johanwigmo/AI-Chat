//
//  AI_ChatApp.swift
//  AI Chat
//
//  Created by Johan Wigmo on 2023-04-10.
//

import SwiftUI

@main
struct AI_ChatApp: App {
    var body: some Scene {
        WindowGroup {
            ConversationsView(conversations: ConversationPersistenceManager.getConversations())
        }
    }
}
