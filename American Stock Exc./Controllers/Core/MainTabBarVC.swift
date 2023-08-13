//
//  MainTabBarVC.swift
//  College Website
//
//  Created by Atharva Padekar on 02/08/23.
//

import UIKit

class MainTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .systemYellow
        
        
        let vc1 = UINavigationController(rootViewController: HomeVC())

        let vc3 = UINavigationController(rootViewController: SearchVC())

        
        
        vc1.tabBarItem.image = UIImage(systemName: "house.fill")

        vc3.tabBarItem.image = UIImage(systemName: "magnifyingglass")

        
        vc1.title = "Home"
        vc3.title = "Search"

        tabBar.tintColor = .label
        setViewControllers([vc1,vc3], animated: true)
    }
        
        
}
    
    
    

