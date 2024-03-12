//
//  CreateTourPresenter.swift
//  TourApp
//
//  Created by Cagatay Ceker on 11.03.2024.
//

import Foundation

protocol CreateTourPresenterProtocol {
    func presentCreateTourScreen()
}

final class CreateTourPresenter: CreateTourPresenterProtocol {
    
    weak var viewController: CreateTourViewControllerProtocol?
    
    func presentCreateTourScreen() {
        
        let viewModel = CreateTourViewModel(navigationTitle: "Create Tour",
                                            tourNameTextFieldPlaceHolder: "Tour Name",
                                            tourDescriptionText: "Tour Description (optional)",
                                            continueButtonTitleLabel: "Continue"
        )
        viewController?.displayViewState(.initial(viewModel))
    }
}
