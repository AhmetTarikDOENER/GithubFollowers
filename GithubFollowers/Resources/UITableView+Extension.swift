//
//  UITableView+Extension.swift
//  GithubFollowers
//
//  Created by Ahmet Tarik DÖNER on 22.10.2023.
//

import UIKit

extension UITableView {
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
