//
//  DashboardCollectionViewCell.swift
//  fitness fifteen
//
//  Created by Hao Tang on 11/6/16.
//  Copyright © 2016 Hao Tang. All rights reserved.
//

import UIKit

class DashboardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var friendProfilePicture: UIImageView!
    @IBOutlet weak var friendName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    func loadItems(name: String, imageUrl: String){
//        if let checkedUrl = URL(string: imageUrl) {
//            friendProfilePicture.contentMode = .scaleAspectFit
//            downloadImage(url: checkedUrl)
//        }
//        self.friendName.text = name
//    }
    
    func loadItems(name: String){
//        if let checkedUrl = URL(string: imageUrl) {
//            friendProfilePicture.contentMode = .scaleAspectFit
//            downloadImage(url: checkedUrl)
//        }
        self.friendName.text = name
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL) {
        print("Download Started")
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { () -> Void in
                self.friendProfilePicture.image = UIImage(data: data)
            }
        }
    }
    
}
