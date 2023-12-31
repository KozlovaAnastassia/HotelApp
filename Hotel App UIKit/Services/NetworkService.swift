//
//  NetworkService.swift
//  Hotel App UIKit
//
//  Created by Анастасия on 30.12.2023.
//

import UIKit

protocol INetworkService {
    func getDataHotel(urlString: String, completion: @escaping (Result<HotelModel, Error>) -> Void)
    func getDataRoom(urlString: String, completion: @escaping (Result<ModelRoom, Error>) -> Void)
    func getDataBooking(urlString: String, completion: @escaping (Result<BookingModel, Error>) -> Void)
}

final class NetworkService: INetworkService {

    func getDataHotel(urlString: String, completion: @escaping (Result<HotelModel, Error>) -> Void) {
        request(urlString: urlString, completion: completion)
    }
    func getDataRoom(urlString: String, completion: @escaping (Result<ModelRoom, Error>) -> Void) {
        request(urlString: urlString, completion: completion)
    }
    func getDataBooking(urlString: String, completion: @escaping (Result<BookingModel, Error>) -> Void) {
        request(urlString: urlString, completion: completion)
    }

    private func request<T: Decodable>(urlString: String, completion: @escaping (Result<T, Error>) -> Void ) {

        guard let url = URL(string: urlString) else {return}

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {return}
                do {
                    let tracks = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(tracks))
                } catch let jsonError {
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
}
