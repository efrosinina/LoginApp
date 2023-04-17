//
//  ViewController.swift
//  Login
//
//  Created by Елизавета Ефросинина on 07/04/2023.
//

import UIKit

class ViewController: UIViewController {
    //MARK: -- IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailLineView: UIView!
    @IBOutlet weak var passwordLineView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var letterImageView: UIImageView!
    @IBOutlet weak var lockImageView: UIImageView!
    
    //MARK: -- Properties
    private let wrongColor = UIColor.red
    private let defaultColor = UIColor.systemGray4
    private var email = "" {
        didSet {
            loginButton.isUserInteractionEnabled = !(email.isEmpty || password.isEmpty)
            loginButton.alpha = !(email.isEmpty || password.isEmpty) ? 1 : 0.5
        }
    }
    private var password: String = "" {
        didSet {
            loginButton.isUserInteractionEnabled = !(email.isEmpty && password.isEmpty)
            loginButton.alpha = !(email.isEmpty && password.isEmpty) ? 1 : 0.5
        }
    }
    private let mockEmail = "abc@gmail.com"
    private let mockPassword = "123Az*"
    private let emailRegex = #"^\S+@\S+\.\S+$"#
    private let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[$@$!%*?&#])[A-Za-z\\d$@$!%*?&#]{4,}$"
    
    //MARK: -- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        addShadow()
        emailTextField.becomeFirstResponder()
        loginButton.isUserInteractionEnabled = false
        loginButton.alpha = 0.5
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    //MARK: -- IBActions
    @IBAction func loginButtonAction(_ sender: Any) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        if check(email: emailTextField.text ?? "") && check(password: passwordTextField.text ?? "") {
            performSegue(withIdentifier: "goToNextScreen", sender: sender)
            lockImageView.tintColor = defaultColor
            passwordLineView.backgroundColor = defaultColor
            letterImageView.tintColor = defaultColor
            emailLineView.backgroundColor = defaultColor
        } else {
            makeErrorField(textField: emailTextField)
            makeErrorField(textField: passwordTextField)
            let alert = UIAlertController(title: "Error".localized,
                                          message: "Wrong e-mail or password".localized,
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: "OK".localized, style: .default)
            alert.addAction(action)
            present(alert, animated: true)
        }
        
    }
    
    @IBAction func signUpButtonAction(_ sender: UIButton) {}
    //MARK: -- Methods
    private func addShadow() {
        loginButton.layer.shadowColor = UIColor.black.cgColor
        loginButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        loginButton.layer.shadowOpacity = 0.2
        loginButton.layer.shadowRadius = 2
    }
}

//MARK: -- Extensions
extension ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !text.isEmpty else { return }
        switch textField {
        case emailTextField:
            let isValidEmail = check(email: text)
            
            if isValidEmail {
                email = text
                letterImageView.tintColor = defaultColor
                emailLineView.backgroundColor = defaultColor
            } else {
                email = ""
                makeErrorField(textField: textField)
            }
            
        case passwordTextField:
            let isValidPassword = check(password: text)
            
            if isValidPassword {
                password = text
                lockImageView.tintColor = defaultColor
                passwordLineView.backgroundColor = defaultColor
            } else {
                password = ""
                makeErrorField(textField: textField)
            }
            
        default:
            print("Error")
        }
    }
    //MARK: -- Methods for Extension
    private func check(email: String) -> Bool {
        return email == mockEmail && email.match(emailRegex) && !email.isEmpty
    }
    
    private func check(password: String) -> Bool {
        return password == mockPassword && password.count >= 4 && password.match(passwordRegex)
    }
    
    private func makeErrorField(textField: UITextField) {
        switch textField {
        case emailTextField:
            letterImageView.tintColor = wrongColor
            emailLineView.backgroundColor = wrongColor
        case passwordTextField:
            lockImageView.tintColor = wrongColor
            passwordLineView.backgroundColor = wrongColor
        default:
            print("Unknown text field")
        }
    }
}
