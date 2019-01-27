//
//  CatFactsViewModel.swift
//  CatFacts
//
//  Created by  William on 1/23/19.
//  Copyright © 2019 Vasiliy Lada. All rights reserved.
//

import Foundation
import UIKit

class CatFactsViewModel: NSObject {
    
    /**
     The action that will be called every time when model data is updated.
     Also, the action is called during setting this field.
    */
    var dataUpdatedAction: (() -> ())? {
        didSet {
            guard let action = dataUpdatedAction else {
                return
            }
            action()
        }
    }
    
    /**
     Model data, the array of currently loaded comments.
     dataUpdatedAction action is called every time this field is updated.
    */
    var items = [Comment]() {
        didSet {
            guard let action = dataUpdatedAction else {
                return
            }
            action()
        }
    }
    
    override public init() {
        super.init()
        
        getServerData { (jsonData) in
            self.items = Comment.parse(jsonData)
        }
    }
}

extension CatFactsViewModel: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: CatFactsTableViewCell.identifier, for: indexPath) as? CatFactsTableViewCell {
            cell.item = item
            return cell
        }
        
        return UITableViewCell()
    }
}
