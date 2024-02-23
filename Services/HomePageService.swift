//
//  HomePageService.swift
//  TourApp
//
//  Created by Cagatay Ceker on 8.02.2024.
//

import Foundation
import Alamofire

protocol HomePageServiceProtocol {
    func homePageService(completion: @escaping (Result<HomePageModel, Error>) -> Void)
}

final class HomePageService: HomePageServiceProtocol {
    
    func homePageService(completion: @escaping (Result<HomePageModel, Error>) -> Void) {
        
        guard let homePageUrl = URL(string: "\(NetworkLayerConstant.baseURL)/tour/") else { return }
        
        AF.request(homePageUrl, method: .get).responseDecodable(of: HomePageModel.self) { response in
            
            switch response.result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
