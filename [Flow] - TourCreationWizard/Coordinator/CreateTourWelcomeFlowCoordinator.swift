//
//  CreateTourWelcomeFlowCoordinator.swift
//  TourApp
//
//  Created by Cagatay Ceker on 11.03.2024.
//

import Foundation
import UIKit

protocol CreateTourWelcomeFlowCoordinatorProtocol {
    func start()
}

protocol CreateTourWelcomeFlowCoordinatorDelegate {
    
}

final class CreateTourWelcomeFlowCoordinator: CreateTourWelcomeFlowCoordinatorProtocol {
    
    private let delegate: CreateTourWelcomeFlowCoordinatorDelegate
    private var resolver: CreateTourWelcomeFlowCoordinatorResolver
    private let presentingViewController: UINavigationController
    
    init(delegate: CreateTourWelcomeFlowCoordinatorDelegate, resolver: CreateTourWelcomeFlowCoordinatorResolver, presentingViewController: UINavigationController) {
        self.delegate = delegate
        self.resolver = resolver
        self.presentingViewController = presentingViewController
    }
    
    func start() {
        
        let createTourWelcomeViewController = resolver.resolveCreateTourWelcomeFlowCoordinator(delegate: self)
        createTourWelcomeViewController.modalPresentationStyle = .fullScreen
        presentingViewController.present(createTourWelcomeViewController, animated: true)
    }
}

extension CreateTourWelcomeFlowCoordinator: CreateTourWelcomeInteractorCoordinatorDelegate {
    
    func didTapStartCreateTourButton() {
        
        presentingViewController.dismiss(animated: true)
        let createTourViewController = resolver.resolveCreateTourViewController(delegate: self)
        createTourViewController.modalPresentationStyle = .fullScreen
        presentingViewController.pushViewController(createTourViewController, animated: true)
        
    }
    
    func createTourWelcomeInteractorDidTapCloseButton() {
        presentingViewController.dismiss(animated: true)
    }
}

extension CreateTourWelcomeFlowCoordinator: CreateTourInteractorCoordinatorDelegate {
    
    func didTapCreateTourButton(tourId: String) {
        
    }
}
