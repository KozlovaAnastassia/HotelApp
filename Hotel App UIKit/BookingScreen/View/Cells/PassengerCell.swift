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
    
    required init?(coder: NSCoder) {
        fatalError(Constants.Errors.initError)
    }
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textFieldName.backgroundColor = Constants.Colors.grayTextField
        textFieldSurname.backgroundColor = Constants.Colors.grayTextField
        textFieldCitizenship.backgroundColor = Constants.Colors.grayTextField
        textFieldBirthdayDate.backgroundColor = Constants.Colors.grayTextField
        textFieldPassportNumber.backgroundColor = Constants.Colors.grayTextField
        textFieldPassportPeriod.backgroundColor = Constants.Colors.grayTextField
    }
    
    private func addViews() {
        contentView.addSubview(stackView)
    }
     
     private func setConstraints() {
         NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            textFieldName.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            textFieldSurname.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            textFieldCitizenship.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            textFieldBirthdayDate.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            textFieldPassportNumber.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            textFieldPassportPeriod.widthAnchor.constraint(equalTo: stackView.widthAnchor),
         ])
     }
    
    func checkEmptyTextField(cellIndex: Int, isDataCorrect: Bool?) -> Bool {
        
        if cellIndex == .zero && isDataCorrect == false {
            let textName = textFieldName.text ?? String()
            let textSurname = textFieldSurname.text ?? String()
            let textCitizenship = textFieldCitizenship.text ?? String()
            let textBirthdayDate = textFieldBirthdayDate.text ?? String()
            let textPassportNumber = textFieldPassportNumber.text ?? String()
            let textPassportPeriod = textFieldPassportPeriod.text ?? String()
        
            if textName.isEmpty {
                textFieldName.backgroundColor = Constants.Colors.errorColor
            }
            if textSurname.isEmpty {
                textFieldSurname.backgroundColor = Constants.Colors.errorColor
            }
            if textCitizenship.isEmpty {
                textFieldCitizenship.backgroundColor = Constants.Colors.errorColor
            }
            if textBirthdayDate.isEmpty {
                textFieldBirthdayDate.backgroundColor = Constants.Colors.errorColor
            }
            if textPassportNumber.isEmpty {
                textFieldPassportNumber.backgroundColor = Constants.Colors.errorColor
            }
            if textPassportPeriod.isEmpty {
                textFieldPassportPeriod.backgroundColor = Constants.Colors.errorColor
            }
            if textName.isEmpty || textSurname.isEmpty || textCitizenship.isEmpty || textBirthdayDate.isEmpty || textPassportNumber.isEmpty || textPassportPeriod.isEmpty {
                return false
            }
            
            textFieldName.backgroundColor = Constants.Colors.grayTextField
            textFieldSurname.backgroundColor = Constants.Colors.grayTextField
            textFieldCitizenship.backgroundColor = Constants.Colors.grayTextField
            textFieldBirthdayDate.backgroundColor = Constants.Colors.grayTextField
            textFieldPassportNumber.backgroundColor = Constants.Colors.grayTextField
            textFieldPassportPeriod.backgroundColor = Constants.Colors.grayTextField
            return true
        }
        return false
    }
   
   
}

extension PassengerCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case textFieldName:
            if textField.text != nil {
                textFieldName.backgroundColor = Constants.Colors.grayTextField
            } else {
                textFieldName.backgroundColor = Constants.Colors.errorColor
            }
        case textFieldSurname:
            if textField.text != nil {
                textFieldSurname.backgroundColor = Constants.Colors.grayTextField
            } else {
                textFieldSurname.backgroundColor = Constants.Colors.errorColor
            }
        case textFieldCitizenship:
            if textField.text != nil {
                textFieldCitizenship.backgroundColor = Constants.Colors.grayTextField
            } else {
                textFieldCitizenship.backgroundColor = Constants.Colors.errorColor
            }
        case textFieldBirthdayDate:
            if textField.text != nil {
                textFieldBirthdayDate.backgroundColor = Constants.Colors.grayTextField
            } else {
                textFieldBirthdayDate.backgroundColor = Constants.Colors.errorColor
            }
        case textFieldPassportNumber:
            if textField.text != nil {
                textFieldPassportNumber.backgroundColor = Constants.Colors.grayTextField
            } else {
                textFieldPassportNumber.backgroundColor = Constants.Colors.errorColor
            }
        case textFieldPassportPeriod:
            if textField.text != nil {
                textFieldPassportPeriod.backgroundColor = Constants.Colors.grayTextField
            } else {
                textFieldPassportPeriod.backgroundColor = Constants.Colors.errorColor
            }
        default:
            break
            
        }
        
    }
}
