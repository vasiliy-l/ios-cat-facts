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
        let validator = TextFieldsValidator()
            .validate(with: TextFieldsValidator.validateEmailFormat, for: loginField, named: "Login", on: self)
            .validate(with: TextFieldsValidator.validatePasswordFormat, for: passwordField, named: "Password", on: self)
        
        if (validator.validationPassed) {
            // TODO: - Proceed with valid form data
            print("login form validation passed")
        }
    }
    
    @IBAction func createAccountButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToRegistration", sender: self)
    }
}

