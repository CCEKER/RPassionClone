//
//  EditProfileInteractor.swift
//  TourApp
//
//  Created by Cagatay Ceker on 2.03.2024.
//

import Foundation

protocol EditProfileInteractorProtocol {
    func editProfile(firstName: String, dateOfBirth: String, lastName: String, username: String, countrCode: String, instagram: String)
}

protocol EditProfileInteractorCoordinatorDelegate: AnyObject {
    func editProfileFlowDidTapSaveButton()
}

final class EditProfileInteractor {
    
    weak var coordinator: EditProfileInteractorCoordinatorDelegate?
    private let presenter: EditProfilePresenterProtocol
    private var authService: AuthServiceProtocol
    private var userService: UserServiceProtocol
    
    init(presenter: EditProfilePresenterProtocol, authService: AuthServiceProtocol, userService: UserServiceProtocol) {
        self.presenter = presenter
        self.authService = authService
        self.userService = userService
    }
}

extension EditProfileInteractor: EditProfileInteractorProtocol {
    
    func editProfile(firstName: String, dateOfBirth: String, lastName: String, username: String, countrCode: String, instagram: String) {
        authService.editProfile(firstName: firstName, dateOfBirth: dateOfBirth, lastName: lastName, username: username, countryCode: countrCode, instagram: instagram) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    guard let token = self.userService.token else { return }
                    self.userService.updateLoggedInUser(user: response, token: token)
                    self.coordinator?.editProfileFlowDidTapSaveButton()
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
}
