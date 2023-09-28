//
//  BaseTabBarController.swift
//  Movies
//
//  Created by Данік on 16/09/2023.
//

import Foundation
import UIKit
import AsyncDisplayKit

class BaseTabBarController: ASTabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create instances of the view controllers wrapped in ASNavigationController
        let homeNode = HomeViewControllerNode()
        let firstVC = ASDKNavigationController(rootViewController: ASDKViewController(node: homeNode))
        
        let searchNode = SearchViewControllerNode()
        let secondVC = ASDKNavigationController(rootViewController: searchNode)
        
        let plusNode = PlusViewControllerNode()
        let thirdVC = ASDKNavigationController(rootViewController: ASDKViewController(node: plusNode))
        
        let profileNode = ProfileViewControllerNode()
        let fourthVC = ASDKNavigationController(rootViewController: ASDKViewController(node: profileNode))
        
        firstVC.tabBarItem.image = UIImage(named: "homeIcon")?.withRenderingMode(.alwaysTemplate)
        secondVC.tabBarItem.image = UIImage(named: "searchIcon")?.withRenderingMode(.alwaysTemplate)
        thirdVC.tabBarItem.image = UIImage(named: "plusIcon")?.withRenderingMode(.alwaysTemplate)
        fourthVC.tabBarItem.image = UIImage(named: "savedImage")?.withRenderingMode(.alwaysTemplate)
        
        // Set tab bar items, images, etc. for each navigation controller here if needed
        viewControllers = [firstVC, secondVC, thirdVC, fourthVC]
        tabBar.tintColor = K.tabBarSelectedItemColor
        tabBar.unselectedItemTintColor = .darkGray
        tabBar.barTintColor = K.tabBarTintColor
        tabBar.isTranslucent = true
    }
}

