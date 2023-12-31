//
//  CustomCell.swift
//  Hotel App UIKit
//
//  Created by Анастасия on 31.12.2023.
//

import Foundation
import UIKit


final class MainDataCell: UITableViewCell {
    
    static var identifier: String {"\(Self.self)"}
    
    lazy var labelName = UILabel.labelDescriptionGray(title: nil)
    lazy var labelData = UILabel.labelDescription(title: nil, alignment: .right)
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.addArrangedSubview(labelName)
        stack.addArrangedSubview(labelData)
        
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        setConstraints()
    }
    
    private func addViews() {
        contentView.addSubview(stackView)
    }
     
     private func setConstraints() {
         NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
         ])
     }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.Errors.initError)
    }
    
    func configure(_ model: MainDataModel) {
        labelName.text = model.name
        labelData.text = model.data
   }
}
