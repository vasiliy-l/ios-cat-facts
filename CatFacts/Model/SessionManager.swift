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
    
    /**
     Stores user authentication data in Keychain and performs completion action
     if the operation was successful.
     An example of completion action is navigation to another view (navigate the user
     to main screen after successful authentication.)
     
     - Parameters:
       - user: user data to store in Keychain
       - completion: completion action to be performed if the operation was successful.
     
     - Returns:
       the value indicating whether the operation was successful.
     */
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
    
    /**
     Reads saved user authorization data from Keychain and performs completion action
     if the operation was successful.
     The completion action will be performed if all criterias are met: Keychain contains saved user data; reading the user data from the Keychain was successful; application database contains saved user and it's password matches.
     
     - Parameters:
       - completion: completion action to be performed if the operation was successful.
     
     - Returns:
       user data from Keychain or nothing if the operation was unsuccessful.
     */
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
    
    /**
     Removes user authorization data from Keychain and performs completion action
     if the operation was successful.
     An example of completion action is navigation to the user back to login screen
     after their authorization data is removed from Keychain.
     
     - Parameters:
       - completion: completion action to be performed if the operation was successful.
     
     - Returns:
       the value indicating whether the operation was successful.
     */
    static func logOutUser(completion: () -> ()) -> Bool {
        if (keychainWrapper.removeObject(forKey: "user") == false) {
            print("Unable to remove user auth data from Keychain. Make sure that you are not in debug mode.")
        }
        
        completion()
        return true
    }
}
