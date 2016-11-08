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

class DashboardViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var gymCollectionView: UICollectionView!
    @IBOutlet weak var fbFriendsCollectionView: UICollectionView!
    
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
        
        self.gymCollectionView.dataSource = self
        self.fbFriendsCollectionView.dataSource = self
        
        self.gymCollectionView.delegate = self
        self.fbFriendsCollectionView.delegate = self
        
        let nib1 = UINib(nibName: "DashboardGymViewCell", bundle: nil)
        self.gymCollectionView.register(nib1, forCellWithReuseIdentifier: "customGymViewCell")
        
        let nib2 = UINib(nibName: "DashboardCollectionViewCell", bundle: nil)
        self.fbFriendsCollectionView.register(nib2, forCellWithReuseIdentifier: "customCollectionCell")
        
        getFacebookFriends()
        
    }
    
    func getFacebookFriends() {
        
        let params = ["fields": "id, first_name, last_name, middle_name, name, email, picture"]
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
//                            let friendPicture = valueDic.value(forKey: "picture") as! NSDictionary
//                            let data = friendPicture.value(forKey: "data") as! NSDictionary
//                            let urlStr = data.value(forKey: "url")
//                            print("url string is \(urlStr)")
//                            self.userFriendsProfileImages.add(urlStr)
                            let friendId = valueDic.value(forKey: "id") as! String
                            let str = "https://graph.facebook.com/" + friendId + "/picture?type=large"
                            self.userFriendsProfileImages.add(str)
                            
                        }
                        self.fbFriendsCollectionView.reloadData()
                    }
            }
        }
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == gymCollectionView {
            return gymNames.count
        }
        return self.userFriendsNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.gymCollectionView {
            let heightForCell = 194
            return CGSize(width: gymCollectionView.bounds.size.width, height: CGFloat(heightForCell))
        } else{
            let widthForCell = 112
            let heightForCell = 93
            return CGSize(width: widthForCell, height: heightForCell)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.gymCollectionView {
            
            let cell = self.gymCollectionView.dequeueReusableCell(withReuseIdentifier: "customGymViewCell", for: indexPath) as! DashboardGymViewCell
            
            cell.loadItem(title: gymNames[indexPath.row], imageName: gymImages[indexPath.row], gymWebsite: gymWebsites[indexPath.row])
            
            return cell
            
        } else {
            
            let cell = self.fbFriendsCollectionView.dequeueReusableCell(withReuseIdentifier: "customCollectionCell", for: indexPath) as! DashboardCollectionViewCell
            
            cell.loadItems(name: self.userFriendsNames[indexPath.row] as! String, imageUrl: self.userFriendsProfileImages[indexPath.row] as! String)
            
            return cell
        }
        
    }
    
    

}
