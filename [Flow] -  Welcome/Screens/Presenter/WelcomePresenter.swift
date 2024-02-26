//
//  WelcomePresenter.swift
//  TourApp
//
//  Created by Cagatay Ceker on 26.02.2024.
//

import Foundation

protocol WelcomePresenterProtocol {
    func setupInitialState()
}

final class WelcomePresenter: WelcomePresenterProtocol {
    
    weak var viewController: WelcomeViewControllerProtocol?
    
    func setupInitialState() {
        viewController?.displayViewState(.initial)
    }
}
