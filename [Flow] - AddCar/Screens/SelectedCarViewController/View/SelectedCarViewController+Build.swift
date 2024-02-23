//
//  SelectedCarViewController+Build.swift
//  TourApp
//
//  Created by Cagatay Ceker on 16.02.2024.
//

import Foundation
import UIKit

extension SelectedCarViewController {
    static func build(coordinator: SelectedCarInteractorCoordinatorDelegate, carService: CarServiceProtocol, maker: Maker, makerModel: MakerModel, makerModelTrim: MakerModelTrim) -> UIViewController {
        let presenter = SelectedCarPresenter()
        let interactor = SelectedCarInteractor(presenter: presenter, carService: carService, maker: maker, makerModel: makerModel, makerModelTrim: makerModelTrim)
        interactor.coordinator = coordinator
        let viewController = SelectedCarViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
