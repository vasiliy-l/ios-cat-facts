//
//  DatabaseValidations.swift
//  CatFacts
//
//  Created by  William on 1/21/19.
//  Copyright © 2019 Vasiliy Lada. All rights reserved.
//

import Foundation

/**
 Collection of predefined database-related validation rules.
 */
class DatabaseValidations {
    
    /**
     Checks that database contains a user record by given login string.
     */
    static let validateUserExists: (String) -> (status: Bool, message: String?, returnValue: User?) = { (login) in
        let user = DatabaseManager.loadUserData(login)
        if (user == nil) {
            return (false, "User with login \(login) is not registered. Make sure that valid user login entered or use registration link to create new account.", user)
        }

        return (true, nil, user)
    }
    
    /**
     Checks that database doesn't contain a user record by given login string.
     */
    static let validateUserNotExists: (String) -> (status: Bool, message: String?, returnValue: User?) = { (login) in
        let user = DatabaseManager.loadUserData(login)
        if (user != nil) {
            return (false, "User with login \(login) is already registered. You're ready to sign in using provided login.", user)
        }
        
        return (true, nil, user)
    }
    
    /**
     Checks that provided user password matches to the stored value in the database.
     */
    static let validateUserCorrectPassword: (User?, String?) -> (status: Bool, message: String?, returnValue: User?) = { (databaseUser, password) in
        guard let uUser = databaseUser else {
            return (false, "Unable to validate given user data.", databaseUser)
        }
        
        if (!uUser.validatePassword(password: password)) {
            return (false, "Incorrect user password. Make sure that valid user password entered.", databaseUser)
        }
        
        return (true, nil, databaseUser)
    }
}
