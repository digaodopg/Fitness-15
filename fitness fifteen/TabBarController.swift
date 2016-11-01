//
//  TabBarController.swift
//  fitness fifteen
//
//  Created by Hao Tang on 10/30/16.
//  Copyright © 2016 Hao Tang. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let item4 = SettingViewController()
        let icon4 = UITabBarItem(title: "SETTINGS", image: UIImage(named: "settings-icon.png"), selectedImage: UIImage(named: "settings-selected-icon.png"))
        item4.tabBarItem = icon4
        let item1 = DashboardViewController()
        let icon1 = UITabBarItem(title: "DASHBOARD", image: UIImage(named: "dashboard-icon.png"), selectedImage: UIImage(named: "dashboard-selected-icon.png"))
        item1.tabBarItem = icon1
        let controllers = [item1, item4]  //array of the root view controllers displayed by the tab bar interface
        self.viewControllers = controllers
    }
    
    //Delegate methods
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        print("Should select viewController: \(viewController.title) ?")
        return true;
    }

}
