//
//  GFTitleLabel.swift
//  GithubFollowers
//
//  Created by Ahmet Tarik DÖNER on 13.10.2023.
//

import UIKit

class GFTitleLabel: UILabel {
    
    
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        configureSetup()
    }
    
    
    
    //MARK: - Private
    
    private func configureSetup() {
        textColor = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.90
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
