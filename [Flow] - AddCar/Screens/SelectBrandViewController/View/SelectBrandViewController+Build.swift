//
//  AddCarViewController+Build.swift
//  TourApp
//
//  Created by Cagatay Ceker on 12.02.2024.
//

import Foundation
import UIKit

extension SelectBrandViewController {
    static func build(coordinator: SelectBrandInteractorCoordinatorDelegate, brandService: BrandServiceProtocol) -> UIViewController {
        let presenter = SelectBrandPresenter()
        let interactor = SelectBrandInteractor(presenter: presenter, brandService: brandService)
        interactor.coordinator = coordinator
        let viewController = SelectBrandViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
