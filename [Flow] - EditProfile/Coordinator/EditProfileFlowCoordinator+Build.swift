//
//  EditProfileFlowCoordinator+Build.swift
//  TourApp
//
//  Created by Cagatay Ceker on 2.03.2024.
//

import Foundation
import Swinject

extension EditProfileFlowCoordinator {
    static func build(window: UIWindow, delegate: EditProfileFlowCoordinatorDelegate, container: Container) -> EditProfileFlowCoordinatorProtocol {
        let module = EditProfileFlowCoordinatorModule(parentContainer: container)
        return EditProfileFlowCoordinator(window: window, delegate: delegate, resolver: module)
    }
}
