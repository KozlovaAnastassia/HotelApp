//
//  CustomTableView.swift
//  Hotel App UIKit
//
//  Created by Анастасия on 29.12.2023.
//

import UIKit

extension UITableView {
    static func customTableView<T: UITableViewCell>(cellClass: T.Type, reuseIdentifier: String) -> UITableView {
        
        let tableView = DynamicHeightTableView(frame: .zero, style: .plain)
        tableView.register(cellClass, forCellReuseIdentifier: reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        tableView.widthAnchor.constraint(equalToConstant: 380).isActive = true
        return tableView
    }
}


