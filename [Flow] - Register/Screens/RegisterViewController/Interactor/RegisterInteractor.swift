//
//  RegisterInteractor.swift
//  TourApp
//
//  Created by Cagatay Ceker on 27.02.2024.
//

import Foundation

protocol RegisterInteractorProtocol {
    func didTapNextButton(email: String, password: String)
    func didTapBackLoginButton()
}

protocol RegisterInteractorCoordinatorDelegate: AnyObject {
    func registerInteractorDidTapNextButton(email: String)
    func registerInteractorDidTapBackLoginButton()
}

final class RegisterInteractor {
    
    weak var coordinator: RegisterInteractorCoordinatorDelegate?
    private let presenter: RegisterPresenterProtocol
    private let authService: AuthServiceProtocol
    private let userService: UserServiceProtocol
    
    init(presenter: RegisterPresenterProtocol, authService: AuthServiceProtocol, userService: UserServiceProtocol) {
        self.presenter = presenter
        self.authService = authService
        self.userService = userService
    }
}

extension RegisterInteractor: RegisterInteractorProtocol {
    
    func didTapNextButton(email: String, password: String) {
        
        authService.register(email: email, password: password) { [weak self] result in
            
            DispatchQueue.main.async {
                guard let self else { return }
                
                switch result {
        
                case .success:
                    self.coordinator?.registerInteractorDidTapNextButton(email: email)
                
                case .failure(let error):
                    self.presenter.presentError(error.toRegisterErrorResponse())
                }
            }
        }
    }
    
    func didTapBackLoginButton() {
        coordinator?.registerInteractorDidTapBackLoginButton()
    }
}
