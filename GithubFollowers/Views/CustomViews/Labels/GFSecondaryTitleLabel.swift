//
//  GFSecondaryTitleLabel.swift
//  GithubFollowers
//
//  Created by Ahmet Tarik DÖNER on 17.10.2023.
//

import UIKit

final class GFSecondaryTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
    
    private func configureSetup() {
        textColor = .secondaryLabel
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.90
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
