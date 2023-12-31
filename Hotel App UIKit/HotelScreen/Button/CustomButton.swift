//
//  CustomButton.swift
//  Hotel App UIKit
//
//  Created by Анастасия on 31.12.2023.
//

import UIKit

final class CustomButton: UIButton {
    
    private let customButtonView: CustomButtonView
    
    init() {
        customButtonView = CustomButtonView()
        super.init(frame: .zero)
        backgroundColor = Constants.Colors.graybg
        addSubview(customButtonView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.Errors.initError)
    }
    
    private func setupConstraints() {
        customButtonView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customButtonView.leadingAnchor.constraint(equalTo: leadingAnchor),
            customButtonView.trailingAnchor.constraint(equalTo: trailingAnchor),
            customButtonView.topAnchor.constraint(equalTo: topAnchor),
            customButtonView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setTitle(_ title: String) {
        customButtonView.setTitle(title)
    }
    
    func setSubtitle(_ subtitle: String) {
        customButtonView.setSubtitle(subtitle)
    }
    
    func setImage(_ subtitle: String) {
        customButtonView.setImage(subtitle)
    }
}
