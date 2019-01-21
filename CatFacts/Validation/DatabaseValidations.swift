//
//  DatabaseValidations.swift
//  CatFacts
//
//  Created by  William on 1/21/19.
//  Copyright © 2019 Vasiliy Lada. All rights reserved.
//

import Foundation

class DatabaseValidations {
    /**
     Checks that database contains a user record by given login string.
     */
    static let validateUserExists: (String) -> (status: Bool, message: String?, returnValue: User?) = { (login) in
        let user = DatabaseManager.loadUserData(login)
        if (user == nil) {
            return (false, "User with login \(login) is not registered.", user)
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
        
        if (!uUser.validatePassword(password)) {
            return (false, "Incorrect user password.", databaseUser)
        }
        
        return (true, nil, databaseUser)
    }
    
}
