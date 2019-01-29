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
 an alert message to the user in case of validation failure.
 */
class Validator {
    
    /**
     Tells whether or not all validation rules applied using current object passed.
     */
    var validationsPassed = true
    var lastValidationResultData: Any?
    
    // MARK: - Validation methods
    
    /**
     Applies validation rule to an object. If the validation rule fails,
     an alert with validation description is displayed to the user; also, all subsequent validation calls in the chain
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
    func validate<T>(for validationTitle: String?, with rule: (_ o: T) -> (status: Bool, message: String?, returnValue: Any?), param: T, on view: UIViewController) -> Validator {
        if (validationsPassed) {
            let validationResult = rule(param)
            lastValidationResultData = validationResult.returnValue
            
            if (!validationResult.status) {
                validationsPassed = false
                showValidationAlert(for: validationTitle, with: validationResult.message, on: view)
            }
        }
        
        return self
    }
    
    /**
     Applies validation rule to objects. If the validation rule fails,
     an alert with validation description is displayed to the user;
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
    func validate<T>(for validationTitle: String?, with rule: (_ o1: T, _ o2: T) -> (status: Bool, message: String?, returnValue: Any?), param1: T, param2: T, on view: UIViewController) -> Validator {
        if (validationsPassed) {
            let validationResult = rule(param1, param2)
            lastValidationResultData = validationResult.returnValue
            
            if (!validationResult.status) {
                validationsPassed = false
                showValidationAlert(for: validationTitle, with: validationResult.message, on: view)
            }
        }
        
        return self
    }
    
    /**
     Applies validation rule to objects. If the validation rule fails,
     an alert with validation description is displayed to the user;
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
    func validate<T, R>(for validationTitle: String?, with rule: (_ o1: T, _ o2: R) -> (status: Bool, message: String?, returnValue: Any?), param1: T, param2: R, on view: UIViewController) -> Validator {
        if (validationsPassed) {
            let validationResult = rule(param1, param2)
            lastValidationResultData = validationResult.returnValue
            
            if (!validationResult.status) {
                validationsPassed = false
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
