//
//  RegisterPresenter.swift
//  TourApp
//
//  Created by Cagatay Ceker on 27.02.2024.
//

import Foundation

protocol RegisterPresenterProtocol {
    func presentError(_ errorReponse: ErrorResponse)
}

final class RegisterPresenter: RegisterPresenterProtocol {
    
    weak var viewController: RegisterViewControllerProtocol?
    
    func presentError(_ errorReponse: ErrorResponse) {
        
        var displayErrorMessage = ""
        
        for error in errorReponse.errors {
            if error.code == "EMAIL_IS_TAKEN" {
                displayErrorMessage = error.message
            }
        }
        viewController?.displayViewState(.error(displayErrorMessage))
    }
}
