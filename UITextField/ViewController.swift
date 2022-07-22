//
//  ViewController.swift
//  UITextField
//
//  Created by Damir Chalkarov on 22.07.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var login: UITextField!
    var password = UITextField()
    var validator = Validator()
    var storage = Storage.initial
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        login.delegate = self
        
        view.addSubview(password)
        password.delegate = self
        password.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            password.topAnchor.constraint(equalTo: login.bottomAnchor, constant: 32),
            password.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            password.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)])
        
        password.borderStyle = .roundedRect
        password.placeholder = "enter password"
        password.isSecureTextEntry = true
//        password.keyboardType = .phonePad
        password.keyboardAppearance = .dark
        password.clearButtonMode = .always
        
    }
}

extension ViewController: UITextFieldDelegate {
 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == login {
            password.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case login:
            break
        case password: return validator.hasNumbers(text: string)
        default:
            break
        }
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if textField.isEditing {
            return true
        }
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == login {
            storage.login = textField.text!
        } else {
            storage.password = textField.text!
            print(storage.login, storage.password)
        }
    }
    
}

struct Validator {
    let numbers = "1234567890"
    
    func hasNumbers(text: String) -> Bool {
        for number in numbers {
            if text.contains(number) { return true }
        }
        return false
    }
}

struct Storage {
    var login = ""
    var password = ""
    
    static let initial = Storage()
}
