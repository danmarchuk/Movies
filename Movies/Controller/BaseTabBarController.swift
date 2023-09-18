//
//  BaseTabBarController.swift
//  Movies
//
//  Created by Данік on 16/09/2023.
//

import Foundation
import UIKit

class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create instances of the view controllers wrapped in navigation controllers
        let firstVC = UINavigationController(rootViewController: HomeViewController())
        let secondVC = UINavigationController(rootViewController: SearchViewController())
        let thirdVC = UINavigationController(rootViewController: PlusViewController())
        let fourthVC = UINavigationController(rootViewController: ProfileViewController())
        
        firstVC.tabBarItem.image = UIImage(named: "homeIcon")?.withRenderingMode(.alwaysTemplate)
        secondVC.tabBarItem.image = UIImage(named: "searchIcon")?.withRenderingMode(.alwaysTemplate)
        thirdVC.tabBarItem.image = UIImage(named: "plusIcon")?.withRenderingMode(.alwaysTemplate)
        // add a rounded image of a user
        fourthVC.tabBarItem.image = UIImage(named: "savedImage")?.withRenderingMode(.alwaysTemplate)
        
        // Set tab bar items, images, etc. for each navigation controller here if needed
        viewControllers = [firstVC, secondVC, thirdVC, fourthVC]
        tabBar.tintColor = K.tabBarSelectedItemColor // Or some other contrasting color
        tabBar.unselectedItemTintColor = .darkGray // Or any other color
        tabBar.barTintColor = K.tabBarTintColor
        tabBar.isTranslucent = false
    }
}
