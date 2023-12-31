//
//  ViewControllerAccept.swift
//  Hotel App UIKit
//
//  Created by Анастасия on 31.12.2023.
//

import UIKit

private enum CustomString {
    case labelDescription(orderNumber: Int)
    
    var rawValue: String {
        switch self {
        case .labelDescription(let orderNumber):
            return "Подтверждение заказа №\(orderNumber) может занять некоторое время (от 1 часа до суток).\n Как только мы получим ответ от туроператора, вам на почту придет уведомление."
        }
    }
}

private extension String {
    static let labelTitle = "Ваш заказ принят в работу"
    static let imageViewImage = "sparkles"
}

private extension CGFloat {
    static let imageViewCornerRadius = 50.0
    static let imageViewSize = 100.0
    
    static let stackViewMainOffset = 20.0
    static let stackViewMainInset = -20.0

}
private extension Int {
    static let randomStart = 100000
    static let randomFinish = 1000000
}

final class ViewControllerAccept: UIViewController {
    
    var orderNumber: Int
    
    lazy var imageView: UIImageView = {
        let imageView =  UIImageView()
        imageView.layer.cornerRadius = CGFloat.imageViewCornerRadius
        imageView.image = UIImage(systemName: String.imageViewImage)
        imageView.backgroundColor = .systemGray6
        return imageView
    }()
    
    lazy var labelTitle = UILabel.labelHead(title: String.labelTitle)
    lazy var labelDescription = UILabel.labelDescriptionGray(title: CustomString.labelDescription(orderNumber: orderNumber).rawValue)
    lazy var buttomForword = UIButton.forwordButton(title: Constants.ButtonForwardTitle.acceptScreen, target: self,  action: #selector(goForword))
    
    
    lazy var stackViewMain: UIStackView = {
        let stack =  UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = Constants.Spacing.stackViewSpacingHor
        stack.addArrangedSubview(imageView)
        stack.addArrangedSubview(labelTitle)
        stack.addArrangedSubview(labelDescription)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    init(orderNumber: Int = Int.random(in: Int.randomStart...Int.randomFinish)) {
        self.orderNumber = orderNumber
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.Errors.initError)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.ControllerTitle.accept
        view.backgroundColor = .white
        addSubViews()
        setConstraints()
        addButtomForword()
        
        labelDescription.textAlignment = .center
    }
    
    func addButtomForword() {
        let buttonForword = UIBarButtonItem(customView: buttomForword)
        toolbarItems = [buttonForword]
        navigationController?.isToolbarHidden = false
    }
    
    
    @objc func goForword() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func addSubViews() {
        view.addSubview(stackViewMain)
    }
    
    func setConstraints() {
        
        NSLayoutConstraint.activate([
            stackViewMain.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackViewMain.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackViewMain.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat.stackViewMainOffset),
            stackViewMain.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: CGFloat.stackViewMainInset),
        ])
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: CGFloat.imageViewSize),
            imageView.heightAnchor.constraint(equalToConstant: CGFloat.imageViewSize)
        ])
        
    }
    
}
