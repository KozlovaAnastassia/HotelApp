//
//  CustomCollectionView.swift
//  Hotel App UIKit
//
//  Created by Анастасия on 29.12.2023
//

import UIKit


extension UICollectionView {
    static func customCollectionView<T: UICollectionViewCell>(cellClass: T.Type, reuseIdentifier: String) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = DynamicHeightCollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(cellClass, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.isScrollEnabled = false
        collectionView.collectionViewLayout = layout
        collectionView.widthAnchor.constraint(equalToConstant: 360).isActive  = true
        return collectionView
    }
    
    static func imageCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = DynamicHeightCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ImageViewCell.self, forCellWithReuseIdentifier: ImageViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.heightAnchor.constraint(equalToConstant: 257).isActive = true
            
        return collectionView
    }
}


