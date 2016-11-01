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

//        view.backgroundColor = UIColor.green
        self.title = "SETTINGS"
        print("item 4 loaded")
    }

    @IBAction func logoutBtnPressed(_ sender: UIButton) {
        let loginManager = LoginManager()
        loginManager.logOut()
        try! FIRAuth.auth()!.signOut()
    }
}
