//
//  BookingView.swift
//  Hotel App UIKit
//
//  Created by Анастасия on 29.12.2023.
//

import UIKit

private extension String {
    static let labelDescription = "Эти данные никому не передаются. После оплаты мы вышлем чек на указанный вами номр и почту"
    static let userDataLabel = "Информация о покупателе"
    static let textFieldPhonePlaceHolder = "+7(___)-___-__-__"
    static let textFieldEmailPlaceholder = "email@gmail.com"
    static let incorrectEmail = "Некоректный email"
    static let ok = "OK"
    static let error = "Ошибка"
}

private extension CGFloat {
    static let heightForRowAtDefault = 50.0
    static let heightForRowAtExpanded = 400.0
    
    static let headerHeightDefault = 40.0
    static let headerHeightMainData = 150.0
}

private extension Int {
    static let phoneNumbersTotal = 18
    static let one = 1
}

protocol IBookingView: AnyObject {
    func getPriceDataCount() -> Int
    func getPassengersCount() -> Int
    func getMainDataCount() -> Int
    func isPassengerExpanded(section: Int) -> Bool
    func getPassengerSectionData(section: Int) -> String
    
    func getPriceData(indexPath: IndexPath) -> MainDataModel
    func getPassengersData(indexPath: IndexPath) -> PassenderModel
    func getMainData(indexPath: IndexPath) -> MainDataModel
    func pushToAnotherController()
    func buttonTapped(sender: UIButton)
    func presentAlert(alert: UIAlertController)
}

final class BookingView: UIView {
    
    var isDataCorrect: Bool?
    
    weak var delegate: IBookingView?
    
    private var userDataLabel = UILabel.labelHead(title: String.userDataLabel)
    private var userDataAttension = UILabel.labelDescriptionGray(title: String.labelDescription)
    private var departureLabel = UILabel.labelDescriptionGray(title: nil)

    private var textFieldPhone = UITextField.textFieldInfo(placeholder: String.textFieldPhonePlaceHolder, numberPad: true)
    private var textFieldEmail = UITextField.textFieldInfo(placeholder: String.textFieldEmailPlaceholder, numberPad: false)
   
    lazy var buttomForword = UIButton.forwordButton(title: Constants.ButtonForwardTitle.bookingScreen, target: self,  action: #selector(goForword))
    
    lazy var  tableViewMainData = UITableView.customTableView(cellClass: MainDataCell.self, reuseIdentifier: MainDataCell.identifier)
    lazy var  tableViewPassengers = UITableView.customTableView(cellClass: PassengerCell.self, reuseIdentifier: PassengerCell.identifier)
    lazy var  tableViewPrice = UITableView.customTableView(cellClass: MainDataCell.self, reuseIdentifier: MainDataCell.identifier)
    
    private lazy var labelError = UILabel.labelError()
    private lazy var activityIndicator = UIActivityIndicatorView.activityIndicator()
    
    private lazy var stackViewMain: UIStackView = {
        let stack =  UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = Constants.Spacing.stackViewSpacingVer
        stack.addArrangedSubview(tableViewMainData)
        stack.addArrangedSubview(userDataLabel)
        stack.addArrangedSubview(textFieldPhone)
        stack.addArrangedSubview(textFieldEmail)
        stack.addArrangedSubview(userDataAttension)
        stack.addArrangedSubview(tableViewPassengers)
        stack.addArrangedSubview(tableViewPrice)
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
    
    @objc func goForword() {
        let textPhone = textFieldPhone.text ?? String()
        let textEmail = textFieldEmail.text ?? String()
        
        if textPhone.isEmpty {
            textFieldPhone.backgroundColor = Constants.Colors.errorColor
        }
        if textEmail.isEmpty {
            textFieldEmail.backgroundColor = Constants.Colors.errorColor
        }
        if isDataCorrect == nil {
            isDataCorrect = false
        }
        if isDataCorrect == false {
            tableViewPassengers.reloadData()
            return
        }
        
        if textPhone.isEmpty || textEmail.isEmpty {
            return
        }
        
        isDataCorrect = false
        textFieldPhone.backgroundColor = Constants.Colors.grayTextField
        textFieldEmail.backgroundColor = Constants.Colors.grayTextField
        delegate?.pushToAnotherController()
    }
    
    private func addSubViews() {
        addSubview(stackViewMain)
        addSubview(labelError)
        addSubview(activityIndicator)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            stackViewMain.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackViewMain.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackViewMain.topAnchor.constraint(equalTo: topAnchor),
            stackViewMain.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            textFieldPhone.widthAnchor.constraint(equalTo: stackViewMain.widthAnchor),
            textFieldEmail.widthAnchor.constraint(equalTo: stackViewMain.widthAnchor),
            
            labelError.centerXAnchor.constraint(equalTo: centerXAnchor),
            labelError.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    private func setDelegates() {
        textFieldPhone.delegate = self
        textFieldEmail.delegate = self
        
        tableViewMainData.dataSource = self
        tableViewMainData.delegate = self
        
        tableViewPassengers.dataSource = self
        tableViewPassengers.delegate = self
        
        tableViewPrice.dataSource = self
        tableViewPrice.delegate = self
    }
    
    private func setErrorAlert(message: String) {
        let alert = UIAlertController(title: String.error, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: String.ok, style: .default)
        alert.addAction(action)
        delegate?.presentAlert(alert: alert)
    }
    
    func getHeaderData(response: BookingModel) {
        let header = MainDataHeader()
        tableViewMainData.tableHeaderView = header
        header.configure(model: MainDataHeaderModel(hotelName: response.hotel_name,
                                                           adressName: response.hotel_adress,
                                                           horating: response.horating,
                                                           rating_name: response.rating_name))
    }
    
    func failureScreeen() {
        stackViewMain.isHidden = true
        labelError.isHidden = false
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    func loadingScreeen() {
        stackViewMain.isHidden = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        labelError.isHidden = true
    }
    
    func loadedScreeen() {
        stackViewMain.isHidden = false
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        labelError.isHidden = true
    }
}

extension BookingView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let isExpanded = delegate?.isPassengerExpanded(section: section) ?? Bool()
        
        switch tableView {
        case tableViewPassengers:
            if isExpanded {return Int.one}
            return .zero
        case tableViewPrice:
            return delegate?.getPriceDataCount() ?? Int()
        default:
            return  delegate?.getMainDataCount() ?? Int()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == tableViewPassengers{
            return delegate?.getPassengersCount() ?? Int()
        }
        return Int.one
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       if tableView == tableViewPassengers {
           return  CGFloat.heightForRowAtExpanded
        } else {
            return   CGFloat.heightForRowAtDefault
       }
      }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case tableViewPassengers:
            let cell = tableView.dequeueReusableCell(withIdentifier: PassengerCell.identifier, for: indexPath) as? PassengerCell
            
            if let indexPath = tableView.indexPath(for: cell ?? UITableViewCell()) {
                if  indexPath.section == .zero {
                    if let bool = cell?.checkEmptyTextField(cellIndex: .zero, isDataCorrect: self.isDataCorrect){
                        if bool {
                            isDataCorrect = true
                        }
                    }
                }
            }
            return cell ?? UITableViewCell()
            
        case tableViewPrice:
            let cell = tableView.dequeueReusableCell(withIdentifier: MainDataCell.identifier, for: indexPath) as? MainDataCell
            guard let model = delegate?.getPriceData(indexPath: indexPath) else {return cell ?? MainDataCell()}
            cell?.configure(model)
            return cell ?? UITableViewCell()
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: MainDataCell.identifier, for: indexPath) as? MainDataCell
            guard let model = delegate?.getMainData(indexPath: indexPath) else {return cell ?? MainDataCell()}
            cell?.labelData.textAlignment = .left
            cell?.configure(model)
            return cell ?? UITableViewCell()
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        if tableView == tableViewPassengers{
            let headerView = PassengerHeader()
            
            headerView.buttomDown.tag = section
            let passenderName = delegate?.getPassengerSectionData(section: section) ?? String()
            headerView.configure(text: passenderName, handler: { button in
                
            self.delegate?.buttonTapped(sender: headerView.buttomDown )
            })
            return headerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == tableViewMainData{
            return CGFloat.headerHeightMainData
        }
        return  CGFloat.headerHeightDefault
    }
}

extension BookingView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == textFieldPhone {
            let fullString = (textField.text ?? String()) + string
            textField.text = Formuls.shared.phoneFormat(phoneNumber: fullString)
            return false
        } else {
            return true
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == textFieldEmail {
            if let text = textField.text {
                if !Formuls.shared.isValidEmail(email: text) {
                    setErrorAlert(message: String.incorrectEmail)
                    textFieldEmail.backgroundColor = Constants.Colors.errorColor
                } else {
                    textFieldEmail.backgroundColor = Constants.Colors.grayTextField
                }
            }
        }
        if textField == textFieldPhone {
            if textField.text?.count == Int.phoneNumbersTotal {
                textFieldPhone.backgroundColor = Constants.Colors.grayTextField
            } else {
                textFieldPhone.backgroundColor = Constants.Colors.errorColor
            }
        }
    }
}

