//
//  BookingViewModel.swift
//  Hotel App UIKit
//
//  Created by Анастасия on 29.12.2023.
//

import UIKit


protocol IBookingViewModel {
    var result: ((BookingModel) -> Void)? {get set}
    var error: (() -> Void)? {get set}
    var getPriceDataCount: Int {get}
    var getPassengersCount: Int {get}
    var getMainDataCount: Int {get}
    
    func requestt(urlString: String)
    func isPassengerExpanded(section: Int) -> Bool
    func getPassengerSectionData(section: Int) -> String
    func getPriceData(indexPath: IndexPath) -> MainDataModel
    func getPassengersData(indexPath: IndexPath) -> PassenderModel
    func getMainData(indexPath: IndexPath) -> MainDataModel
    func updateInterfece(response: BookingModel)
    func buttonTapped(sender: UIButton)
}

final class BookingViewModel: IBookingViewModel  {
 
    let networkService: INetworkService

    
    var getPriceDataCount: Int {return self.arrayPriceData.count }
    var getPassengersCount: Int {return self.passengers.count}
    var getMainDataCount: Int {return self.arrayData.count}
    
    var result: ((BookingModel) -> Void)?
    var error: (() -> Void)?
    
    var arrayName = ["Вылет из", "Страна, город", "Даты", "Кол-во ночей", "Отель", "Номер", "Питание"]
    var arrayPrice = ["Тур", "Топливный сбор", "Сервисный сбор", "К оплате"]
    var arrayData = [MainDataModel]()
    var arrayPriceData = [MainDataModel]()
    var passengers = [
        PassenderModel(passenderName: "Турист 1", isExpanded: false),
        PassenderModel(passenderName: "Добавить туриста", isExpanded: false)
    ]
    
    init (networkService: INetworkService) {
        self.networkService = networkService
    }

    func requestt(urlString: String){
        networkService.getDataBooking(urlString: urlString) {  result in
            switch result {
            case .success(let response):
                self.result?(response)
            case .failure(_):
                self.error?()
            }
        }
    }
    
    func updateInterfece(response: BookingModel)  {
        arrayData.append(MainDataModel(name: arrayName[0], data: response.departure))
        arrayData.append(MainDataModel(name: arrayName[1], data: response.arrival_country))
        arrayData.append(MainDataModel(name: arrayName[2], data: "\(response.tour_date_start) - \(response.tour_date_stop)"))
        arrayData.append(MainDataModel(name: arrayName[3], data: "\(response.number_of_nights) ночей"))
        arrayData.append(MainDataModel(name: arrayName[4], data: response.hotel_name))
        arrayData.append(MainDataModel(name: arrayName[5], data: response.room))
        arrayData.append(MainDataModel(name: arrayName[6], data: response.nutrition))
        
        arrayPriceData.append(MainDataModel(name: arrayPrice[0], data: Formuls.shared.intToCurrency(integer: response.tour_price)))
        arrayPriceData.append(MainDataModel(name: arrayPrice[1], data: Formuls.shared.intToCurrency(integer: response.fuel_charge)))
        arrayPriceData.append(MainDataModel(name: arrayPrice[2], data: Formuls.shared.intToCurrency(integer: response.service_charge)))
                              
        let total = response.tour_price + response.fuel_charge + response.service_charge
        arrayPriceData.append(MainDataModel(name: arrayPrice[3], data: Formuls.shared.intToCurrency(integer:total)))
    }
    
    
    func isPassengerExpanded(section: Int) -> Bool {
        passengers[section].isExpanded
    }
    
    func getPassengerSectionData(section: Int) -> String {
         passengers[section].passenderName
    }
    
    func getPriceData(indexPath: IndexPath) -> MainDataModel {
         arrayPriceData[indexPath.row]
    }
    
    func getPassengersData(indexPath: IndexPath) -> PassenderModel {
        passengers[indexPath.row]
    }
    
    func getMainData(indexPath: IndexPath) -> MainDataModel {
        arrayData[indexPath.row]
    }
    
    func buttonTapped(sender: UIButton) {
        if sender.tag == passengers.count - 1 {
            passengers.insert(PassenderModel(passenderName: "Турист \(sender.tag + 1)", isExpanded: false),  at: passengers.count - 1)
        } else {
            passengers[sender.tag].isExpanded = !passengers[sender.tag].isExpanded
        }
    }
    
}
