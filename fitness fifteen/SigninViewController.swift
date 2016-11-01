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
import FacebookCore
import FacebookLogin


class SigninViewController: UIViewController {
    
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func btnLoginPressed(_ sender: UIButton) {
        
        emailField.text = ""
        passwordField.text = ""
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnRegisterPressed(_ sender: UIButton) {
        
        let email = emailField.text
        let password = passwordField.text
        
        FIRAuth.auth()!.createUser(withEmail: email!,
                                   password: password!) { user, error in
            if error == nil {
                
                FIRAuth.auth()!.signIn(withEmail: email!,password: password!)
                
                let loginManager = LoginManager()
                
                loginManager.logIn([ .publicProfile ], viewController: self) { loginResult in
                    print(loginResult)
                    
                    switch loginResult {
                        
                        case .failed(let error):
                            print(error)
                        case .cancelled:
                            print("User cancelled login.")
                            loginManager.logOut()
                        case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                            let credential = FIRFacebookAuthProvider.credential(withAccessToken: (AccessToken.current?.authenticationToken)!)
                            
                            print("GRANTED PERMISSIONS: \(grantedPermissions)")
                            print("DECLINED PERMISSIONS: \(declinedPermissions)")
                            print("ACCESS TOKEN \(accessToken)")
                            
                            FIRAuth.auth()?.currentUser?.link(with: credential) { (user, error) in
                                // ...
                                print("facebook authentication")
                                if(error != nil){
                                    print("You have logined with same facebook acount")
                                }
                                let tabvc = TabBarController()
                                
                                let appdelegate = UIApplication.shared.delegate as! AppDelegate
                                
                                appdelegate.window!.rootViewController = tabvc
                            }
                            print("Logged in!")
                    }
                }
                
           }
       }

    }
}
