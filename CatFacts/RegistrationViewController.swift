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

        formTextFields = [loginField, passwordField, repeatPasswordField]
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func registerButtonPressed(_ sender: UIButton) {
        let validator = Validator()
            // validate form data
            .validate(for: "Login field format", with: TextFieldsValidations.validateEmailFormat, param: loginField, on: self)
            .validate(for: "Password field format", with: TextFieldsValidations.validatePasswordFormat, param: passwordField, on: self)
            .validate(for: "Repeat Password field", with: TextFieldsValidations.validateEqualValues, param1: passwordField, param2: repeatPasswordField, on: self)
            // validate given user data
            .validate(for: "User registration", with: DatabaseValidations.validateUserNotExists, param: loginField.text ?? "", on: self)
        
        if (validator.validationsPassed) {
            let _ = DatabaseManager.saveUserData(login: loginField.text, password: passwordField.text)
            // TODO: - save session and navigate to main view
        }
    }
}
