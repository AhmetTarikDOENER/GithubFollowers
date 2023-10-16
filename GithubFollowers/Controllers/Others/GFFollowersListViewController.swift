//
//  FollowersListViewController.swift
//  GithubFollowers
//
//  Created by Ahmet Tarik DÖNER on 12.10.2023.
//

import UIKit

final class GFFollowersListViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    var username: String!
    var followers: [GFFollower] = []
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, GFFollower>!
    var page: Int = 1
    var hasMoreFollowers = true
    var filteredFollowers: [GFFollower] = []
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers(username: username, page: page)
        configureDataSource()
        configureSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    //MARK: - Private
    
    private func getFollowers(username: String, page: Int){
        showLoadingView()
        GFNetworkManager.shared.getFollowers(for: username, page: page) {
            [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let followers):
                if followers.count < 100 { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)
                if self.followers.isEmpty {
                    let message = "This user doesn`t have any followers.😢"
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: message, in: self.view)
                    }
                    return
                }
                self.updateData(on: self.followers)
            case .failure(let error):
                self.presentGFCustomAlertOnMainThread(title: "Bad Stuff Happened.", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(GFFollowerCollectionViewCell.self, forCellWithReuseIdentifier: GFFollowerCollectionViewCell.cellIdentifier)
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, GFFollower>(collectionView: collectionView, cellProvider: {
            collectionView, indexPath, follower -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GFFollowerCollectionViewCell.cellIdentifier, for: indexPath) as? GFFollowerCollectionViewCell
            cell?.set(follower: follower)
            
            return cell
        })
    }
    
    private func updateData(on followers: [GFFollower]) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, GFFollower>()
        snapShot.appendSections([.main])
        snapShot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapShot, animatingDifferences: true)
        }
    }
    
    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Type username for searching"
        searchController.obscuresBackgroundDuringPresentation = true
        navigationItem.searchController = searchController
    }
}

extension GFFollowersListViewController: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }
}

extension GFFollowersListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(on: followers)
    }
}
