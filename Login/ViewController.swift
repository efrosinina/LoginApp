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
    @IBOutlet weak var donthaveAnAccountLabel: UILabel!
    
    //MARK: -- Properties
    var isLoginScreen: Bool = true
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
    
    private let emailRegex = #"^\S+@\S+\.\S+$"#
    
    //MARK: -- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        donthaveAnAccountLabel.isHidden = !isLoginScreen
        signUpButton.isHidden = !isLoginScreen
        emailTextField.delegate = self
        passwordTextField.delegate = self
        addShadow()
        emailTextField.becomeFirstResponder()
        loginButton.isUserInteractionEnabled = false
        loginButton.alpha = 0.5
        setupLoginButton()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    //MARK: -- IBActions
    @IBAction func loginButtonAction(_ sender: Any) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        if isLoginScreen {
            if KeyChainManager.checkUser(with: email, password: password) {
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
        } else {
            if KeyChainManager.save(email: email, password: password) {
                performSegue(withIdentifier: "goToNextScreen", sender: sender)
            } else {
                debugPrint("Error with saving email and password")
            }
        }
    }
    
    @IBAction func signUpButtonAction(_ sender: UIButton) {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as? ViewController else { return }
        viewController.isLoginScreen = false
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    //MARK: -- Private Methods
    private func addShadow() {
        loginButton.layer.shadowColor = UIColor.black.cgColor
        loginButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        loginButton.layer.shadowOpacity = 0.2
        loginButton.layer.shadowRadius = 2
    }
    
    private func setupLoginButton() {
        loginButton.setTitle(isLoginScreen ? "Login".localized.uppercased() : "Register".localized.uppercased(), for: .normal)
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
        return email.match(emailRegex) && !email.isEmpty
    }
    
    private func check(password: String) -> Bool {
        return password.count >= 4
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
