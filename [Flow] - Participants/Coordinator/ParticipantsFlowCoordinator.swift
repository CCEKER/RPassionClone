//
//  ParticipantsFlowCoordinator.swift
//  TourApp
//
//  Created by Cagatay Ceker on 20.02.2024.
//

import Foundation
import UIKit

protocol ParticipantsFlowCoordinatorProtocol {
    func start()
}

protocol ParticipantsFlowCoordinatorDelegate {
    
}

final class ParticipantsFlowCoordinator: ParticipantsFlowCoordinatorProtocol {
    
    private let delegate: ParticipantsFlowCoordinatorDelegate
    private var resolver: ParticipantsFlowCoordinatorResolver
    private let tourId: String
    private let presentingViewController: UINavigationController
    private var participantsJoined: Int
    private var participantLimit: Int
	
	private var garageFlowCoordinator: GarageFlowCoordinatorProtocol?
    
    init(
		delegate: ParticipantsFlowCoordinatorDelegate,
		resolver: ParticipantsFlowCoordinatorResolver,
		tourId: String,
		presentingViewController: UINavigationController,
		participantsLimit: Int,
		participantsJoined: Int
	) {
        self.delegate = delegate
        self.resolver = resolver
        self.tourId = tourId
        self.presentingViewController = presentingViewController
        self.participantLimit = participantsLimit
        self.participantsJoined = participantsJoined
    }
    
    func start() {
        let participantsViewController = resolver.resolveParticipantsViewController(delegate: self, tourId: tourId, participantsLimit: participantLimit, participantsJoined: participantsJoined)
        presentingViewController.pushViewController(participantsViewController, animated: true)
    }
}

extension ParticipantsFlowCoordinator: ParticipantsInteractorCoordinatorDelegate {
	func participantsInteractorDidTapParticipant(driverId: String) {
		garageFlowCoordinator = resolver.resolveGarageFlowCoordinator(delegate: self, driverId: driverId, presentingViewController: presentingViewController)
		garageFlowCoordinator?.start()
	}
}

extension ParticipantsFlowCoordinator: GarageFlowCoordinatorDelegate {
    func GarageFlowCoordinatorDidFinish() {
        
    }
}
