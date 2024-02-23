//
//  CarService.swift
//  TourApp
//
//  Created by Cagatay Ceker on 12.02.2024.
//

import Foundation
import Alamofire

struct CarListResponse: Decodable {
    let list: [Car]
    let totalCount: Int
}

protocol CarServiceProtocol {
    func getCarList(userId: String, completion: @escaping (Result<[Car], Error>) -> Void)
    func createCar(trimId: String, nickname: String, completion: @escaping (Result<Car, Error>) -> Void)
}

final class CarService: CarServiceProtocol {
    
    private let userService: UserServiceProtocol
    
    init(userService: UserServiceProtocol) {
        self.userService = userService
    }
    
    func getCarList(userId: String, completion: @escaping (Result<[Car], Error>) -> Void) {
        
        guard let url = URL(string: "\(NetworkLayerConstant.baseURL)/car/owner/\(userId)") else { return }
        var headers: HTTPHeaders = []
        if let token = userService.token {
            headers.add(.authorization(bearerToken: token))
        }
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: CarListResponse.self) { response in
            
            switch response.result {
            case .success(let response):
                completion(.success(response.list))
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func createCar(trimId: String, nickname: String, completion: @escaping (Result<Car, Error>) -> Void) {
        guard let url = URL(string: "\(NetworkLayerConstant.baseURL)/car") else { return }
        let parameter: Parameters = ["trimId": trimId, "nickname": nickname]
        var headers: HTTPHeaders = []
        if let token = userService.token {
            headers.add(.authorization(bearerToken: token))
        }
        AF.request(url, method: .post, parameters: parameter, headers: headers).responseDecodable(of: Car.self) { response in
            
            switch response.result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
                print("Error: \(error)")
            }
        }
    }
}
