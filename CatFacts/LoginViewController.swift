//
//  ViewController.swift
//  CatFacts
//
//  Created by  William on 1/20/19.
//  Copyright © 2019 Vasiliy Lada. All rights reserved.
//

import UIKit

class LoginViewController: FormFiewController {

    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formTextFields = [loginField, passwordField]
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func logInButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func createAccountButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToRegistration", sender: self)
    }
}

