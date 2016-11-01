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
import FacebookShare


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
        
        emailTextField.text = ""
        passwordTextField.text = ""
        
        FIRAuth.auth()!.signIn(withEmail: email, password: password) { (user, error) in
            
            if user != nil {
                
//                let loginManager = LoginManager()
//                
//                loginManager.logIn([ .publicProfile ], viewController: self) { loginResult in
//                    print(loginResult)
//                    
//                    switch loginResult {
//                        
//                    case .failed(let error):
//                        print(error)
//                    case .cancelled:
//                        print("User cancelled login.")
//                        loginManager.logOut()
//                    case .success(let grantedPermissions, let declinedPermissions, let accessToken):
//                        
//                        let credential = FIRFacebookAuthProvider.credential(withAccessToken: (AccessToken.current?.authenticationToken)!)
//                        
//                        print("GRANTED PERMISSIONS: \(grantedPermissions)")
//                        print("DECLINED PERMISSIONS: \(declinedPermissions)")
//                        print("ACCESS TOKEN \(accessToken)")
//                        
//                        FIRAuth.auth()?.currentUser?.link(with: credential) { (user, error) in
//                            // ...
//                            print("facebook authentication")
//                            if(error != nil){
//                                print("You have logined with same facebook acount")
//                            }
//                            
//                            let tabvc = TabBarController()
//                            let appdelegate = UIApplication.shared.delegate as! AppDelegate
//                            appdelegate.window!.rootViewController = tabvc
//                        }
//                        print("Logged in!")
//                        
//                    }
//                }
                
                let tabvc = TabBarController()
                
                let appdelegate = UIApplication.shared.delegate as! AppDelegate
                
                appdelegate.window!.rootViewController = tabvc
                
            } else {
                
                print(error)
            }
            
            
        }
        
        
        
    }
    

    @IBAction func btnRegisterPressed() {
        
        emailTextField.text = ""
        passwordTextField.text = ""
        
        let vc = SigninViewController(nibName: "SigninViewController", bundle: nil)
        
        present(vc, animated: true, completion: nil)
    }
    
}
