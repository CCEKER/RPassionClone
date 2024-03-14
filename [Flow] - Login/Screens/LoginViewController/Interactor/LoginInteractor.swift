//
//  LoginInteractor.swift
//  TourApp
//
//  Created by Cagatay Ceker on 25.01.2024.
//

import Foundation

protocol LoginInteractorProtocol {
    func didTapLoginButton(email: String, password: String)
    func didTapRegisterButton()
}

protocol LoginInteractorCoordinatorDelegate: AnyObject {
    func loginInteractorUserDidLogin()
    func loginInteractorDidTapRegister()
}

final class LoginInteractor {
    
    private let presenter: LoginPresenterProtocol
    weak var coordinator: LoginInteractorCoordinatorDelegate?
    private let authService: AuthServiceProtocol
    private let userService: UserServiceProtocol
    
    init(presenter: LoginPresenterProtocol, authService: AuthServiceProtocol, userService: UserServiceProtocol) {
        self.presenter = presenter
        self.authService = authService
        self.userService = userService
    }
}

extension LoginInteractor: LoginInteractorProtocol {
    
    func didTapLoginButton(email: String, password: String) {
        
        presenter.presentLoginLoadingScreen()
        authService.login(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    self.userService.updateLoggedInUser(user: response.user, token: response.token)
                    if let userData = try? JSONEncoder().encode(response.user) {
                        UserDefaults.standard.set(userData, forKey: "user")
                    }
                    UserDefaults.standard.set(response.token, forKey: "token")
                    self.coordinator?.loginInteractorUserDidLogin()
                    
                case .failure(let error):
					guard case .otherError(let message) = error else { return }
					self.presenter.presentError(message)
                }
            }
        }
    }
    
    func didTapRegisterButton() {
        coordinator?.loginInteractorDidTapRegister()
    }
}
