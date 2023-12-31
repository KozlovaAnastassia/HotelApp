//
//  HotelView.swift
//  Hotel App UIKit
//
//  Created by Анастасия on 29.12.2023.
//

import UIKit

private extension String {
    static let buttonConviniens = "Удобства"
    static let buttonInclude = "Что включено"
    static let buttonNotInclude = "Что не включено"
    static let buttonSubtitle = "Самое необходимое"
    
    static let imageConviniens = "star"
    static let imageInclude = "star"
    static let imageNotInclude = "star"
    
    static let labelAbout = "Об отеле"
    static let labelPrice = "от "
}

private extension CGFloat {
    static let stackViewMainDataSpacing = 20.0
}

protocol IHotelView: AnyObject {
    func getPeculiaritiesCount() -> Int
    func getImagesCount() -> Int
    func getPeculiarities(indexPath: IndexPath) -> String
    func getImage(indexPath: IndexPath) -> ImageModel
    func pushToAnotherController(text: String)
}

final class HotelView: UIView {
    
    weak var delegate: IHotelView?
    
    private let collectionView = UICollectionView.imageCollectionView()
    
    private let collectionViewPeculiarities = UICollectionView.customCollectionView(cellClass: PeculiaritiesCell.self, reuseIdentifier: PeculiaritiesCell.identifier)
    
    private lazy var labelStar =  StarLabel()
    private lazy var labelName = UILabel.labelHead(title: nil)
    private lazy var labelForPrice = UILabel.labelDescriptionGray(title: nil)
    private lazy var labelAbout = UILabel.labelHead(title: String.labelAbout)
    private lazy var labelDescription = UILabel.labelDescription(title: nil, alignment: .left)
    private lazy var labelPrice = UILabel.labelPrice(title: String.labelPrice)
    private lazy var buttonAddress = UIButton.adressButton()
    
    private var buttonConvenience = UIButton.buttonConveniences(title: String.buttonConviniens,
                                                                subtitle: String.buttonSubtitle,
                                                                imageName: String.imageConviniens)
    
    private var buttonInclude = UIButton.buttonConveniences(title: String.buttonInclude,
                                                            subtitle: String.buttonSubtitle,
                                                            imageName: String.imageInclude)
    
    private var buttonNotInclude = UIButton.buttonConveniences(title: String.buttonNotInclude,
                                                               subtitle: String.buttonSubtitle,
                                                               imageName: String.imageNotInclude)
    
    lazy var buttomForword = UIButton.forwordButton(title: Constants.ButtonForwardTitle.hotelScreen, target: self, action: #selector(goForword))
    
    
    private lazy var stackViewPrice: UIStackView = {
        let stack =  UIStackView()
        stack.axis = .horizontal
        stack.alignment = .bottom
        stack.spacing = Constants.Spacing.stackViewSpacingHor
        stack.addArrangedSubview(labelPrice)
        stack.addArrangedSubview(labelForPrice)
        
        return stack
    }()
    
    lazy var stackViewMainData: UIStackView = {
        let stack =  UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = CGFloat.stackViewMainDataSpacing
        
        stack.addArrangedSubview(collectionView)
        stack.addArrangedSubview(labelStar)
        stack.addArrangedSubview(labelName)
        stack.addArrangedSubview(buttonAddress)
        stack.addArrangedSubview(stackViewPrice)
        stack.addArrangedSubview(collectionViewPeculiarities)
        
        stack.addArrangedSubview(labelAbout)
        stack.addArrangedSubview(labelDescription)
        stack.addArrangedSubview(buttonConvenience)
        stack.addArrangedSubview(buttonInclude)
        stack.addArrangedSubview(buttonNotInclude)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubViews()
        setConstraints()
        setDelegates()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.Errors.initError)
    }
    
    private func addSubViews() {
        addSubview(stackViewMainData)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionViewPeculiarities.widthAnchor.constraint(equalTo: stackViewMainData.widthAnchor),
            
            stackViewMainData.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackViewMainData.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackViewMainData.topAnchor.constraint(equalTo: topAnchor),
            stackViewMainData.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func setDelegates() {
        collectionViewPeculiarities.delegate = self
        collectionViewPeculiarities.dataSource = self
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    @objc func goForword() {
        delegate?.pushToAnotherController(text: labelName.text ?? String())
    }
    
    func updateInterfece(response: HotelModel) {
        
        labelName.text = response.name
        labelStar.text! += " \(response.rating) \(response.rating_name)"
        labelPrice.text! += Formuls.shared.intToCurrency(integer: response.minimal_price)
        labelForPrice.text =  response.price_for_it
        buttonAddress.setTitle(response.adress, for: .normal)
        
        collectionView.reloadData()
        collectionViewPeculiarities.reloadData()
        labelDescription.text = response.about_the_hotel.description
    }
}

extension HotelView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewPeculiarities{
            return delegate?.getPeculiaritiesCount() ?? Int()
        } else {
            return delegate?.getImagesCount() ?? Int()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewPeculiarities {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PeculiaritiesCell.identifier, for: indexPath) as? PeculiaritiesCell
            else { return UICollectionViewCell() }
            
            cell.layer.cornerRadius = Constants.CornerRadius.radius10
            guard let peculiarities = delegate?.getPeculiarities(indexPath: indexPath) else {return cell}
            cell.configure(text: peculiarities)
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageViewCell.identifier, for: indexPath) as? ImageViewCell
            else { return UICollectionViewCell() }
            
            guard let image = delegate?.getImage(indexPath: indexPath) else {return cell}
            cell.configure(model: image)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Int(collectionView.frame.width)
        let height = Int(collectionView.frame.height)
        return CGSize(width:  width, height: height)
    }
}
