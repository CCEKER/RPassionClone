//
//  AuthService.swift
//  TourApp
//
//  Created by Cagatay Ceker on 31.01.2024.

import Foundation
import Alamofire

enum LoginServiceError: Error {
    case loginFailed
}

protocol AuthServiceProtocol {
    func login(email: String, password: String, completion: @escaping (Result<AuthResponse, LoginServiceError>) -> Void)
}

final class AuthService: AuthServiceProtocol {

    func login(email: String, password: String, completion: @escaping (Result<AuthResponse, LoginServiceError>) -> Void) {
            
        guard let loginUrl = URL(string: "\(NetworkLayerConstant.baseURL)/auth/login") else { return }
        let parameters: Parameters = [ "email": email, "password": password]
        
        AF.request(loginUrl, method: .post, parameters: parameters).responseDecodable(of: AuthResponse.self) { response in
            switch response.result {
            case .success(let response):
                completion(.success(response))
            case .failure:
                completion(.failure(.loginFailed))
            }
        }
    }
}
