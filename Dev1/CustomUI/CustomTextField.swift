//
//  CustomTextField.swift
//  Dev1
//
//  Created by Даниил Сивожелезов on 20.07.2024.
//

import UIKit

final class CustomTextField {
    static func createTextField(placeholder: String, keyboardType: UIKeyboardType = .default, autocapitalizationType: UITextAutocapitalizationType = .none) -> UITextField {
        let textField = UITextField()
        textField.autocorrectionType = .no
        textField.autocapitalizationType = autocapitalizationType
        textField.placeholder = placeholder
        textField.keyboardType = keyboardType
        textField.borderStyle = .roundedRect
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        textField.leftViewMode = .always
        return textField
    }
}
