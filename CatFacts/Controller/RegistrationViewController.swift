//
//  RegistrationViewController.swift
//  CatFacts
//
//  Created by  William on 1/20/19.
//  Copyright © 2019 Vasiliy Lada. All rights reserved.
//

import UIKit

class RegistrationViewController: FormFiewController {

    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var repeatPasswordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Mark which of the fields on the screen are related to Registration form
        formTextFields = [loginField, passwordField, repeatPasswordField]
    }
    
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        let validator = Validator()
            // validate form data
            .validate(for: "Login field format", with: TextFieldsValidations.validateEmailFormat, param: loginField, on: self)
            .validate(for: "Password field format", with: TextFieldsValidations.validatePasswordFormat, param: passwordField, on: self)
            .validate(for: "Repeat Password field", with: TextFieldsValidations.validateEqualValues, param1: passwordField, param2: repeatPasswordField, on: self)
            // validate given user data
            .validate(for: "User registration", with: DatabaseValidations.validateUserNotExists, param: loginField.text ?? "", on: self)
        
        // proceed with user data
        guard validator.validationsPassed, let user = DatabaseManager.saveUserData(login: loginField.text, password: passwordField.text) else {
            return
        }
        
        // save user auth data and go to main screen
        guard SessionManager.authenticateUser(user: user, completion: {
            self.performSegue(withIdentifier: "goToCatFactsFromRegistration", sender: self)
        }) else {
            validator.showValidationAlert(for: "User registration", with: "Unable to authenticate user.", on: self)
            return
        }
    }
    
    /*
    @IBAction func goToCatFactsButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToCatFactsFromRegistration", sender: self)
    }
    */
}
