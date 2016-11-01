//
//  DashboardViewController.swift
//  fitness fifteen
//
//  Created by Hao Tang on 10/31/16.
//  Copyright © 2016 Hao Tang. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import FacebookShare
import Firebase
import FirebaseAuth

class DashboardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "DASHBOARD"
        print("item 1 loaded")
        
        if let user = FIRAuth.auth()?.currentUser {
            // User is signed in.
            print(user)
        } else {
            // No user is signed in.
            print("No user signed in ")
        }
        
        if (AccessToken.current) != nil {
            let params = ["fields" : "id, email, name"]
            let graphRequest = GraphRequest(graphPath: "me", parameters: params)
            graphRequest.start {
                (urlResponse, requestResult) in
                
                switch requestResult {
                    case .failed(let error):
                        print("error in graph request:", error)
                        break
                    case .success(let graphResponse):
                        if let responseDictionary = graphResponse.dictionaryValue {
                            print(responseDictionary)
                            
                            print(responseDictionary["name"])
                        }
                }
            }
        }else{
            print("No one logged in for Facebook!")
        }
        
    }
    
    

}
