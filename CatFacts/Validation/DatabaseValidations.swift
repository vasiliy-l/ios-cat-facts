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
    static let validateUserExists: (String) -> (status: Bool, message: String?) = { (login) in
        if (DatabaseManager.loadUserData(login) == nil) {
            return (false, "User with login \(login) is not registered.")
        }

        return (true, nil)
    }
    
}
