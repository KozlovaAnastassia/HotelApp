//
//  CustomScrollView.swift
//  Hotel App UIKit
//
//  Created by Анастасия on 29.12.2023.
//

import UIKit

private extension CGFloat {
    static let contSizeHeight = 600.0
}

extension UIScrollView {
    static func customScroll(viewMain: UIView, viewContent: UIView) -> UIScrollView {
        
        viewContent.translatesAutoresizingMaskIntoConstraints = false
        let scrollView = UIScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false

            scrollView.addSubview(viewContent)
            viewMain.addSubview(scrollView)

            NSLayoutConstraint.activate([
                scrollView.leadingAnchor.constraint(equalTo: viewMain.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: viewMain.trailingAnchor),
                scrollView.topAnchor.constraint(equalTo: viewMain.topAnchor),
                scrollView.bottomAnchor.constraint(equalTo: viewMain.bottomAnchor),
                
                viewContent.leadingAnchor.constraint(equalTo: viewMain.leadingAnchor, constant: Constants.Constraints.offset16),
                viewContent.trailingAnchor.constraint(equalTo: viewMain.trailingAnchor, constant: Constants.Constraints.inset16),
                viewContent.topAnchor.constraint(equalTo: scrollView.topAnchor),
                viewContent.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            ])
       return scrollView
    }

}
