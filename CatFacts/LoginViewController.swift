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
        
        let _ = SessionManager.resotreUserSession { // navigate to main screen if the user is already authenticated
            self.performSegue(withIdentifier: "goToCatFactsFromLogin", sender: self)
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func logInButtonPressed(_ sender: UIButton) {
        
        var validator = Validator()
            // validate form data
            .validate(for: "Login field format", with: TextFieldsValidations.validateEmailFormat, param: loginField, on: self)
            .validate(for: "Password field format", with: TextFieldsValidations.validatePasswordFormat, param: passwordField, on: self)
            // validate given user data
            .validate(for: "User registration", with: DatabaseValidations.validateUserExists, param: loginField.text ?? "", on: self)
            validator = validator
                .validate(for: "User login", with: DatabaseValidations.validateUserCorrectPassword, param1: validator.lastValidationResultData as? User, param2: passwordField.text, on: self)
        
        // proceed with user data
        guard validator.validationsPassed, let user = validator.lastValidationResultData as? User else {
            return
        }
        
        // save user auth data and go to main screen
        guard SessionManager.authenticateUser(user: user, completion: {
            self.performSegue(withIdentifier: "goToCatFactsFromLogin", sender: self)
        }) else {
            validator.showValidationAlert(for: "User login", with: "Unable to authenticate user.", on: self)
            return
        }
    }
    
    @IBAction func createAccountButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToRegistration", sender: self)
    }
    @IBAction func goToCatFactsButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToCatFactsFromLogin", sender: self)
    }
}

