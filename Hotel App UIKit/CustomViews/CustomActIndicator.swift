//
//  CustomActIndicator.swift
//  Hotel App UIKit
//
//  Created by Анастасия on 31.12.2023.
//

import Foundation
import UIKit

extension UIActivityIndicatorView {
    class func activityIndicator() -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.isHidden = true
        return indicator
    }
}
