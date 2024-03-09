//
//  VerificationCodePresenter.swift
//  TourApp
//
//  Created by Cagatay Ceker on 27.02.2024.
//

import Foundation

protocol VerificationCodePresenterProtocol {
    func presentError(_ errorReponse: ErrorResponse, remainingAttemp: Int)
	func presentLoading()
    func presentVerificationCodeResentSuccess(email: String)
}

final class VerificationCodePresenter: VerificationCodePresenterProtocol {
	
	enum Constant {
		static let remainingSeconds = 60
	}
    
    weak var viewController: VerificationCodeViewControllerProtocol?
    
    func presentError(_ errorReponse: ErrorResponse, remainingAttemp: Int) {
        
        guard let error = errorReponse.errors.first else { return }
        
        viewController?.displayViewState(.error(error.message), remainingAttemp: remainingAttemp)
    }
    
    func presentVerificationCodeResentSuccess(email: String) {
		
		let viewModel = ResendVerificationCodeSuccessViewModel(
			remainingSeconds: Constant.remainingSeconds,
			isTimerLabelHidden: true,
			isResendCodeButtonHidden: false,
			shouldTimerStart: true,
			userEmail: email
		)
		
        viewController?.displayResendVerificationCodeSuccess(viewModel: viewModel)
    }
	
	func presentLoading() {
		let caption = "Please wait..."
		let viewModel = RPLoadingViewModel(caption: caption)
		viewController?.displayLoading(viewModel)
	}
}
