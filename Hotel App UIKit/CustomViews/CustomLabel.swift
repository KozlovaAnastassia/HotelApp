//
//  CustomLabel.swift
//  Hotel App UIKit
//
//  Created by Анастасия on 29.12.2023.
//

import UIKit


extension UILabel {

    class func labelDescription(title: String?, alignment: NSTextAlignment) -> UILabel {
        let label =  UILabel()
        label.textAlignment = alignment
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = .zero
        if let title = title {
            label.text = title
        }
        return label
    }
    
    class func labelDescriptionGray(title: String?) -> UILabel {
        let label =  UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = Constants.Colors.fontGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = .zero
        if let title = title {
            label.text = title
        }
        return label
    }
    
    class func labelHead(title: String?) -> UILabel {
        let label =  UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = .zero
        if let title = title {
            label.text = title
        }
        
        return label
    }
    
    class func labelPrice(title: String?) -> UILabel {
        let label =  UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        if let title = title {
            label.text = title
        }
        return label
    }

}

