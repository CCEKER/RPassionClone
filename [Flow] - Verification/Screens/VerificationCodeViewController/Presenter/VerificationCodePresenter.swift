//
//  VerificationCodePresenter.swift
//  TourApp
//
//  Created by Cagatay Ceker on 27.02.2024.
//

import Foundation

protocol VerificationCodePresenterProtocol {
    func presentError(_ errorReponse: ErrorResponse, remainingAttemp: Int)
    func presentVerificationCodeResentSuccess(email: String)
}

final class VerificationCodePresenter: VerificationCodePresenterProtocol {
    
    weak var viewController: VerificationCodeViewControllerProtocol?
    
    func presentError(_ errorReponse: ErrorResponse, remainingAttemp: Int) {
        
        guard let error = errorReponse.errors.first else { return }
        
        viewController?.displayViewState(.error(error.message), remainingAttemp: remainingAttemp)
    }
    
    func presentVerificationCodeResentSuccess(email: String) {
        viewController?.displayResendVerificationCodeSuccess(email: email)
    }
}
