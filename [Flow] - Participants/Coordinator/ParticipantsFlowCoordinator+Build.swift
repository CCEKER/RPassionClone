//
//  ParticipantsFlowCoordinator+Build.swift
//  TourApp
//
//  Created by Cagatay Ceker on 20.02.2024.
//

import Foundation
import Swinject
import UIKit

extension ParticipantsFlowCoordinator {
    static func build(delegate: ParticipantsFlowCoordinatorDelegate, container: Container, tourId: String, presentingViewController: UINavigationController, participantsLimit: Int, participantsJoined: Int) -> ParticipantsFlowCoordinatorProtocol {
        let module = ParticipantsFlowCoordinatorModule(parentContainer: container)
        return ParticipantsFlowCoordinator(delegate: delegate, resolver: module, tourId: tourId, presentingViewController: presentingViewController, participantsLimit: participantsLimit, participantsJoined: participantsJoined)
    }
}
