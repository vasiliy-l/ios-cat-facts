//
//  CatFactsViewModel.swift
//  CatFacts
//
//  Created by  William on 1/23/19.
//  Copyright © 2019 Vasiliy Lada. All rights reserved.
//

import Foundation
import UIKit

public class CatFactsViewModel: NSObject {
    var items = [Comment]()
    
    override public init() {
        super.init()
        
        let comment1 = Comment()
        comment1.firstName = "John"
        comment1.lastName = "Smith"
        comment1.text = "Hello"
        items.append(comment1)
        
        let comment2 = Comment()
        comment1.firstName = "Dasy"
        comment1.text = "Good Day!"
        items.append(comment2)
        
        let comment3 = Comment()
        comment1.firstName = "Alice"
        comment1.lastName = "Someone"
        comment1.text = "Spaghetti eel; stingray; dottyback. Rudd bala shark yellowfin cutthroat trout jackfish desert pupfish muskellunge weasel shark quillback, dorab crucian carp?"
        items.append(comment3)
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
