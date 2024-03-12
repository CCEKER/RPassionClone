//
//  ParticipantsViewController+Build.swift
//  TourApp
//
//  Created by Cagatay Ceker on 20.02.2024.
//

import Foundation
import UIKit

extension ParticipantsViewController {
    static func build(coordinator: ParticipantsInteractorCoordinatorDelegate, tourId: String, tourService: TourServiceProtocol, participantsLimit: Int, participantsJoined: Int) -> UIViewController {
        let presenter = ParticipantsPresenter()
        let interactor = ParticipantsInteractor(presenter: presenter, tourService: tourService, tourId: tourId,  participantsLimit: participantsLimit, participantsJoined: participantsJoined)
        interactor.coordinator = coordinator
        let viewController = ParticipantsViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
