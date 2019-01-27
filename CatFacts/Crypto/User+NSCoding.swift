//
//  User+NSCoding.swift
//  CatFacts
//
//  Created by  William on 1/27/19.
//  Copyright © 2019 Vasiliy Lada. All rights reserved.
//

import Foundation

class KeychainUser: NSObject, NSCoding {
    private(set) var login: String
    private(set) var passwordHash: String
    
    init(login: String, passwordHash: String) {
        self.login = login
        self.passwordHash = passwordHash
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let login = aDecoder.decodeObject(forKey: "login") as? String,
            let passwordHash = aDecoder.decodeObject(forKey: "passwordHash") as? String
            else { return nil }
        
        self.init(login: login, passwordHash: passwordHash)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.login, forKey: "login")
        aCoder.encode(self.passwordHash, forKey: "passwordHash")
    }
    
}

extension User {
    
    func asKeychainUser() -> KeychainUser? {
        guard let login = self.login, let passwordHash = self.passwordHash else {
            return nil
        }
        return KeychainUser(login: login, passwordHash: passwordHash)
    }
}
