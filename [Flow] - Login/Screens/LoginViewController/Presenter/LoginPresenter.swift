//
//  LoginPresenter.swift
//  TourApp
//
//  Created by Cagatay Ceker on 25.01.2024.
//

import Foundation

protocol LoginPresenterProtocol {
    func presentLoginLoadingScreen()
}

final class LoginPresenter: LoginPresenterProtocol {
    
    weak var viewController: LoginViewControllerProtocol?
    
    func presentLoginLoadingScreen() {
        let caption = "Please Waiting..."
        let viewModel = RPLoadingViewModel(caption: caption)
        viewController?.displayLoadingScreen(viewModel)
    }
}
