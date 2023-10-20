//
//  GFTabBarViewController.swift
//  GithubFollowers
//
//  Created by Ahmet Tarik DÖNER on 20.10.2023.
//

import UIKit

class GFTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        setViewControllers([createSearchNavigationController(), createfavoritesNavigationController()], animated: true)
    }
    
    private func createSearchNavigationController() -> UINavigationController {
        let searchViewController = GFSearchViewController()
        searchViewController.title = "Search"
        searchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchViewController)
    }
    
    private func createfavoritesNavigationController() -> UINavigationController {
        let favoritesListNavigationController = GFFavoritesListViewController()
        favoritesListNavigationController.title = "Favorites"
        favoritesListNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoritesListNavigationController)
    }
    
}
