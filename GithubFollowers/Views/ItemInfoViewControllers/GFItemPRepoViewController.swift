//
//  GFItemPRepoView.swift
//  GithubFollowers
//
//  Created by Ahmet Tarik DÖNER on 19.10.2023.
//

import UIKit

class GFItemPRepoViewController: GFItemInfoViewController {
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    //MARK: - Private
    
    private func configureItems() {
        firstItemInfoView.set(itemInfoType: .repos, with: user.publicRepos)
        secondItemInfoView.set(itemInfoType: .gists, with: user.publicGists)
        actionButton.set(background: .systemPurple, title: "Github Profile")
    }
    
}
