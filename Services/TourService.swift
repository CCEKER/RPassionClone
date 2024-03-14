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
    func createTour(title: String, description: String?, tourType: TourType, completion: @escaping (Result<CreateTourResponse, Error>) -> Void)
    func startDay(startDay: String, tourId: String, completion: @escaping (Result<Void, Error>) -> Void)
    func createTourDay(tourId: String, completion: @escaping (Result<CreateTourDayModel, Error>) -> Void)
    func getItineraryTour(tourId: String, completion: @escaping (Result<[Journey], Error>) -> Void)
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
    
    func createTour(title: String, description: String?, tourType: TourType, completion: @escaping (Result<CreateTourResponse, Error>) -> Void) {
        
        guard let url = URL(string: "\(NetworkLayerConstant.baseURL)/tour") else { return }
        let parameters: Parameters = ["title": title,
                                      "description": description ?? "",
                                      "tourType": tourType.intValue]
        var headers: HTTPHeaders = []
        if let token = userService.token {
            headers.add(.authorization(bearerToken: token))
        }
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseDecodable(of: CreateTourResponse.self) { response in
          
            switch response.result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                print("create Tour Error: \(error)")
            }
        }
    }
    
    func startDay(startDay: String, tourId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        
        guard let url = URL(string: "\(NetworkLayerConstant.baseURL)/tour/\(tourId)/startDay") else { return }
        let parameters: Parameters = ["startDay": startDay]
        var headers: HTTPHeaders = []
        if let token = userService.token {
            headers.add(.authorization(bearerToken: token))
        }
        AF.request(url, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: headers).response { response in
            
            switch response.result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                print("startDayError: \(error)")
            }
        }
    }
    
    func createTourDay(tourId: String, completion: @escaping (Result<CreateTourDayModel, Error>) -> Void) {
        
        guard let url = URL(string: "\(NetworkLayerConstant.baseURL)/tour/day/\(tourId)") else { return }
        var headers: HTTPHeaders = []
        if let token = userService.token {
            headers.add(.authorization(bearerToken: token))
        }
        AF.request(url, method: .post, headers: headers).responseDecodable(of: CreateTourDayModel.self) { response in
            
            switch response.result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure("CreateTourDay Error: \(error)" as! Error))
            }
        }
    }
    
    func getItineraryTour(tourId: String, completion: @escaping (Result<[Journey], Error>) -> Void) {
        
        guard let url = URL(string: "\(NetworkLayerConstant.baseURL)/tour/day/\(tourId)") else { return }
        var headers: HTTPHeaders = []
        if let token = userService.token {
            headers.add(.authorization(bearerToken: token))
        }
        AF.request(url, method: .get, headers: headers).responseDecodable(of: ItineraryTourModel.self) { response in
           
            switch response.result {
            case .success(let response):
                completion(.success(response.journeys))
            case .failure(let error):
                completion(.failure("getItineraryErreor: \(error)" as! Error))
            }
        }
    }
}
