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
    
    
    //MARK: -- IBActions
    @IBAction func loginButtonAction(_ sender: UIButton) {
        
    }
    
    @IBAction func signUpButtonAction(_ sender: UIButton) {
    }
    
    
    //MARK: -- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addShadow()
    }
    
    //MARK: -- Methods
    private func addShadow() {
        loginButton.layer.shadowColor = UIColor.black.cgColor
        loginButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        loginButton.layer.shadowOpacity = 0.2
        loginButton.layer.shadowRadius = 2
    }
}


