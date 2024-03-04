//
//  AuthService.swift
//  TourApp
//
//  Created by Cagatay Ceker on 31.01.2024.

import Foundation
import Alamofire

enum AuthServiceError: Error {
    case loginFailed
    case invalidURL(String)
    case unkownError
    case jsonDecodingError
    case emailAlreadyInUse
    case invalidVerificationCode
    case otherError(message: String)
}

protocol AuthServiceProtocol {
    func login(email: String, password: String, completion: @escaping (Result<AuthResponse, AuthServiceError>) -> Void)
    func register(email: String, password: String, completion: @escaping (Result<Void, AuthServiceError>) -> Void)
    func getVerificationCode(email: String, verificationCode: String, completion: @escaping (Result<AuthResponse, AuthServiceError>) -> Void)
    func editProfile(firstName: String, dateOfBirth: String, lastName: String, username: String, countryCode: String, completion: @escaping (Result<User, AuthServiceError>) -> Void)
    func resendVerificationCode(email: String, completion: @escaping (Result<AuthResponse, AuthServiceError>) -> Void)
}

final class AuthService: AuthServiceProtocol {
   
    private let userService: UserServiceProtocol
    
    init(userService: UserServiceProtocol) {
        self.userService = userService
    }
    
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
                completion(.failure(.loginFailed))
            }
        }
    }
    
        func getVerificationCode(email: String, verificationCode: String, completion: @escaping (Result<AuthResponse, AuthServiceError>) -> Void) {
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
    
    func resendVerificationCode(email: String, completion: @escaping (Result<AuthResponse, AuthServiceError>) -> Void) {
        
        guard let url = URL(string: "\(NetworkLayerConstant.baseURL)/auth/resend-verify-otp") else { return }

           let parameters: Parameters = ["email": email]

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
    
    func editProfile(firstName: String, dateOfBirth: String, lastName: String, username: String, countryCode: String, completion: @escaping (Result<User, AuthServiceError>) -> Void) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        guard let dateOfBirthDate = dateFormatter.date(from: dateOfBirth) else { return }
        let formattedDateOfBirth = dateFormatter.string(from: dateOfBirthDate)
        
        guard let url = URL(string: "\(NetworkLayerConstant.baseURL)/users/update") else { return }
        var headers: HTTPHeaders = []
        let parameters: Parameters = ["firstName": firstName, "dateOfBirth": formattedDateOfBirth, "lastName": lastName, "username": username, "countryCode": countryCode]
        if let token = userService.token {
            headers.add(.authorization(bearerToken: token))
        }
        AF.request(url, method: .patch, parameters: parameters, headers: headers).responseDecodable(of: User.self) { response in
            
            switch response.result {
            case .success(let response):
                completion(.success(response))
        
            case .failure(let error):
                completion(.failure(.invalidURL("Error: \(error)")))
            }
        }
    }
}

extension AuthServiceError {
    func toRegisterErrorResponse() -> ErrorResponse {
        return ErrorResponse(errors: [ErrorDetail(code: "EMAIL_IS_TAKEN", message: "Email is Taken")])
    }
    func toVerificationCodeError() -> ErrorResponse {
        return ErrorResponse(errors: [ErrorDetail(code: "VERIFICATION_NOT_VALID", message: "Verification code is wrong! You have 3 attempts left")])
    }
}
