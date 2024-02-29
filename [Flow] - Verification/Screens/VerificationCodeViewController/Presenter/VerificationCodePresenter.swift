//
//  VerificationCodePresenter.swift
//  TourApp
//
//  Created by Cagatay Ceker on 27.02.2024.
//

import Foundation

protocol VerificationCodePresenterProtocol {
    func presentError(_ errorReponse: ErrorResponse, remainingAttemp: Int)
}

final class VerificationCodePresenter: VerificationCodePresenterProtocol {
    
    weak var viewController: VerificationCodeViewControllerProtocol?
    
    func presentError(_ errorReponse: ErrorResponse, remainingAttemp: Int) {
        var displayErrorMessage = ""
        
        for error in errorReponse.errors {
            if error.code == "VERIFICATION_NOT_VALID" {
                displayErrorMessage = error.message
            }
        }
        viewController?.displayViewState(.error(displayErrorMessage), remainingAttemp: remainingAttemp)
    }
}
