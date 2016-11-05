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
import FacebookLogin
import FacebookCore


class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func btnLoginPressed(_ sender: AnyObject) {
        
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        FIRAuth.auth()!.signIn(withEmail: email, password: password) { (user, error) in
            
            if user != nil {
                
                if AccessToken.current == nil{
                    print("User did not login with Facebook")
                    let loginManager = LoginManager()
                    loginManager.logIn([ .publicProfile, .userFriends ], viewController: self) { loginResult in
                        switch loginResult {
                        case .failed(let error):
                            print(error)
                            return
                        case .cancelled:
                            print("User cancelled login.")
                            return
                        case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                            
                            print("GRANTED PERMISSIONS: \(grantedPermissions)")
                            print("DECLINED PERMISSIONS: \(declinedPermissions)")
                            print("ACCESS TOKEN \(accessToken)")
                            
                            let tabvc = TabBarController()
                            let appdelegate = UIApplication.shared.delegate as! AppDelegate
                            appdelegate.window!.rootViewController = tabvc
                        }
                    }
                } else {
                    let tabvc = TabBarController()
                    let appdelegate = UIApplication.shared.delegate as! AppDelegate
                    appdelegate.window!.rootViewController = tabvc
                }
                
                
                
            } else {
                print(error)
            }
            
            
        }
        
    }
    

    @IBAction func btnRegisterPressed() {
        
        let vc = SigninViewController(nibName: "SigninViewController", bundle: nil)
        present(vc, animated: true, completion: nil)
        
        //clear email field and password field
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
}
