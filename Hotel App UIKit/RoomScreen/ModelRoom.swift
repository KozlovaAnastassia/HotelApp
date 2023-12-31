//
//  ModelRoom.swift
//  Hotel App UIKit
//
//  Created by Анастасия on 31.12.2023.
//

import Foundation

struct ModelRoom: Codable {
    let rooms: [Room]
}

struct Room: Codable {
    let id: Int
    let name: String
    let price: Int
    let price_per: String
    let peculiarities: [String]
    let image_urls: [String]
}
