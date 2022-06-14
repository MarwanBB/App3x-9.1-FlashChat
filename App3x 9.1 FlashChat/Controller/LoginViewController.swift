//
//  LoginViewController.swift
//  App3x 9.1 FlashChat
//
//  Created by Marwan Elbahnasawy on 27/05/2022.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        login()
        return true
    }
    
    @IBAction func loginClicked(_ sender: UIButton) {
        login()
    }
    
    func login() {
        if let email = emailTextField.text , let password = passwordTextField.text {
        Auth.auth().signIn(withEmail: email, password: password) {authResult, error in
            if error == nil {
            self.performSegue(withIdentifier: "loginToChat", sender: self)
            }
            else{
                print("Error when loging ---> \(error)")
            }
        
        }
        }
    }
    
}
