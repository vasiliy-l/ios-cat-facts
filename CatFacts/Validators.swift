//
//  TextFieldsValidator.swift
//  CatFacts
//
//  Created by  William on 1/20/19.
//  Copyright © 2019 Vasiliy Lada. All rights reserved.
//

import Foundation
import UIKit

/**
 Validation helper to apply verification rules and display
 an alert message to a user in case of validation failure.
 */
class Validator {
    
    /**
     Tells whether or not all validation rules applied using current object passed.
     */
    fileprivate(set) public var validationPassed = true
    
    // MARK: - Validation methods
    
    /**
     Applies validation rule to an object. If the validation rule fails,
     an alert with validation description is displayed to a user; also, all subsequent validation calls in the chain
     will be skipped and not applied.
     
     - Parameters:
        - for: validation description that may be displayed in alert
        - with: validation rule to apply to the object
        - o: the object to be validated using validation rule
        - param: the object to be validated
        - on: the view for which an alert with validation message will be displayed in case of validation failure
     
     - Returns:
     returnValue: current instance of Validator to build sequence of validation calls
     */
    func validate<T>(for validationTitle: String?, with rule: (_ o: T) -> (status: Bool, message: String?), param: T, on view: UIViewController) -> Validator {
        if (validationPassed) {
            let validationResult = rule(param)
            
            if (!validationResult.status) {
                validationPassed = false
                showValidationAlert(for: validationTitle, with: validationResult.message, on: view)
            }
        }
        
        return self
    }
    
    /**
     Applies validation rule to objects. If the validation rule fails,
     an alert with validation description is displayed to a user;
     also, all subsequent validation calls in the chain will be skipped
     and not applied.
     
     - Parameters:
         - for: validation description that may be displayed in alert
         - with: validation rule to apply to the object
         - o1: the first object used in the validation rule
         - o2: the second object used in the validation rule
         - param1: the first object to be validated
         - param2: the second object to be validated
         - on: the view for which an alert with validation message will be displayed in case of validation failure
     
     - Returns:
     returnValue: current instance of Validator to build sequence of validation calls
     */
    func validate<T>(for validationTitle: String?, with rule: (_ o1: T, _ o2: T) -> (status: Bool, message: String?), param1: T, param2: T, on view: UIViewController) -> Validator {
        if (validationPassed) {
            let validationResult = rule(param1, param2)
            
            if (!validationResult.status) {
                validationPassed = false
                showValidationAlert(for: validationTitle, with: validationResult.message, on: view)
            }
        }
        
        return self
    }
    
    // MARK: - Helper methods
    
    func showValidationAlert(for title: String?, with message: String?, on view: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Got It", style: .default, handler: nil)
        alert.addAction(okAction)
        
        view.present(alert, animated: true, completion: nil)
    }
}


/**
 Validation helper to verify field values. Use instances of this class
 to apply validation rules to fields and display an alert message
 to a user in case of validation failure.
*/
class TextFieldsValidator: Validator {
    
    // MARK: - Predefined validation rules
    
    /**
     Checks that given text field contains text value in proper e-mail format.
    */
    static let validateEmailFormat: (UITextField) -> (status: Bool, message: String?) = { (field) in
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        if (!emailTest.evaluate(with: field.text)) {
            return (false, "Invalid e-mail address. Valid e-mail must be in the format like john.doe@gmail.com. Please check entered e-mail address.")
        }
        
        return (true, nil)
    }
    
    /**
     Checks that given text field contains text value in proper password format.
     */
    static let validatePasswordFormat: (UITextField) -> (status: Bool, message: String?) = { (field) in
        if (field.text?.count ?? 0 < 5) {
            return (false, "Insecure password. Please enter password with 5 or more characters length.")
        }
        
        return (true, nil)
    }
    
    /**
     Checks that given text fields contain equal text.
     */
    static let validateEqualValues: (UITextField, UITextField) -> (status: Bool, message: String?) = { (field1, field2) in
        if (field1.text != field2.text) {
            return (false, "Different values for fields. Make sure that the fields are filled with the same value.")
        }
        
        return (true, nil)
    }
    
    // MARK: - Validation methods
    
    /**
     Applies validation rule to a text field. If the validation rule fails,
     an alert with validation description is displayed to a user; also, all subsequent validation calls in the chain
     will be skipped and not applied.
     
     - Parameters:
         - with: validation rule to apply to the text field
         - f: the field to be validated using validation rule
         - for: the text field to be validated
         - named: the name of the field that will be displayed in alert title in case of validation failure
         - on: the view for which an alert with validation message will be displayed in case of validation failure
     
     - Returns:
     returnValue: current instance of TextFieldsValidator to build sequence of validation calls
    */
    func validate(with rule: (_ f: UITextField) -> (status: Bool, message: String?), for field: UITextField, named fieldName: String?, on view: UIViewController) -> TextFieldsValidator {
        return validate(
            for: "Invalid \(fieldName ?? "") field value",
            with: rule, param: field, on: view) as! TextFieldsValidator
    }
    
    /**
     Applies validation rule to text fields. If the validation rule fails,
     an alert with validation description is displayed to a user; also, all subsequent validation calls in the chain
     will be skipped and not applied.
     
     - Parameters:
         - with: validation rule to apply to the text fields
         - f1: the first field to be validated using validation rule
         - f2: the second field to be validated using validation rule
         - for: the first text field to be validated
         - and: the second text field to be validated
         - named: the name of the fields that will be displayed in alert title in case of validation failure
         - on: the view for which an alert with validation message will be displayed in case of validation failure
     
     - Returns:
     returnValue: current instance of TextFieldsValidator to build sequence of validation calls
     */
    func validate(with rule: (_ f1: UITextField, _ f2: UITextField) -> (status: Bool, message: String?), for field1: UITextField, and field2: UITextField, named fieldsName: String?, on view: UIViewController) -> TextFieldsValidator {
        return validate(
            for: "Invalid \(fieldsName ?? "") field values",
            with: rule, param1: field1, param2: field2, on: view) as! TextFieldsValidator
    }
}
