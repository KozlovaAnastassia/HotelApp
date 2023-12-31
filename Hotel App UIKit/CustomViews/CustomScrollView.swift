//
//  CustomScrollView.swift
//  Hotel App UIKit
//
//  Created by Анастасия on 29.12.2023.
//

import UIKit

private extension CGFloat {
    static let contSizeHeight = 600.0
    static let stackOffset = 16.0
    static let stackInset = -16.0
}

extension UIScrollView {
    static func customScroll(view: UIView, stack: UIStackView) -> UIScrollView {
        
        let contSize =  CGSize(width: view.frame.width, height: view.frame.height + CGFloat.contSizeHeight)
        
        let contentView = UIView()
         contentView.backgroundColor = .white
         contentView.frame.size = contSize
        
        let scroll =  UIScrollView()
        scroll.contentSize = contentView.bounds.size
        scroll.frame = view.bounds
        
        contentView.addSubview(stack)
        scroll.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: CGFloat.stackOffset),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: CGFloat.stackInset),
        ])
        return scroll
    }

}
