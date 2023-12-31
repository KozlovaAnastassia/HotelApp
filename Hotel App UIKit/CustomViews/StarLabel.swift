//
//  StarLabel.swift
//  Hotel App UIKit
//
//  Created by Анастасия on 29.12.2023.
//

import UIKit

final class StarLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLabel()
    }
    
    private func setupLabel() {
        font = UIFont.systemFont(ofSize: 16)
        textColor = Constants.Colors.yellowFont
        textAlignment = .left
        text = " \u{2605}"
        backgroundColor = Constants.Colors.yellowBg
        layer.cornerRadius = 5
        clipsToBounds = true
        heightAnchor.constraint(equalToConstant: 30).isActive = true
        widthAnchor.constraint(equalToConstant: 149).isActive = true
    }
}
