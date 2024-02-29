//
//  AuthService.swift
//  TourApp
//
//  Created by Cagatay Ceker on 31.01.2024.

import Foundation
import Alamofire

enum AuthServiceError: Error {
    case loginFailed
    case invalidURL
    case unkownError
    case jsonDecodingError
    case emailAlreadyInUse
    case invalidVerificationCode
    case otherError(message: String)
}

protocol AuthServiceProtocol {
    func login(email: String, password: String, completion: @escaping (Result<AuthResponse, AuthServiceError>) -> Void)
    func register(email: String, password: String, completion: @escaping (Result<Void, AuthServiceError>) -> Void)
    func verificationCode(email: String, verificationCode: String, completion: @escaping (Result<AuthResponse, AuthServiceError>) -> Void)
}

final class AuthService: AuthServiceProtocol {
    
    func login(email: String, password: String, completion: @escaping (Result<AuthResponse, AuthServiceError>) -> Void) {
        
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
    
    func register(email: String, password: String, completion: @escaping (Result<Void, AuthServiceError>) -> Void) {
        
        guard let url = URL(string: "\(NetworkLayerConstant.baseURL)/auth/register") else { return }
        let parameters: Parameters = ["email": email, "password": password]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).response { response in
            
            let statusCode = response.response?.statusCode
            switch statusCode {
            case 201:
                completion(.success(()))
            case 400:
                if let data = response.data {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        if let errorDetail = errorResponse.errors.first, errorDetail.code == "EMAIL_IS_TAKEN" {
                            completion(.failure(.otherError(message: errorDetail.message)))
                        }
                    } catch {
                        completion(.failure(.loginFailed))
                    }
                }
            default:
                break
            }
        }
    }
    
        func verificationCode(email: String, verificationCode: String, completion: @escaping (Result<AuthResponse, AuthServiceError>) -> Void) {
            guard let url = URL(string: "\(NetworkLayerConstant.baseURL)/auth/verify-otp") else { return }
            let parameters: Parameters = ["email": email, "verificationCode": verificationCode]
            
            AF.request(url, method: .post, parameters: parameters).responseDecodable(of: AuthResponse.self) { response in
                switch response.result {
                case .success(let response):
                    completion(.success(response))
                    
                case .failure:
                    if let data = response.data {
                        do {
                            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                            if let errorDetail = errorResponse.errors.first, errorDetail.code == "VERIFICATION_NOT_VALID" {
                                completion(.failure(.otherError(message: errorDetail.message)))
                            }
                        } catch {
                            completion(.failure(.jsonDecodingError))
                        }
                    }
                }
            }
        }
    }

extension AuthServiceError {
    func toRegisterErrorResponse() -> ErrorResponse {
        return ErrorResponse(errors: [ErrorDetail(code: "EMAIL_IS_TAKEN", message: "Email is Taken")])
    }
    func toVerificationErrorVerificationCode() -> ErrorResponse {
        return ErrorResponse(errors: [ErrorDetail(code: "VERIFICATION_NOT_VALID", message: "Verification code is wrong! You have 3 attempts left")])
    }
}
