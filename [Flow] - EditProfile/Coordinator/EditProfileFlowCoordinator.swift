//
//  EditProfileFlowCoordinator.swift
//  TourApp
//
//  Created by Cagatay Ceker on 2.03.2024.
//

import Foundation
import UIKit

protocol EditProfileFlowCoordinatorProtocol {
    func start()
}

protocol EditProfileFlowCoordinatorDelegate {
    func editProfileFlowDidFinis(user: User)
}

final class EditProfileFlowCoordinator: EditProfileFlowCoordinatorProtocol {
    
    private let window: UIWindow
    private let delegate: EditProfileFlowCoordinatorDelegate
    private var navigationController = UINavigationController()
    private let resolver: EditProfileFlowCoordinatorResolver
    
    init(window: UIWindow, delegate: EditProfileFlowCoordinatorDelegate, resolver: EditProfileFlowCoordinatorResolver) {
        self.window = window
        self.delegate = delegate
        self.resolver = resolver
    }
    
    func start() {
        let editProfileViewController = resolver.resolveEditProfileViewController(delegate: self)
        navigationController.viewControllers = [editProfileViewController]
        self.window.rootViewController = navigationController
    }
}

extension EditProfileFlowCoordinator: EditProfileInteractorCoordinatorDelegate {
    
    func editProfileFlowDidTapSaveButton(user: User) {
        delegate.editProfileFlowDidFinis(user: user)
    }
}
