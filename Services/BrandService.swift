//
//  BrandService.swift
//  TourApp
//
//  Created by Cagatay Ceker on 18.02.2024.
//

import Foundation
import Alamofire

protocol BrandServiceProtocol {
    func getMakers(completion: @escaping (Result<[Maker], Error>) -> Void)
    func getMakerModels(key: String, completion: @escaping (Result<[MakerModel], Error>) -> Void)
    func getMakerModelTrims(key: String, completion: @escaping (Result<[MakerModelTrim], Error>) -> Void)
}

final class BrandService: BrandServiceProtocol {
    
    private let userService: UserServiceProtocol
   
    init(userService: UserServiceProtocol) {
        self.userService = userService
    }
    
    func getMakers(completion: @escaping (Result<[Maker], Error>) -> Void) {
        guard let url = URL(string: "\(NetworkLayerConstant.baseURL)/maker") else { return }
        var headers: HTTPHeaders = []
        if let token = userService.token {
            headers.add(.authorization(bearerToken: token))
        }
     
        AF.request(url, method: .get, headers: headers).responseDecodable(of: [Maker].self) { response in
          
            switch response.result {
            case .success(let response):
                completion(.success(response))
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func getMakerModels(key: String, completion: @escaping (Result<[MakerModel], Error>) -> Void) {
        guard let url = URL(string: "\(NetworkLayerConstant.baseURL)/maker/model/\(key)") else { return }
        var headers: HTTPHeaders = []
        if let token = userService.token {
            headers.add(.authorization(bearerToken: token))
        }
     
        AF.request(url, method: .get, headers: headers).responseDecodable(of: [MakerModel].self) { response in
          
            switch response.result {
            case .success(let response):
                completion(.success(response))
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func getMakerModelTrims(key: String, completion: @escaping (Result<[MakerModelTrim], Error>) -> Void) {
        guard let url = URL(string: "\(NetworkLayerConstant.baseURL)/maker/model/trim/\(key)") else { return }
        var headers: HTTPHeaders = []
        if let token = userService.token {
            headers.add(.authorization(bearerToken: token))
        }
     
        AF.request(url, method: .get, headers: headers).responseDecodable(of: [MakerModelTrim].self) { response in
          
            switch response.result {
            case .success(let response):
                completion(.success(response))
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}

