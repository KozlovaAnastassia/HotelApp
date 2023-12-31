//
//  CustomCell.swift
//  Surf
//
//  Created by Анастасия on 29.12.2023.
//

import UIKit

private extension CGFloat {
    static let labelHeight = 30.0
}


final class PeculiaritiesCell: UICollectionViewCell {
    
    static var identifier: String {"\(Self.self)"}
    
    let label = UILabel.labelDescriptionGray(title: nil)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setViews()
        backgroundColor = Constants.Colors.graybg
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.Errors.initError)
    }
    
    private func setViews() {
        contentView.addSubview(label)
        label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: CGFloat.labelHeight).isActive = true
        
    }
    
    func configure(text: String) {
        label.text = text
    }
}
