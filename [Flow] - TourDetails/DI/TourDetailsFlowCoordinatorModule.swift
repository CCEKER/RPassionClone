//
//  TourDetailsFlowCoordinatorModule.swift
//  TourApp
//
//  Created by Cagatay Ceker on 8.02.2024.
//

import Foundation
import Swinject

protocol TourDetailFlowCoordinatorResolver {
    func resolveTourDetailViewController(delegate: TourDetailsInteractorCoordinatorDelegate, tourId: String) -> UIViewController
    func resolveParticipantsFlow(delegate: ParticipantsFlowCoordinatorDelegate, presentingViewController: UINavigationController, tourId: String, participantsJoined: Int, participantsLimit: Int) -> ParticipantsFlowCoordinatorProtocol
}

final class TourDetailFlowCoordinatorModule: TourDetailFlowCoordinatorResolver {
    
    private let container: Container
    private let resolver: Resolver
    
    init(parentContainer: Container) {
        container = Container(parent: parentContainer)
        _ = Assembler([TourDetailsFlowCoordinatorAssembly()], container: container)
        
        self.resolver = container
    }
    
    func resolveTourDetailViewController(delegate: TourDetailsInteractorCoordinatorDelegate, tourId: String) -> UIViewController {
        guard let tourDetailService = resolver.resolve(TourDetailServiceProtocol.self) else {
            fatalError("TourDetailServiceProtocol should be registered!")
        }
        return TourDetailsViewController.build(coordinator: delegate, tourDetailService: tourDetailService, tourId: tourId)
    }
    
    func resolveParticipantsFlow(delegate: ParticipantsFlowCoordinatorDelegate, presentingViewController: UINavigationController, tourId: String, participantsJoined: Int, participantsLimit: Int) -> ParticipantsFlowCoordinatorProtocol {
        let participantsFlowCoordinator = ParticipantsFlowCoordinator.build(delegate: delegate, container: container, tourId: tourId, presentingViewController: presentingViewController, participantsLimit: participantsLimit, participantsJoined: participantsJoined)
        return participantsFlowCoordinator
    }
}
