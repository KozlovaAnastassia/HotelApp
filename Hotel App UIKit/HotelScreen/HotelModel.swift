//
//  MainModel.swift
//  Hotel App UIKit
//
//  Created by Анастасия on 29.12.2023.
//

import Foundation

struct HotelModel: Codable {
    let id: Int
    let name: String
    let adress: String?
    let minimal_price: Int
    let price_for_it: String
    let rating: Int
    let rating_name: String
    let image_urls: [String]
    let about_the_hotel: HotelDescription

    struct HotelDescription: Codable {
        let description: String
        let peculiarities: [String]
    }
}


