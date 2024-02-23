//
//  SelectModelViewController+Build.swift
//  TourApp
//
//  Created by Cagatay Ceker on 12.02.2024.
//

import Foundation
import UIKit

extension SelectModelViewController {
    static func build(coordinator: SelectModelInteractorCoordinatorDelegate, key: String, brandService: BrandServiceProtocol) -> UIViewController {
        let presenter = SelectModelPresenter()
        let interactor = SelectModelInteractor(presenter: presenter, key: key, brandService: brandService)
        interactor.coordinator = coordinator
        let viewController = SelectModelViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
