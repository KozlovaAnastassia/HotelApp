//
//  CustomButton.swift
//  Hotel App UIKit
//
//  Created by Анастасия on 30.12.2023.
//

import UIKit


extension UIButton {
    class func forwordButton(title: String, target: Any?, action: Selector) -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.setTitle(title, for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 343).isActive  = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive  = true
        button.layer.cornerRadius = 15
        return button
    }

    class func adressButton() -> UIButton {
            let button =  UIButton()
            button.setTitleColor( Constants.Colors.blueFont, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
    }
    
    class func buttonConveniences(title: String, subtitle: String, imageName: String) -> CustomButton {
        let customButton = CustomButton()
        customButton.setTitle(title)
        customButton.setSubtitle(subtitle)
        customButton.setImage(imageName)
        customButton.translatesAutoresizingMaskIntoConstraints = false
        customButton.widthAnchor.constraint(equalToConstant: 343).isActive = true
        customButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
         return customButton
    }
    
    class func buttonDetails(title: String) -> UIButton {
        let button = UIButton(type: .system)
       
        button.backgroundColor = .systemBlue.withAlphaComponent(CGFloat(0.1))
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.layer.cornerRadius = 5
        button.setTitle(title, for: .normal)
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)

        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
         return button
    }
    
}

