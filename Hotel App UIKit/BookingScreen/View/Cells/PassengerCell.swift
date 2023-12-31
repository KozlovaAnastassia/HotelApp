//
//  PassengerCell.swift
//  Hotel App UIKit
//
//  Created by Анастасия on 29.12.2023.
//

import UIKit

private extension String {
    static let textFieldNamePlaceholder = "Имя"
    static let textFieldSurnamePlaceholder = "Фамилия"
    static let textFieldBirthdayDatePlaceholder = "Дата рождения"
    static let textFieldCitizenshipPlaceholder = "Гражданство"
    static let textFieldPassportNumberPlaceholder = "Номер загранпаспорта"
    static let textFieldPassportPeriodPlaceholder = "Срок действия загранпаспорта"
}

private extension CGFloat {
    static let stackViewSpacing = 150.0
    static let stackViewTop = 10.0
}

final class PassengerCell: UITableViewCell {
    
    static var identifier: String {"\(Self.self)"}
    
    lazy var textFieldName = UITextField.textFieldInfo(placeholder: String.textFieldNamePlaceholder, numberPad: false)
    lazy var textFieldSurname = UITextField.textFieldInfo(placeholder:  String.textFieldSurnamePlaceholder, numberPad: false)
    lazy var textFieldBirthdayDate = UITextField.textFieldInfo(placeholder: String.textFieldBirthdayDatePlaceholder, numberPad: true)
    lazy var textFieldCitizenship = UITextField.textFieldInfo(placeholder: String.textFieldCitizenshipPlaceholder, numberPad: false)
    lazy var textFieldPassportNumber = UITextField.textFieldInfo(placeholder: String.textFieldPassportNumberPlaceholder, numberPad: true)
    lazy var textFieldPassportPeriod = UITextField.textFieldInfo(placeholder: String.textFieldPassportPeriodPlaceholder, numberPad: true)

    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .leading
        stack.axis = .vertical
        stack.spacing  = Constants.Spacing.stackViewSpacingVer
        stack.addArrangedSubview(textFieldName)
        stack.addArrangedSubview(textFieldSurname)
        stack.addArrangedSubview(textFieldBirthdayDate)
        stack.addArrangedSubview(textFieldCitizenship)
        stack.addArrangedSubview(textFieldPassportNumber)
        stack.addArrangedSubview(textFieldPassportPeriod)
        
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        setConstraints()
        textFieldName.delegate = self
        textFieldSurname.delegate = self
        textFieldCitizenship.delegate = self
        textFieldBirthdayDate.delegate = self
        textFieldPassportNumber.delegate = self
        textFieldPassportPeriod.delegate = self
    }
    
    private func addViews() {
        contentView.addSubview(stackView)
    }
     
     private func setConstraints() {
         NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
         ])
     }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.Errors.initError)
    }
}

extension PassengerCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
        return true
    }
}
