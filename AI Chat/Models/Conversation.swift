//
//  Conversation.swift
//  AI Chat
//
//  Created by Johan Wigmo on 2023-04-10.
//

import Foundation

struct Conversation: Identifiable, Codable {
    var id: UUID
    var name: String?
    var messages: [Message]

    init(id: UUID = UUID(), name: String? = nil, messages: [Message] = []) {
        self.id = id
        self.name = name
        self.messages = messages
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        messages = try container.decode([Message].self, forKey: .messages)
    }
}

extension Conversation {

    var title: String {
        if let name {
            return name
        } else if messages.count == 1 {
            return "\(messages.count) message"
        } else {
            return "\(messages.count) messages"
        }
    }

    var lastMessage: String {
        messages.last?.content ?? ""
    }

    mutating func set(name: String) {
        self.name = name}

    mutating func add(message: Message) {
        messages.append(message)
    }
}
