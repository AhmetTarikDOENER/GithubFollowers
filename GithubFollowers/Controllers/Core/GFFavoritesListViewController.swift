//
//  FavoritesListViewController.swift
//  GithubFollowers
//
//  Created by Ahmet Tarik DÖNER on 11.10.2023.
//

import UIKit

final class GFFavoritesListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBrown
        
        GFPersistenceManager.retrieveFavorites {
            result in
            switch result {
            case .success(let favorites):
                print(favorites)
            case .failure(let error):
                break
            }
        }
    }
}
