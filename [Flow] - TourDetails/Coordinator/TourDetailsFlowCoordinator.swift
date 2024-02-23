//
//  TourDetailsFlowCoordinator.swift
//  TourApp
//
//  Created by Cagatay Ceker on 8.02.2024.
//

import Foundation
import UIKit

protocol TourDetailFlowCoordinatorProtocol {
    func start()
}

protocol TourDetailFlowCoordinatorDelegate {
    
}

final class TourDetailFlowCoordinator: TourDetailFlowCoordinatorProtocol {
    
    private let delegate: TourDetailFlowCoordinatorDelegate
    private var resolver: TourDetailFlowCoordinatorResolver
    private let tourId: String
    private let presentingViewController: UINavigationController
    private var participantsFlowCoordinator: ParticipantsFlowCoordinatorProtocol?
    private var participantsJoined: Int?
    private var participantsLimit: Int?
    
    init(delegate: TourDetailFlowCoordinatorDelegate, resolver: TourDetailFlowCoordinatorResolver, tourId: String, presentingViewController: UINavigationController) {
        self.delegate = delegate
        self.resolver = resolver
        self.tourId = tourId
        self.presentingViewController = presentingViewController
    }
    
    func start() {
        let tourDetailViewController = resolver.resolveTourDetailViewController(delegate: self, tourId: tourId)
        presentingViewController.pushViewController(tourDetailViewController, animated: true)
    }
}

extension TourDetailFlowCoordinator: TourDetailsInteractorCoordinatorDelegate {
    
    func didTapParticipant(tourId: String, participantsLimit: Int, participantsJoined: Int) {
        participantsFlowCoordinator = resolver.resolveParticipantsFlow(delegate: self, presentingViewController: presentingViewController, tourId: tourId, participantsJoined: participantsJoined, participantsLimit: participantsLimit)
        participantsFlowCoordinator?.start()
    }
}

extension TourDetailFlowCoordinator: ParticipantsFlowCoordinatorDelegate {
    
}
