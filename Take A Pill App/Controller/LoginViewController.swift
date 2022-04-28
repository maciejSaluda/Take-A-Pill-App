//
//  LoginViewController.swift
//  Take A Pill App
//
//  Created by Maciej Sałuda on 21/02/2022.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var LogInButtonPressed: UIButton!
    @IBAction func LogInButtonPressed(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            
            Auth.auth().signIn(withEmail: email, password: password) {authResult, error in
                if let er = error {
                    print(er.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: "LoginToMain", sender: self)
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentUser = Auth.auth().currentUser
        if currentUser != nil {
            performSegue(withIdentifier: "LoginToMain", sender: self)
            LogInButtonPressed.layer.cornerRadius = 15
        }
        
        
        
        
    }
}
