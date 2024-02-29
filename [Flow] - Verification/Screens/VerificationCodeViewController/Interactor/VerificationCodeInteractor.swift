//
//  VerificationCodeInteractor.swift
//  TourApp
//
//  Created by Cagatay Ceker on 27.02.2024.
//

import Foundation

protocol VerificationCodeInteractorProtocol {
    func didTapConfirmButton(verificationCode: String)
}

protocol VerificationCodeInteractorCoordinatorDelegate: AnyObject {
    func didTapInteractorConfirmButton()
}

final class VerificationCodeInteractor {
    
    weak var coordinator: VerificationCodeInteractorCoordinatorDelegate?
    private let presenter: VerificationCodePresenterProtocol
    private let authService: AuthServiceProtocol
    private let userService: UserServiceProtocol
    private var email: String
    
    init(presenter: VerificationCodePresenterProtocol, authService: AuthServiceProtocol, userService: UserServiceProtocol, email: String) {
        self.presenter = presenter
        self.authService = authService
        self.userService = userService
        self.email = email
    }
}

extension VerificationCodeInteractor: VerificationCodeInteractorProtocol {
    
    func didTapConfirmButton(verificationCode: String) {
        authService.verificationCode(email: email, verificationCode: verificationCode) { result in
            switch result {

            case .success(let response):
                self.userService.updateLoggedInUser(user: response.user, token: response.token)
                self.coordinator?.didTapInteractorConfirmButton()
            
            case .failure(let error):
                self.presenter.presentError(error.toVerificationErrorVerificationCode())
            }
        }
    }
}
