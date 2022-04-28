//
//  ViewController.swift
//  Take A Pill App
//
//  Created by Maciej Sałuda on 21/02/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var RegisterButton: UIButton!
    @IBOutlet weak var LogInButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBAction func RegisterButton(_ sender: UIButton) {
        performSegue(withIdentifier: "ToRegistrationView", sender: self)
    }
    @IBAction func LogInButton(_ sender: UIButton) {
        
        performSegue(withIdentifier: "ToLogInView", sender: self)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "Take a pill App"
        LogInButton.layer.cornerRadius = 15
        RegisterButton.layer.cornerRadius = 15
    }
    
    
}

