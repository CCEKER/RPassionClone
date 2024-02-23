//
//  ProfileInteractor.swift
//  TourApp
//
//  Created by Cagatay Ceker on 26.01.2024.
//

import Foundation
import UIKit

protocol ProfileInteractorProtocol {
    func fethUserProfile()
    func didTapLogoutButton()
}

protocol ProfileInteractorCoordinatorDelegate: AnyObject {
    func profileInteractorDidTapLogoutButton()
}

final class ProfileInteractor {
    
    private let presenter: ProfilePresenterProtocol
    weak var coordinator: ProfileInteractorCoordinatorDelegate?
    private let userService: UserServiceProtocol

    init(presenter: ProfilePresenterProtocol, userService: UserServiceProtocol) {
        self.presenter = presenter
        self.userService = userService
    }
}

extension ProfileInteractor: ProfileInteractorProtocol {
    
    func fethUserProfile() {
        guard let user = userService.user else {
            return
        }
        presenter.presentProfile(user)
    }
   
    func didTapLogoutButton() {
        coordinator?.profileInteractorDidTapLogoutButton()
    }
}
