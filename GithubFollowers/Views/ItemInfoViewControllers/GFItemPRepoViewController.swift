//
//  GFItemPRepoView.swift
//  GithubFollowers
//
//  Created by Ahmet Tarik DÖNER on 19.10.2023.
//

import UIKit

protocol GFRepoItemInfoViewControllerDelegate: AnyObject {
    func gfDidTapGithubProfile(for user: GFUser)
}

class GFItemPRepoViewController: GFItemInfoViewController {
    
    weak var delegate: GFRepoItemInfoViewControllerDelegate?
    
    init(user: GFUser, delegate: GFRepoItemInfoViewControllerDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    //MARK: - Private
    
    private func configureItems() {
        firstItemInfoView.set(itemInfoType: .repos, with: user.publicRepos)
        secondItemInfoView.set(itemInfoType: .gists, with: user.publicGists)
        actionButton.set(color: .systemPurple, title: "Github Profile", systemImageName: "person")
    }
    
    override func didTapActionButton() {
        delegate?.gfDidTapGithubProfile(for: user)
    }
    
}
