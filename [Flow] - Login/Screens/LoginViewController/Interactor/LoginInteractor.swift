//
//  LoginInteractor.swift
//  TourApp
//
//  Created by Cagatay Ceker on 25.01.2024.
//

import Foundation

protocol LoginInteractorProtocol {
    func didTapLoginButton(email: String, password: String)
}

protocol LoginInteractorCoordinatorDelegate: AnyObject {
    func loginInteractorUserDidLogin()
}

final class LoginInteractor {
    
    private let presenter: LoginPresenterProtocol
    weak var coordinator: LoginInteractorCoordinatorDelegate?
    private let loginService: LoginServiceProtocol
    private let userService: UserServiceProtocol
    
    init(presenter: LoginPresenterProtocol, loginService: LoginServiceProtocol, userService: UserServiceProtocol) {
        self.presenter = presenter
        self.loginService = loginService
        self.userService = userService
    }
}

extension LoginInteractor: LoginInteractorProtocol {
    
    func didTapLoginButton(email: String, password: String) {
        
        loginService.login(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    self.userService.updateLoggedInUser(user: response.user, token: response.token)
                    self.coordinator?.loginInteractorUserDidLogin()
                    
                case .failure(let error):
                    print("Login failed with error: \(error)")
                }
            }
        }
    }
}
