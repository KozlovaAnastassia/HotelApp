//
//  Constants.swift
//  Hotel App UIKit
//
//  Created by Анастасия on 29.12.2023.
//

import UIKit

enum State {
    case plain
    case failure
    case loaded
    case loading
}

enum Constants {
    enum ButtonForwardTitle {
        static let hotelScreen: String = "К выбору номера"
        static let bookingScreen: String = "К оплате"
        static let roomScreen: String = "Выбрать номер"
        static let acceptScreen: String = "Супер"
    }
    
    enum CornerRadius {
        static let radius10: CGFloat = 10
    }
    
    enum ControllerTitle {
        static let hotel: String = "Отель"
        static let accept: String = "Заказ оплачен"
        static let booking: String = "Бронирование"
    }
    
    enum Colors {
        static let graybg: UIColor = UIColor(hexString: "#FBFBFC")
        static let grayTextField: UIColor = UIColor(hexString: "#F6F6F9")
        static let fontGray: UIColor = UIColor(hexString: "#828796")
        static let yellowFont: UIColor = UIColor(hexString: "#FFA800")
        static let yellowBg: UIColor = UIColor(hexString: "#FFC700").withAlphaComponent(CGFloat(0.2))
        static let blueFont: UIColor = UIColor(hexString: "#0D72FF")
        static let errorColor: UIColor = UIColor(hexString: "#EB5757").withAlphaComponent(CGFloat(0.15))
    }
    
    enum Url {
        static let hotelURL  = "https://run.mocky.io/v3/d144777c-a67f-4e35-867a-cacc3b827473"
        static let bookingURL  = "https://run.mocky.io/v3/63866c74-d593-432c-af8e-f279d1a8d2ff"
        static let roomURL  = "https://run.mocky.io/v3/8b532701-709e-4194-a41c-1a903af00195"
    }
    
    enum Errors {
        static let initError  = "init(coder:) has not been implemented"
    }
    
    enum Spacing {
        static let stackViewSpacingVer: CGFloat = 10
        static let stackViewSpacingHor: CGFloat = 30
    }
    
    enum Constraints {
        static let offset16: CGFloat = 16
        static let inset16: CGFloat = -16
    }
    
    enum ImageSystemName {
        static let arrowForward = "chevron.forward"
        static let arrowback = "chevron.backward"
        static let arrowDown = "chevron.down.square.fill"
        static let arrowUp = "chevron.up.square.fill"
        static let conviniens = "face.smiling"
        static let include = "checkmark.square"
        static let notInclude = "multiply.square"
    }
    
}
