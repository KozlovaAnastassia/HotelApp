//
//  PasserCell.swift
//  Hotel App UIKit
//
//  Created by Анастасия on 29.12.2023
//
//
import UIKit

private extension CGFloat {
    static let stackViewSpacing = 150.0
    static let stackViewTop = 10.0
    static let buttonSize = 30.0
}

final class PassengerHeader: UIView {

    lazy var labelName = UILabel.labelHead(title: nil)

    lazy var buttomDown: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: Constants.ImageSystemName.arrowDown), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: CGFloat.buttonSize).isActive = true
        button.heightAnchor.constraint(equalToConstant: CGFloat.buttonSize).isActive = true
        button.sizeToFit()
        return button
    }()

    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing  = CGFloat.stackViewSpacing
        stack.addArrangedSubview(labelName)
        stack.addArrangedSubview(buttomDown)
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

    func configure(text: String, handler: @escaping(UIButton) -> Void) {
        labelName.text = text

        let action = UIAction {_ in
            handler(self.buttomDown)
        }
        buttomDown.addAction(action, for: .touchUpInside)
    }

}
