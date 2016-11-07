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

class DashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let gymNames = ["WashU Athletic Complex","WashU South 40 gym"]
    let gymImages = ["ac-image.jpg","s40-image.jpg"]
    let gymWebsites = ["http://bearsports.wustl.edu/facilities/athletics-complex","http://rec.wustl.edu/landing/index"]
    var userFacebookFriends: NSArray = []
    var userFriendsNames: NSMutableArray = []
    var userFriendsProfileImages: NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "DASHBOARD"
        print("item 1 loaded")
        
        if (AccessToken.current) != nil {
            let params = ["fields" : "id, name, email"]
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
        } else {
            print("No one logged in for Facebook!")
        }
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        let nib = UINib(nibName: "DashboardCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "customCell")
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        let newNib = UINib(nibName: "DashboardCollectionViewCell", bundle: nil)
        self.collectionView.register(newNib, forCellWithReuseIdentifier: "customCollectionCell")
        
        getFacebookFriends()
        
//        self.collectionView.reloadData()
    }
    
    func getFacebookFriends() {
        
        let params = ["fields": "id, first_name, last_name, middle_name, name, email, picture"]
//        let request = FBSDKGraphRequest(graphPath: "me/friends", parameters: params)
        let request = GraphRequest(graphPath: "me/friends", parameters: params)
        
        request.start {
            (urlResponse, requestResult) in
            
            switch requestResult {
                case .failed(let error):
                    print("error in graph request:", error)
                    break
                case .success(let graphResponse):
                    if let responseDictionary = graphResponse.dictionaryValue {

                        print(responseDictionary["data"])
                        let data = responseDictionary["data"] as! NSArray
                        self.userFacebookFriends = responseDictionary["data"] as! NSArray
                        
                        for i in 0..<data.count{
                            let valueDic = data[i] as! NSDictionary
                            self.userFriendsNames.add(valueDic.value(forKey: "name"))
                            let friendPicture = valueDic.value(forKey: "picture") as! NSDictionary
                            let data = friendPicture.value(forKey: "data") as! NSDictionary
                            let urlStr = data.value(forKey: "url")
                            print("url string is \(urlStr)")
                            self.userFriendsProfileImages.add(urlStr)
                            
                        }
                        self.collectionView.reloadData()
                    }
            }
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gymNames.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 209
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = self.tableView.dequeueReusableCell(withIdentifier: "customCell") as! DashboardCell
        
        myCell.loadItem(title: gymNames[indexPath.row], imageName: gymImages[indexPath.row], gymWebsite: gymWebsites[indexPath.row])
        
        return myCell
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(self.userFacebookFriends.count)
        return self.userFacebookFriends.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "customCollectionCell", for: indexPath) as! DashboardCollectionViewCell
        
//        myCell.loadItems(name: self.userFriendsNames[indexPath.row] as! String, imageUrl: self.userFriendsProfileImages[indexPath.row] as! String)
        cell.loadItems(name: self.userFriendsNames[indexPath.row] as! String)
        
        return cell
    }
    
    

}
