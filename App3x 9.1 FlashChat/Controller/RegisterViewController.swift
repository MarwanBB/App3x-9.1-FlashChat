//
//  RegisterViewController.swift
//  App3x 9.1 FlashChat
//
//  Created by Marwan Elbahnasawy on 27/05/2022.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        passwordTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        registeration()
        return true
    }
    
    @IBAction func registerClicked(_ sender: UIButton) {
        registeration()
    }
    
    func registeration(){
        if let email = emailTextField.text , let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if error == nil {
                self.performSegue(withIdentifier: "registerToChat", sender: self)
                }
                else {
                    print("Error when registering ---> \(error)")
                }
            }
        }
    }
    
}
