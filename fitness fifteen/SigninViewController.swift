//
//  SigninViewController.swift
//  fitness fifteen
//
//  Created by Hao Tang on 10/26/16.
//  Copyright © 2016 Hao Tang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SigninViewController: UIViewController {
    
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func btnLoginPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnRegisterPressed(_ sender: UIButton) {
        
        let email = emailField.text
        let password = passwordField.text
        
        FIRAuth.auth()!.createUser(withEmail: email!,
                                   password: password!) { user, error in
            if error == nil {
                
                FIRAuth.auth()!.signIn(withEmail: email!,
                                       password: password!)
            }
        }
    }

}
