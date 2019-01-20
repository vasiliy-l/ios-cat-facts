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
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static func loadUserData(_ login: String) -> User? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "login == %@", login)
        
        let data = loadData(request)
        return data.isEmpty ? nil : data[0]
    }
    
    private static func loadData<T: NSManagedObject>(_ request: NSFetchRequest<T>) -> [T] {
        do {
            return try context.fetch(request)
        } catch {
            print("Error loading user data. \(error.localizedDescription)")
        }
        
        return [T]()
    }
}
