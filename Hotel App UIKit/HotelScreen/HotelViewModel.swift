//
//  HotelViewModel.swift
//  Hotel App UIKit
//
//  Created by Анастасия on 29.12.2023.
//

import UIKit


protocol IHotelViewModel {
    var result: ((HotelModel) -> Void)? {get set}
    var error: (() -> Void)? {get set}
    var numberOfpeculiarities: Int {get}
    var numberOfImages: Int {get}
    
    func requestt(urlString: String)
    func getPeculiaritiesCount() -> Int
    func getPeculiarities(indexPath: IndexPath) -> String
    func getImagesCount() -> Int
    func getImage(indexPath: IndexPath) -> ImageModel
}

final class HotelViewModel: IHotelViewModel  {

    let networkService: INetworkService
    var images = [String]()
    var peculiarities = [String]()
    
    var numberOfpeculiarities: Int {return self.images.count }
    var numberOfImages: Int {return self.peculiarities.count}
    var result: ((HotelModel) -> Void)?
    var error: (() -> Void)?
    
    init (networkService: INetworkService) {
        self.networkService = networkService
    }

    func requestt(urlString: String){
        networkService.getDataHotel(urlString: urlString) {  result in
            switch result {
            case .success(let response):
                self.result?(response)
                self.images += response.image_urls
                self.peculiarities += response.about_the_hotel.peculiarities
            case .failure(_):
                self.error?()
            }
        }
    }
    
    func getPeculiaritiesCount() -> Int {
        peculiarities.count
    }
    
    func getImagesCount() -> Int {
        images.count
    }
    
    func getPeculiarities(indexPath: IndexPath) -> String {
        peculiarities[indexPath.row]
    }
    
    func getImage(indexPath: IndexPath) -> ImageModel {
        ImageModel(imageURL: images[indexPath.row], id: "\(images[indexPath.row])")
    }
    
}



