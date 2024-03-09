//
//  VerificationCodeInteractor.swift
//  TourApp
//
//  Created by Cagatay Ceker on 27.02.2024.
//

import Foundation

protocol VerificationCodeInteractorProtocol {
    func didTapConfirmButton(verificationCode: String)
    func didTapResendCodeButton()
}

protocol VerificationCodeInteractorCoordinatorDelegate: AnyObject {
    func didTapInteractorConfirmButton()
}

final class VerificationCodeInteractor {
	
	enum Constant {
		static var maximumAttempt = 5
	}
    
    weak var coordinator: VerificationCodeInteractorCoordinatorDelegate?
    private let presenter: VerificationCodePresenterProtocol
    private let authService: AuthServiceProtocol
    private let userService: UserServiceProtocol
    private var email: String
	private var remainingAttempts = Constant.maximumAttempt
    
    init(presenter: VerificationCodePresenterProtocol, authService: AuthServiceProtocol, userService: UserServiceProtocol, email: String) {
        self.presenter = presenter
        self.authService = authService
        self.userService = userService
        self.email = email
    }
}

extension VerificationCodeInteractor: VerificationCodeInteractorProtocol {
    
    func didTapConfirmButton(verificationCode: String) {
        
		presenter.presentLoading()
        authService.getVerificationCode(email: email, verificationCode: verificationCode) { [weak self] result in
            DispatchQueue.main.async {
                guard let self else { return }
                
                switch result {
                    
                case .success(let response):
                    if let email = response.user.email {
                        self.email = email
                    }
                    self.userService.updateLoggedInUser(user: response.user, token: response.token)
                    self.coordinator?.didTapInteractorConfirmButton()
                    
                case .failure(let error):
                    self.remainingAttempts -= 1
                    self.presenter.presentError(error.toVerificationCodeError(), remainingAttemp: self.remainingAttempts)
                }
            }
        }
    }
    
    func didTapResendCodeButton() {
       
		presenter.presentLoading()
        authService.resendVerificationCode(email: email) { [weak self] result in
			guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success:
					self.presenter.presentVerificationCodeResentSuccess(email: self.email)
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
}
