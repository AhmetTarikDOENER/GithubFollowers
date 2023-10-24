//
//  GFFollowersItemViewController.swift
//  GithubFollowers
//
//  Created by Ahmet Tarik DÖNER on 19.10.2023.
//

import UIKit

protocol GFFollowersItemInfoViewControllerDelegate: AnyObject {
    func gfDidTapGetFollowers(for user: GFUser)
}

class GFFollowersItemViewController: GFItemInfoViewController {
    
    weak var delegate: GFFollowersItemInfoViewControllerDelegate?
    
    init(user: GFUser, delegate: GFFollowersItemInfoViewControllerDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        firstItemInfoView.set(itemInfoType: .followers, with: user.followers)
        secondItemInfoView.set(itemInfoType: .following, with: user.following)
        actionButton.set(color: .systemGreen, title: "Get Followers.", systemImageName: "person.3")
    }
    
    override func didTapActionButton() {
        guard user.followers != 0 else {
            presentGFCustomAlert(title: "No Followers", message: "This user has no followers", buttonTitle: "OK")
            return
        }
        delegate?.gfDidTapGetFollowers(for: user)
    }
}
