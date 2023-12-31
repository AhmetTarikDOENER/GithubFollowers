//
//  FollowersListViewController.swift
//  GithubFollowers
//
//  Created by Ahmet Tarik DÖNER on 12.10.2023.
//

import UIKit

/// Followers list view
final class GFFollowersListViewController: GFDataLoadingViewController {
    
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
    var onSearching = false
    var isLoadingMoreFollowers = false
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        title = username
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
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
    
    private func getFollowers(username: String, page: Int) {
        showLoadingView()
        isLoadingMoreFollowers = true
        Task {
            do {
                let followers = try await GFNetworkManager.shared.getFollowers(for: username, page: page)
                updateUI(with: followers)
                dismissLoadingView()
            } catch {
                if let gfError = error as? GFError {
                    presentGFCustomAlert(title: "Bad Stuff Happened.", message: gfError.rawValue, buttonTitle: "OK")
                } else {
                    presentDefaultError()
                }
                dismissLoadingView()
            }
        }
    }
    
    private func updateUI(with followers: [GFFollower]) {
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
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc private func didTapAddButton() {
        showLoadingView()
        Task {
            do {
                let user = try await GFNetworkManager.shared.getUserInfo(for: username)
                addUserToFavorites(user: user)
                dismissLoadingView()
            } catch {
                if let gfError = error as? GFError {
                    presentGFCustomAlert(title: "Something went wrong", message: gfError.rawValue, buttonTitle: "OK")
                } else {
                    presentDefaultError()
                }
                dismissLoadingView()
            }
        }
    }
    
    private func addUserToFavorites(user: GFUser) {
        let favorite = GFFollower(login: user.login, avatarUrl: user.avatarUrl)
        GFPersistenceManager.updateWith(favorite: favorite, actionType: .add) {
            [weak self] error in
            guard let error = error else {
                DispatchQueue.main.async {
                    self?.presentGFCustomAlert(title: "Success!", message: "The user has succesfully added to favorite list", buttonTitle: "OK")
                }
                return
            }
            DispatchQueue.main.async {
                self?.presentGFCustomAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
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
        
        searchController.searchBar.placeholder = "Type username for searching"
        searchController.obscuresBackgroundDuringPresentation = true
        navigationItem.searchController = searchController
    }
}

//MARK: - UICollectionViewDelegate

extension GFFollowersListViewController: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers, !isLoadingMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentArrayType = onSearching ? filteredFollowers : followers
        let follower = currentArrayType[indexPath.item]
        
        let destinationVC = GFUserInfoViewController()
        destinationVC.username = follower.login
        destinationVC.delegate = self
        let navController = UINavigationController(rootViewController: destinationVC)
        present(navController, animated: true)
    }
}

//MARK: - UISearchBarDelegate & UISearchResultUpdating

extension GFFollowersListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredFollowers.removeAll()
            updateData(on: followers)
            onSearching = false
            return
        }
        onSearching = true
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollowers)
    }
}

extension GFFollowersListViewController: GFUserInfoViewControllerDelegate {
    func gfDidRequestFollowers(for username: String) {
        self.username = username
        title = username
        page = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        updateData(on: followers)
        getFollowers(username: username, page: page)
    }
}





//GFNetworkManager.shared.getFollowers(for: username, page: page) {
//    [weak self] result in
//    guard let self = self else { return }
//    self.dismissLoadingView()
//    switch result {
//    case .success(let followers):
//        updateUI(with: followers)
//    case .failure(let error):
//        self.presentGFCustomAlertOnMainThread(title: "Bad Stuff Happened.", message: error.rawValue, buttonTitle: "OK")
//    }
//}
