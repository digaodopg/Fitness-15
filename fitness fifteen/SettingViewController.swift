//
//  SettingViewController.swift
//  fitness fifteen
//
//  Created by Hao Tang on 10/30/16.
//  Copyright © 2016 Hao Tang. All rights reserved.
//

import UIKit
import FacebookLogin
import FirebaseAuth

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "SETTINGS"
        print("item 4 loaded")
    }

    @IBAction func logoutBtnPressed(_ sender: UIButton) {
        
        try! FIRAuth.auth()!.signOut()
        
        //log out move to login view
        let loginvc = LoginViewController(nibName: "LoginViewController", bundle: nil)
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window!.rootViewController = loginvc
        
    }
}
