//
//  RoomViewController.swift
//  Hotel App UIKit
//
//  Created by Анастасия on 31.12.2023.
//

import Foundation


protocol IRoomViewModel {
    var result: (() -> Void)? {get set}
    var error: (() -> Void)? {get set}
    var getRoomsCount: Int {get}
    
    func requestt(urlString: String)
    func getRoomData(indexPath: IndexPath) -> Room
}

final class RoomViewModel: IRoomViewModel  {

    let networkService: INetworkService
    private var roomData = [Room]()
    var images = [String]()
    var peculiarities = [String]()
    
    var getRoomsCount: Int {return self.roomData.count }
    var result: (() -> Void)?
    var error: (() -> Void)?
    
    init (networkService: INetworkService) {
        self.networkService = networkService
    }

    func requestt(urlString: String){
        networkService.getDataRoom(urlString: urlString) {  result in
            switch result {
            case .success(let response):
                self.roomData = response.rooms
                self.result?()
            case .failure(_):
                self.error?()
            }
        }
    }
    
    func getRoomData(indexPath: IndexPath) -> Room {
        roomData[indexPath.row]
    }
    
    
}



