//
//  FavoritesListViewController.swift
//  GithubFollowers
//
//  Created by Ahmet Tarik DÖNER on 11.10.2023.
//

import UIKit

final class GFFavoritesListViewController: GFDataLoadingViewController {
    
    private let tableView = UITableView()
    var favorites: [GFFollower] = []
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    
    //MARK: - Private
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GFFavoritesTableViewCell.self, forCellReuseIdentifier: GFFavoritesTableViewCell.cellIdentifier)
    }
    
    private func getFavorites() {
        GFPersistenceManager.retrieveFavorites {
            [weak self] result in
            switch result {
            case .success(let favorites):
                if favorites.isEmpty {
                    self?.showEmptyStateView(with: "No favorites\nAdd one to the favorite screen", in: self!.view)
                } else {
                    self?.favorites = favorites
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                        self?.view.bringSubviewToFront(self!.tableView)
                    }
                }
            case .failure(let error):
                self?.presentGFCustomAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
}

extension GFFavoritesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GFFavoritesTableViewCell.cellIdentifier) as? GFFavoritesTableViewCell else { return UITableViewCell() }
        let favorite = favorites[indexPath.row]
        cell.set(favorite: favorite)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let destinationVC = GFFollowersListViewController(username: favorite.login)
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let favorite = favorites[indexPath.row]
        favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        
        GFPersistenceManager.updateWith(favorite: favorite, actionType: .remove) {
            [weak self] error in
            guard let error = error else { return }
            self?.presentGFCustomAlertOnMainThread(title: "Unable to remove", message: error.rawValue, buttonTitle: "OK")
        }
    }
}
