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
        let validator = TextFieldsValidator()
            .validate(with: TextFieldsValidator.validateEmailFormat, for: loginField, named: "Login", on: self)
            .validate(with: TextFieldsValidator.validatePasswordFormat, for: passwordField, named: "Password", on: self)
            .validate(with: TextFieldsValidator.validateEqualValues, for: passwordField, and: repeatPasswordField, named: "Password", on: self)
        
        if (validator.validationPassed) {
            // TODO: - Proceed with valid form data
            print("registration form validation passed")
        }
    }
}
