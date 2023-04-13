//
//  Message.swift
//  AI Chat
//
//  Created by Johan Wigmo on 2023-04-12.
//

import Foundation

struct Message: Hashable, Codable {
    var id: UUID
    let role: String
    let content: String

    init(id: UUID = UUID(), role: String, content: String) {
         self.id = id
         self.role = role
         self.content = content
     }

     init(from decoder: Decoder) throws {
         let container = try decoder.container(keyedBy: CodingKeys.self)
         self.id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
         self.role = try container.decode(String.self, forKey: .role)
         self.content = try container.decode(String.self, forKey: .content)
     }
}

extension Message {

    var isMe: Bool {
        role == "user"
    }
}
