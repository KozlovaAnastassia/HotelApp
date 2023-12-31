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
}

private extension CGFloat {
    static let heightForRowAtDefault = 50.0
    static let heightForRowAtExpanded = 450.0
    
    static let headerHeightDefault = 40.0
    static let headerHeightMainData = 150.0
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
}

final class BookingView: UIView {
    
    weak var delegate: IBookingView?
    
    lazy var userDataLabel = UILabel.labelHead(title: String.userDataLabel)
    lazy var userDataAttension = UILabel.labelDescriptionGray(title: String.labelDescription)
    lazy var departureLabel = UILabel.labelDescriptionGray(title: nil)

    lazy var textFieldPhone = UITextField.textFieldInfo(placeholder: String.textFieldPhonePlaceHolder, numberPad: true)
    lazy var textFieldEmail = UITextField.textFieldInfo(placeholder: String.textFieldEmailPlaceholder, numberPad: false)
   
    lazy var buttomForword = UIButton.forwordButton(title: Constants.ButtonForwardTitle.bookingScreen, target: self,  action: #selector(goForword))
    
    lazy var  tableViewMainData = UITableView.customTableView(cellClass: MainDataCell.self, reuseIdentifier: MainDataCell.identifier)
    lazy var  tableViewPassengers = UITableView.customTableView(cellClass: PassengerCell.self, reuseIdentifier: PassengerCell.identifier)
    lazy var  tableViewPrice = UITableView.customTableView(cellClass: MainDataCell.self, reuseIdentifier: MainDataCell.identifier)
    
    lazy var stackViewMain: UIStackView = {
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
    
    private func addSubViews() {
        addSubview(stackViewMain)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            stackViewMain.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackViewMain.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackViewMain.topAnchor.constraint(equalTo: topAnchor),
            stackViewMain.bottomAnchor.constraint(equalTo: bottomAnchor),
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
    
    @objc func goForword() {
        delegate?.pushToAnotherController()
    }
    
    func getHeaderData(response: BookingModel) {
        let header = MainDataHeader()
        tableViewMainData.tableHeaderView = header
        header.configure(model: MainDataHeaderModel(hotelName: response.hotel_name,
                                                           adressName: response.hotel_adress,
                                                           horating: response.horating,
                                                           rating_name: response.rating_name))
    }
}

extension BookingView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let isExpanded = delegate?.isPassengerExpanded(section: section) ?? Bool()
        
        switch tableView {
        case tableViewPassengers:
            if isExpanded {return 1}
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
        return 1
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
            return cell ?? UITableViewCell()
            
        case tableViewPrice:
            let cell = tableView.dequeueReusableCell(withIdentifier: MainDataCell.identifier, for: indexPath) as? MainDataCell
            guard let model = delegate?.getPriceData(indexPath: indexPath) else {return cell ?? MainDataCell()}
            cell?.configure(model)
            return cell ?? UITableViewCell()
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: MainDataCell.identifier, for: indexPath) as? MainDataCell
            guard let model = delegate?.getMainData(indexPath: indexPath) else {return cell ?? MainDataCell()}
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
            let fullString = (textField.text ?? "") + string
            textField.text = Formuls.shared.format(phoneNumber: fullString, shouldRemoveLastDigit: range.length == 1)
            return false
        } else {
            return false
        }
    }
}

