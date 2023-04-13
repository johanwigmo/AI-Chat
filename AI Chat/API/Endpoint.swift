//
//  Endpoint.swift
//  AI Chat
//
//  Created by Johan Wigmo on 2023-04-12.
//

import Foundation

enum Endpoint {

    private static let BASE_URL: String = "https://api.openai.com/v1"

    case gpt_turbo
    case chat(Conversation)

    var method: String {
        switch self {
        case .gpt_turbo:
            return "GET"
        case .chat:
            return "POST"
        }
    }

    var url: URL? {
        switch self {
        case .gpt_turbo:
            return URL(string: Self.BASE_URL + "/models/gpt-3.5-turbo")
        case .chat:
            return URL(string: Self.BASE_URL + "/chat/completions")
        }
    }

    var params: [String: Any]? {
        switch self {
        case .gpt_turbo:
            return nil
        case .chat(let conversation):
            return [
                "model": "gpt-3.5-turbo",
                "messages": conversation.messages.map {
                    ["role": $0.role, "content": $0.content]
                }
            ]
        }
    }
}

