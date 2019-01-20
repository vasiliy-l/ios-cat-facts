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
 Collection of predefined validation rules for text fields.
 */
class TextFieldsValidations {
    
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
}
