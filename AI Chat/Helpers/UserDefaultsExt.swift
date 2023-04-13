//
//  UserDefaultsExt.swift
//  AI Chat
//
//  Created by Johan Wigmo on 2023-04-12.
//

import Foundation

extension UserDefaults {

    static var ApiKey: String {
        get { UserDefaults.standard.string(forKey: "api_key") ?? "" }
        set { UserDefaults.standard.set(newValue, forKey: "api_key") }
    }
}
