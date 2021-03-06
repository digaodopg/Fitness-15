//
//  DashboardGymViewCell.swift
//  fitness fifteen
//
//  Created by Hao Tang on 11/7/16.
//  Copyright © 2016 Hao Tang. All rights reserved.
//

import UIKit

class DashboardGymViewCell: UICollectionViewCell {
    
    @IBOutlet weak var gymNameLabel: UILabel!
    @IBOutlet weak var gymImageView: UIImageView!
    @IBOutlet weak var gymWebsiteLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        gymImageView.layer.borderWidth = 1
        gymImageView.layer.masksToBounds = false
        gymImageView.layer.borderColor = UIColor.black.cgColor
        gymImageView.layer.cornerRadius = gymImageView.frame.height/2
        gymImageView.clipsToBounds = true
    }
    
    func loadItem(title: String, imageName: String, gymWebsite: String){
        
        gymNameLabel.text = title
        gymImageView.image = UIImage(named: imageName)
        gymWebsiteLabel.text = gymWebsite
    }

}
