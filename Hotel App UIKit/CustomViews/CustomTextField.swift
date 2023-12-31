//
//  CustomTextField.swift
//  Hotel App UIKit
//
//  Created by Анастасия on 29.12.2023.
//

import UIKit


extension UITextField {
    class func textFieldInfo(placeholder: String, numberPad: Bool) -> UITextField {
        let textField = UITextField()
         textField.translatesAutoresizingMaskIntoConstraints = false
         textField.placeholder = placeholder
         textField.clearButtonMode = .whileEditing
        textField.layer.cornerRadius = Constants.CornerRadius.radius10
         textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
         textField.widthAnchor.constraint(equalToConstant: 340).isActive = true
         textField.backgroundColor = .systemGray6
        if numberPad {
            textField.keyboardType = .numberPad
        }
         return textField
    }

}
