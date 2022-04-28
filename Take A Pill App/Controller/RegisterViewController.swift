//
//  RegisterViewController.swift
//  Take A Pill App
//
//  Created by Maciej Sałuda on 21/02/2022.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var RegisterButtonPressed: UIButton!
    @IBAction func RegisterButtonPressed(_ sender: UIButton) {
        if let user = emailTextField.text ,
           let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: user, password: password) {authResult, error in
                if let error = error {
                    print(error.localizedDescription)
                    self.performSegue(withIdentifier: "RegisterToMain", sender: self)
                    
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        RegisterButtonPressed.layer.cornerRadius = 15
    }
}
