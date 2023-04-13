//
//  ConversationPersistenceManager.swift
//  AI Chat
//
//  Created by Johan Wigmo on 2023-04-13.
//

import Foundation

class ConversationPersistenceManager {
    private static let fileName = "Conversations.plist"

    static func getConversations() -> [Conversation] {
        let decoder = PropertyListDecoder()
        guard let data = FileManager.default.contents(atPath: conversationFilePath()) else {
            return []
        }

        do {
            let conversations = try decoder.decode([Conversation].self, from: data)
            return conversations
        } catch {
            print("Error decoding conversations: \(error)")
            return []
        }
    }

    static func save(conversations: [Conversation]) {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(conversations)
            try data.write(to: URL(fileURLWithPath: conversationFilePath()))
        } catch {
            print("Error encoding conversations: \(error)")
        }
    }

    private static func conversationFilePath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory.appending("/\(fileName)")
    }
}
