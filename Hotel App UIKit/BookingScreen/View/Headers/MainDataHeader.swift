//
//  BookingHeader.swift
//  Hotel App UIKit
//
//  Created by Анастасия on 29.12.2023.
//

import UIKit

private extension CGFloat {
    static let stackViewTop = 10.0
}

final class MainDataHeader: UIView {

    lazy var labelMark =  StarLabel()
    lazy var labelName = UILabel.labelHead(title: nil)
    lazy var buttonAddress = UIButton.adressButton()

    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .leading
        stack.axis = .vertical
        stack.spacing  = Constants.Spacing.stackViewSpacingVer
        stack.addArrangedSubview(labelMark)
        stack.addArrangedSubview(labelName)
        stack.addArrangedSubview(buttonAddress)
        return stack
    }()

     init(){
         super.init(frame: .zero)
        addViews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError(Constants.Errors.initError)
    }

    private func addViews() {
        addSubview(stackView)
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
           stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
           stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
           stackView.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat.stackViewTop)
           ])
        }


    func configure(model: MainDataHeaderModel) {
        labelName.text = model.hotelName
        buttonAddress.setTitle(model.adressName, for: .normal)
        labelMark.text! += " \(model.horating) \(model.rating_name)"
    }

}
