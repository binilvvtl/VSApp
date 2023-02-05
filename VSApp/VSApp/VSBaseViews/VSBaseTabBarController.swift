//
//  BaseTabBarController.swift
//  VSApp
//
//  Created by Binil-V on 05/02/23.
//

import UIKit


class VSBaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTabBar()
    }
    
    private func setupTabBar() {
        tabBar.barTintColor = .black
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .lightGray
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = .black
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        
        let homeViewController = Storyboards.productList.instantiateVC(ProductListViewController.self)
        let homeNavigationController = VSBaseNavigationController(rootViewController: homeViewController)
        homeNavigationController.tabBarItem = UITabBarItem(title: "home".localized(), image: UIImage(systemName: "homekit"), selectedImage: UIImage(systemName: "homekit"))
        
        let profileViewController = Storyboards.profile.instantiateVC(ProfileViewController.self)
        let profileNavigationController = VSBaseNavigationController(rootViewController: profileViewController)
        profileNavigationController.tabBarItem = UITabBarItem(title: "profile".localized(), image: UIImage(systemName: "person.fill"), selectedImage: UIImage(systemName: "person.fill"))
        
        viewControllers = [homeNavigationController, profileNavigationController]
      }

}
