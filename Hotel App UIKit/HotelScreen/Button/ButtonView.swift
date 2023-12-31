//
//  ButtonView.swift
//  Hotel App UIKit
//
//  Created by Анастасия on 31.12.2023.
//

import UIKit


private extension CGFloat {
    static let imageViewNextSize = 20.0
    static let imageViewSize = 30.0
    
    static let stackViewHorSpacing = 20.0
    static let stackViewVerSpacing = 4.0
    static let labelSubtitleFont = 14.0
}

final class CustomButtonView: UIView {
    
    private lazy var labelTitle = UILabel.labelDescription(title: nil, alignment: .center)
    
    private lazy var labelSubtitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: CGFloat.labelSubtitleFont)
        label.textColor = .systemGray        
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.tintColor = UIColor.black
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalToConstant: CGFloat.imageViewSize).isActive = true
        image.heightAnchor.constraint(equalToConstant: CGFloat.imageViewSize).isActive = true
        return image
    }()
    
    private lazy var imageViewNext: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: Constants.ImageSystemName.arrowForward)
        image.contentMode = .scaleAspectFit
        image.tintColor = UIColor.black
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalToConstant: CGFloat.imageViewNextSize).isActive = true
        image.heightAnchor.constraint(equalToConstant: CGFloat.imageViewNextSize).isActive = true
        return image
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fillEqually
        stack.spacing = CGFloat.stackViewVerSpacing
        stack.addArrangedSubview(labelTitle)
        stack.addArrangedSubview(labelSubtitle)
        
        return stack
    }()
    
    private lazy var stackViewHorizontal: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = CGFloat.stackViewHorSpacing
        stack.addArrangedSubview(imageView)
        stack.addArrangedSubview(stackView)
        stack.addArrangedSubview(imageViewNext)
        return stack
    }()
    
    
    init() {
        super.init(frame: .zero)
        addSubview(stackViewHorizontal)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.Errors.initError)
    }
    
    private func setupConstraints() {
        stackViewHorizontal.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackViewHorizontal.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Constraints.offset16),
            stackViewHorizontal.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.Constraints.inset16),
            stackViewHorizontal.topAnchor.constraint(equalTo: topAnchor),
            stackViewHorizontal.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    func setTitle(_ title: String) {
        labelTitle.text = title
    }
    
    func setSubtitle(_ subtitle: String) {
        labelSubtitle.text = subtitle
    }
    
    func setImage(_ subtitle: String) {
        imageView.image = UIImage(systemName: subtitle)
    }
}


