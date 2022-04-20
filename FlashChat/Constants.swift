//
//  Constants.swift
//  FlashChat
//
//  Created by a-robota on 4/19/22.
//

struct K {
    static let Name = "⚡️FlashChat"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    static let registerSegue = "Register"
    static let loginSegue = "Login"
    
    struct uiScheme {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct userInfo {
        static let collectionName = "messages"
        static let sendField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
