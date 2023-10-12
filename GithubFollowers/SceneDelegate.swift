//
//  SceneDelegate.swift
//  GithubFollowers
//
//  Created by Ahmet Tarik DÖNER on 10.10.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = createTabbarController()
        window?.makeKeyAndVisible()
        
        configureNavBar()
    }
    
    //MARK: - Private
    
    private func createSearchNavigationController() -> UINavigationController {
        let searchViewController = SearchViewController()
        searchViewController.title = "Search"
        searchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchViewController)
    }
    
    private func createfavoritesNavigationController() -> UINavigationController {
        let favoritesListNavigationController = FavoritesListViewController()
        favoritesListNavigationController.title = "Favorites"
        favoritesListNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoritesListNavigationController)
    }
    
    private func createTabbarController() -> UITabBarController {
        let tabbar = UITabBarController()
        UITabBar.appearance().tintColor = .systemGreen
        tabbar.setViewControllers([createSearchNavigationController(), createfavoritesNavigationController()], animated: true)
        
        return tabbar
    }
    
    private func configureNavBar() {
        UINavigationBar.appearance().tintColor = .systemGreen
    }
    

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}

}

