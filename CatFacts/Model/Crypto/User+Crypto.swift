//
//  User+Crypto.swift
//  CatFacts
//
//  Created by  William on 1/21/19.
//  Copyright © 2019 Vasiliy Lada. All rights reserved.
//

import Foundation

// Extends CoreData Entity class to work with user passwords
extension User {
    
    /**
     Adds password information for current User object. The password is not stored as plain text
     but converts to the hash value which can be accessed using passwordHash property.
     
     - Parameters:
       - password: password string to generate hash code and add to the current User object
    */
    func setPassword(_ password: String?) {
        guard let hash = generatePasswordHash(for: password) else {
            return
        }
        
        passwordHash = hash
    }
    
    /**
     Validates given password with existing password hash.
     
     - Parameters:
       - password: password string to validate
     
     - Returns: true if given password string corresponds to stored password hash;
     false if the given password is nil of the User object has no password hash value stored.
    */
    func validatePassword(password: String?) -> Bool {
        guard let existingHash = passwordHash, let hash = generatePasswordHash(for: password) else {
            return false
        }
        
        return existingHash == hash
    }
    
    /**
     Validates given password with existing password hash.
     
     - Parameters:
       - hash: password hash to validate
     
     - Returns: true if given hash corresponds to stored password hash;
       false if the given hash is nil of the User object has no password hash value stored.
     */
    func validatePassword(hash: String?) -> Bool {
        guard let existingHash = self.passwordHash else {
            return false
        }
        
        return existingHash == hash
    }
    
    // MARK: - Supporting methods for internal logic
    
    private func generatePasswordHash(for password: String?) -> String? {
        let salt = "myPasswordSalt123"
        guard let uPassword = password, let hash = (uPassword + salt).hashed(HashType.md5) else {
            return nil
        }
        
        return hash
    }
}
