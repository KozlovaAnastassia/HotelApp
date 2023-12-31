//
//  RecordCell.swift
//  aston_2Dgame
//
//  Created by Анастасия on 30.12.2023.
//

import UIKit

private extension String {
    static let buttonDetailsTitle = "Подробнее о номере"
}

private extension CGFloat {
    static let stackViewLeading = 16.0
}

final class RoomCell: UITableViewCell {
    
    static var identifier: String {"\(Self.self)"}
    
    var images = [String]()
    var peculiarities = [String]()
    var buttonAction: (() -> Void)?
    
    lazy var collectionView = UICollectionView.imageCollectionView()
    lazy var collectionViewPeculiarities = UICollectionView.customCollectionView(cellClass: PeculiaritiesCell.self, reuseIdentifier: PeculiaritiesCell.identifier)
    
    lazy var buttonDetails = UIButton.buttonDetails(title: String.buttonDetailsTitle)
    
    lazy var labelForPrice = UILabel.labelDescriptionGray(title: nil)
    private var nameLabel = UILabel.labelHead(title: nil)
    
    lazy var buttomForword = UIButton.forwordButton(title: Constants.ButtonForwardTitle.roomScreen, target: self, action: #selector(goForword))
    lazy var labelPrice = UILabel.labelPrice(title: nil)
    
    lazy var stackViewPrice: UIStackView = {
        let stack =  UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = Constants.Spacing.stackViewSpacingVer
        stack.addArrangedSubview(labelPrice)
        stack.addArrangedSubview(labelForPrice)
        
        return stack
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .leading
        stack.axis = .vertical
        stack.spacing = Constants.Spacing.stackViewSpacingVer
        stack.addArrangedSubview(collectionView)
        stack.addArrangedSubview(nameLabel)
        stack.addArrangedSubview(collectionViewPeculiarities)
        stack.addArrangedSubview(buttonDetails)
        stack.addArrangedSubview(stackViewPrice)
        stack.addArrangedSubview(buttomForword)
        stack.sizeToFit()
        return stack
    }()
    
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        setConstraints()
        setDelegates()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.Errors.initError)
    }
    
   @objc func goForword() {
       buttonAction?()
    }
    
    private func setDelegates() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionViewPeculiarities.dataSource = self
        collectionViewPeculiarities.delegate = self
    }
     
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        labelForPrice.text = nil
    }
    
    private func addViews() {
        contentView.addSubview(stackView)
    }
     
     private func setConstraints() {
         NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: CGFloat.stackViewLeading),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
         ])
     }
    
    func configure(_ model: Room) {
        nameLabel.text = model.name
        labelPrice.text = Formuls.shared.intToCurrency(integer: model.price)
        labelForPrice.text = model.price_per
        images += model.image_urls
        peculiarities += model.peculiarities
        collectionView.reloadData()
        collectionViewPeculiarities.reloadData()
   }
}


extension RoomCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewPeculiarities {
            return peculiarities.count
        } else {
            return images.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewPeculiarities {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PeculiaritiesCell.identifier, for: indexPath) as? PeculiaritiesCell else { return UICollectionViewCell() }
            cell.layer.cornerRadius = Constants.CornerRadius.radius10
            cell.configure(text: peculiarities[indexPath.row])
            return cell
            
        } else {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageViewCell.identifier, for: indexPath) as? ImageViewCell else { return UICollectionViewCell() }
        
            cell.configure(model: ImageModel(imageURL: images[indexPath.row], id: "\(images[indexPath.row])"))
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Int(collectionView.frame.width)
        let height = Int(collectionView.frame.height)
        
        return CGSize(width: width, height: height)
    }
}
