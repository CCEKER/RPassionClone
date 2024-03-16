//
//  LocationDetailViewController+Build.swift
//  TourApp
//
//  Created by Cagatay Ceker on 16.03.2024.
//

import Foundation
import UIKit

extension LocationDetailViewController {
    static func build(coordinator: LocationDetailInteractorCoordinatorDelegate, tourService: TourServiceProtocol, dayId: String, address: String) -> UIViewController {
        let presenter = LocationDetailPresenter()
        let interactor = LocationDetailInteractor(presenter: presenter, tourService: tourService, dayId: dayId, address: address)
        interactor.coordinator = coordinator
        let viewController = LocationDetailViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
