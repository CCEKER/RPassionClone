//
//  ParticipantsFlowCoordinatorModule.swift
//  TourApp
//
//  Created by Cagatay Ceker on 20.02.2024.
//

import Foundation
import Swinject

protocol ParticipantsFlowCoordinatorResolver {
    func resolveParticipantsViewController(delegate: ParticipantsInteractorCoordinatorDelegate, tourId: String, participantsLimit: Int, participantsJoined: Int) -> UIViewController
}

final class ParticipantsFlowCoordinatorModule: ParticipantsFlowCoordinatorResolver {
    
    private let container: Container
    private let resolver: Resolver
    
    init(parentContainer: Container) {
        
        container = Container(parent: parentContainer)
        _ = Assembler([ParticipantsFlowCoordinatorAssembly()], container: container)
        self.resolver = container
    }
    
    func resolveParticipantsViewController(delegate: ParticipantsInteractorCoordinatorDelegate, tourId: String, participantsLimit: Int, participantsJoined: Int) -> UIViewController {
        guard let tourService = resolver.resolve(TourDetailServiceProtocol.self) else {
            fatalError("TourDetailServiceProtocol should be registered!")
        }
        return ParticipantsViewController.build(coordinator: delegate, tourId: tourId, tourService: tourService, participantsLimit: participantsLimit, participantsJoined: participantsJoined)
    }
}
