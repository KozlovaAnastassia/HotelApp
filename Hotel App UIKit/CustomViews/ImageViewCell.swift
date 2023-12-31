//
//  ImageViewCell.swift
//  Hotel App UIKit
//
//  Created by Анастасия on 29.12.2023.
//

import UIKit


final class ImageViewCell: UICollectionViewCell {
    
    static var identifier: String {"\(Self.self)"}
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .white
        setViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.Errors.initError)
    }
    
    private func setViews() {
        contentView.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
    }
    
    func configure(model: ImageModel) {
        imageView.loadImage(withURL: model.imageURL, id: model.id)
    }
}
