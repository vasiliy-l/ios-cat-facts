//
//  SessionManager.swift
//  CatFacts
//
//  Created by  William on 1/27/19.
//  Copyright © 2019 Vasiliy Lada. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class SessionManager {
    
    static let keychainWrapper = KeychainWrapper.standard
    
    static func authenticateUser(user: User, completion: () -> ()) -> Bool {
        guard let keychainUser = user.asKeychainUser() else {
            return false
        }
        
        if (keychainWrapper.set(keychainUser, forKey: "user")) {
            completion()
            return true
        } else {
            return false
        }
    }
    
    static func resotreUserSession(completion: () -> ()) -> User? {
        guard let keychainUser = keychainWrapper.object(forKey: "user") as? KeychainUser else {
            return nil
        }
        
        guard let (result, _, user) = DatabaseValidations.validateUserExists(keychainUser.login) as? (Bool, String?, User),
            result else {
            return nil
        }
        
        if (user.validatePassword(hash: keychainUser.passwordHash)) {
            completion()
            return user
        } else {
            return nil
        }
    }
    
    static func logOutUser(completion: () -> ()) -> Bool {
        if (keychainWrapper.removeObject(forKey: "user") == false) {
            print("Unable to remove user auth data from Keychain. Make sure that you are not in debug mode.")
        }
        
        completion()
        return true
    }
}
