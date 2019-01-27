//
//  ViewControllerExtensions.swift
//  CatFacts
//
//  Created by  William on 1/20/19.
//  Copyright © 2019 Vasiliy Lada. All rights reserved.
//

import Foundation
import UIKit

/**
 View Controller that contains a form with text fields.
 Conforms UITextFieldDelegate to add response functionality for the form fields.
*/
class FormFiewController: UIViewController, UITextFieldDelegate {
    
    /**
     Set of text fields that belong to the form displayed on the screen.
    */
    var formTextFields = [UITextField]() {
        didSet {
            formTextFields.forEach { formField in
                formField.delegate = self
            }
        }
        willSet(newValue) {
            formTextFields.forEach { formField in
                formField.delegate = nil
            }
        }
    }
    
    override func viewDidLoad() {
        self.hideKeyboardWhenTappedAround()
        super.viewDidLoad()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField.returnKeyType == .done) {
            textField.resignFirstResponder()
            return false
        }
        
        let nextTag = textField.tag + 1
        
        var nextControl = textField.superview?.viewWithTag(nextTag)
        if (nextControl == nil) {
            nextControl = textField.superview?.superview?.viewWithTag(nextTag)
        }
        
        if (nextControl == nil) {
            textField.resignFirstResponder()
            return false
        } else {
            nextControl!.becomeFirstResponder()
            return false
        }
    }
}

/**
 Adds a method for activating keyboard autohiding feature when user taps outside text fields.
*/
extension FormFiewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:    #selector(FormFiewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
