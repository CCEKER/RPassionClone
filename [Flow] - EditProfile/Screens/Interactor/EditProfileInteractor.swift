//
//  EditProfileInteractor.swift
//  TourApp
//
//  Created by Cagatay Ceker on 2.03.2024.
//

import Foundation

protocol EditProfileInteractorProtocol {
    func editProfile(firstName: String, dateOfBirth: String, lastName: String, username: String, countrCode: String)
}

protocol EditProfileInteractorCoordinatorDelegate: AnyObject {
    
}

final class EditProfileInteractor {
    
    weak var coordinator: EditProfileInteractorCoordinatorDelegate?
    private let presenter: EditProfilePresenterProtocol
    private var authService: AuthServiceProtocol
    
    init(presenter: EditProfilePresenterProtocol, authService: AuthServiceProtocol) {
        self.presenter = presenter
        self.authService = authService
    }
}

extension EditProfileInteractor: EditProfileInteractorProtocol {
    
    func editProfile(firstName: String, dateOfBirth: String, lastName: String, username: String, countrCode: String) {
        authService.editProfile(firstName: firstName, dateOfBirth: dateOfBirth, lastName: lastName, username: username, countryCode: countrCode) { response in
            switch response {
            case .success(let success):
                
            case .failure(let failure):
                <#code#>
            }
        }
    }
}
