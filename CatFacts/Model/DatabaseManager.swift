//
//  DataManager.swift
//  CatFacts
//
//  Created by  William on 1/20/19.
//  Copyright © 2019 Vasiliy Lada. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DatabaseManager {
    static let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    static let context = appDelegate.persistentContainer.viewContext
    
    /**
     Loads existing User data from database
     
     - Parameters:
       - login: user login which is used to find the user in the database
     
     - Returns: a found User record or nil if no such user stored in the database
    */
    static func loadUserData(_ login: String) -> User? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "login == %@", login)
        
        let data = loadData(request)
        return data.isEmpty ? nil : data[0]
    }
    
    /**
     Saves new user record to the database. The method does not validate
     that passed user record data is already present in the database
     
     - Parameters:
       - login: user login to save in the record
       - password: user password, will be used to fulfill User object properties
     
     - Returns: User object that represents user record saved in the database
     or nil if savig given data was unsuccessful
    */
    static func saveUserData(login: String?, password: String?) -> User? {
        guard let uLogin = login, let uPassword = password else {
            return nil
        }
        
        let newUser = User(context: context)
        newUser.login = uLogin
        newUser.setPassword(uPassword)
        appDelegate.saveContext()
        
        return newUser
    }
    
    // MARK: - Supporting methods for internal logic
    
    private static func loadData<T: NSManagedObject>(_ request: NSFetchRequest<T>) -> [T] {
        do {
            return try context.fetch(request)
        } catch {
            print("Error loading user data. \(error.localizedDescription)")
        }
        
        return [T]()
    }
}
