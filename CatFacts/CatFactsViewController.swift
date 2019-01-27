//
//  CatFactsViewController.swift
//  CatFacts
//
//  Created by  William on 1/21/19.
//  Copyright © 2019 Vasiliy Lada. All rights reserved.
//

import UIKit

class CatFactsViewController: UITableViewController {
    
    let viewModel = CatFactsViewModel()
    var loader: Loader?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        
        tableView.register(CatFactsTableViewCell.nib, forCellReuseIdentifier: CatFactsTableViewCell.identifier)
        
        tableView.dataSource = viewModel
        
        loader = Loader(for: tableView)
        viewModel.dataUpdatedAction = { (rows) in // add an action to display loader and refresh the table when needed
            self.tableView.reloadData()
            
            if (rows == 0) {
               self.loader?.display()
            } else {
               self.loader?.hide()
            }
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func logoutNavigationButtonPressed(_ sender: UIBarButtonItem) {
        let _ = SessionManager.logOutUser {
            navigationController?.popToRootViewController(animated: true)
        }
    }
}
