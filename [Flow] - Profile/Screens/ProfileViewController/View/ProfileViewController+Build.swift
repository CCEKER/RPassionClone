//
//  ProfileViewController+Build.swift
//  TourApp
//
//  Created by Cagatay Ceker on 26.01.2024.
//

import Foundation
import UIKit

extension ProfileViewController {
    
    static func build(coordinator: ProfileInteractorCoordinatorDelegate, userService: UserServiceProtocol) -> UIViewController {
        let presenter = ProfilePresenter()
        let interactor = ProfileInteractor(presenter: presenter, userService: userService)
        interactor.coordinator = coordinator
        let viewController = ProfileViewController(interactor: interactor)
        viewController.tabBarItem.title = "Profile"
        viewController.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        presenter.viewController = viewController
        return viewController
    }
}
