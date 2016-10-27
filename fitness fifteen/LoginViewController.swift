//
//  LoginViewController.swift
//  fitness fifteen
//
//  Created by Hao Tang on 10/26/16.
//  Copyright © 2016 Hao Tang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func btnLoginPressed(_ sender: AnyObject) {
        
        FIRAuth.auth()!.signIn(withEmail: emailTextField.text!,
                               password: passwordTextField.text!)
        
    }
    

    @IBAction func btnRegisterPressed() {
        
        let vc = SigninViewController(nibName: "SigninViewController", bundle: nil)
        
        present(vc, animated: true, completion: nil)
    }
    
}
