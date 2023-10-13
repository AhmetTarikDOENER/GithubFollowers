//
//  FollowersListViewController.swift
//  GithubFollowers
//
//  Created by Ahmet Tarik DÖNER on 12.10.2023.
//

import UIKit

final class GFFollowersListViewController: UIViewController {

    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        GFNetworkManager.shared.getFollowers(for: username, page: 1) {
            [weak self] result in
            switch result {
            case .success(let followers):
                print(followers)
            case .failure(let error):
                self?.presentGFCustomAlertOnMainThread(title: "Bad Stuff Happened.", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
