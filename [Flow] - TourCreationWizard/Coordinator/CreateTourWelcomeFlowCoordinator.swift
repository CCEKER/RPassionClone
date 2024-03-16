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
    func createTourWelcomeFlowDidFinish()
}

final class CreateTourWelcomeFlowCoordinator: CreateTourWelcomeFlowCoordinatorProtocol {
    
    private let delegate: CreateTourWelcomeFlowCoordinatorDelegate
    private var resolver: CreateTourWelcomeFlowCoordinatorResolver
    private let presentingViewController: UIViewController
    private var navigationController: UINavigationController?
    
    init(delegate: CreateTourWelcomeFlowCoordinatorDelegate, resolver: CreateTourWelcomeFlowCoordinatorResolver, presentingViewController: UIViewController) {
        self.delegate = delegate
        self.resolver = resolver
        self.presentingViewController = presentingViewController
    }
    
    func start() {
        
        let createTourWelcomeViewController = resolver.resolveCreateTourWelcomeFlowCoordinator(delegate: self)
        let navigationController = UINavigationController(rootViewController: createTourWelcomeViewController)
        self.navigationController = navigationController
        navigationController.modalPresentationStyle = .fullScreen
        presentingViewController.present(navigationController, animated: true)
    }
}

extension CreateTourWelcomeFlowCoordinator: CreateTourWelcomeInteractorCoordinatorDelegate {
    
    func didTapStartCreateTourButton() {
        
        let createTourViewController = resolver.resolveCreateTourViewController(delegate: self)
        navigationController?.pushViewController(createTourViewController, animated: true)
    }
    
    func createTourWelcomeInteractorDidTapCloseButton() {
        navigationController?.dismiss(animated: true)
        delegate.createTourWelcomeFlowDidFinish()
    }
}

extension CreateTourWelcomeFlowCoordinator: CreateTourInteractorCoordinatorDelegate {
    
    func didTapCreateTourButton(tourId: String) {
    
        let tourTimeViewController = resolver.resolveTourTimeViewController(delegate: self, tourId: tourId)
        navigationController?.pushViewController(tourTimeViewController, animated: true)
    }
}

extension CreateTourWelcomeFlowCoordinator: TourTimeInteractorCoordinatorDelegate {
    
    func tourTimeInteractorDidTapContinueButton(tourId: String) {
        let itineraryViewController = resolver.resolveItineraryViewController(delegate: self, tourId: tourId)
        navigationController?.pushViewController(itineraryViewController, animated: true)
    }
}

extension CreateTourWelcomeFlowCoordinator: ItineraryInteractorCoordinatorDelegate {
    
    func itineraryInteractorDidTapAddButton() {
        let mapViewController = resolver.resolveMapViewController(delegate: self)
        navigationController?.pushViewController(mapViewController, animated: true)
    }
}

extension CreateTourWelcomeFlowCoordinator: MapInteractorCoordinatorDelegate {
    
    func mapInteractorDidTapCheckAddressButton(dayId: Int, address: String) {
        let locationDetailViewController = resolver.resolveLocationDetailViewController(delegate: self, dayId: dayId, address: address)
        navigationController?.pushViewController(locationDetailViewController, animated: true)
    }
}

extension CreateTourWelcomeFlowCoordinator: LocationDetailInteractorCoordinatorDelegate {
    
}
