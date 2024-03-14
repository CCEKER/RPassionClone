//
//  LoginPresenter.swift
//  TourApp
//
//  Created by Cagatay Ceker on 25.01.2024.
//

import Foundation

protocol LoginPresenterProtocol {
    func presentLoginLoadingScreen()
	func presentError(_ errorMessage: String)
}

final class LoginPresenter: LoginPresenterProtocol {
    
    weak var viewController: LoginViewControllerProtocol?
    
    func presentLoginLoadingScreen() {
        let caption = "Please Waiting..."
        let viewModel = RPLoadingViewModel(caption: caption)
        viewController?.displayLoadingScreen(viewModel)
    }
	
	func presentError(_ errorMessage: String) {
		let errorViewModel = ErrorViewModel(
			title: "Hata!",
			description: errorMessage,
			actionButtonTitle: nil,
			cancelButtonTitle: "Kapat"
		)
		
		viewController?.displayState(.error(errorViewModel))
	}
}
