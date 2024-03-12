//
//  TourService.swift
//  TourApp
//
//  Created by Cagatay Ceker on 8.02.2024.
//

import Foundation
import Alamofire

protocol TourServiceProtocol {
    func getTourDetail(tourId: String, completion: @escaping (Result<TourDetailModel, Error>) -> Void)
    func getParticipants(tourId: String, completion: @escaping (Result<[Participant], Error>) -> Void)
    func createTour(title: String, description: String?, tourType: Int, completion: @escaping (Result<CreateTourResponse, Error>) -> Void)
}

final class TourService: TourServiceProtocol {
    
    private let userService: UserServiceProtocol

    init(userService: UserServiceProtocol) {
        self.userService = userService
    }
    
    func getTourDetail(tourId: String, completion: @escaping (Result<TourDetailModel, Error>) -> Void) {
        
        guard let tourDetailUrl = URL(string: "\(NetworkLayerConstant.baseURL)/tour/\(tourId)") else { return }
        
        AF.request(tourDetailUrl, method: .get).responseDecodable(of: TourDetailModel.self) { response in
            
            switch response.result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func getParticipants(tourId: String, completion: @escaping (Result<[Participant], Error>) -> Void) {
        
        guard let url = URL(string: "\(NetworkLayerConstant.baseURL)/tour/\(tourId)/participants") else { return }
        var headers: HTTPHeaders = []
        if let token = userService.token {
            headers.add(.authorization(bearerToken: token))
        }
        AF.request(url, method: .get, headers: headers).responseDecodable(of: TourParticipants.self) { response in
            
            switch response.result {
            case .success(let response):
                completion(.success(response.participants))
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func createTour(title: String, description: String?, tourType: Int, completion: @escaping (Result<CreateTourResponse, Error>) -> Void) {
        
        guard let url = URL(string: "\(NetworkLayerConstant.baseURL)/tour") else { return }
        let parameters: Parameters = ["title": title, "description": description ?? "", "tourType": tourType]
        var headers: HTTPHeaders = []
        if let token = userService.token {
            headers.add(.authorization(bearerToken: token))
        }
        AF.request(url, method: .post, parameters: parameters, headers: headers).responseString { response in
          
            switch response.result {
            case .success(let response):
                print("Response String \(response)")
            case .failure(let error):
                print("create Tour Error: \(error)")
            }
        }
    }
}
