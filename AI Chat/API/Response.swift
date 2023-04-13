//
//  Response.swift
//  AI Chat
//
//  Created by Johan Wigmo on 2023-04-12.
//

import Foundation

struct Response: Codable {
    let choices: [Choice]

    struct Choice: Codable {
        let message: Message
    }
}
