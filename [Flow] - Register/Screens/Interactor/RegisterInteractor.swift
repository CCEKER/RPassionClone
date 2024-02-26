//
//  RegisterInteractor.swift
//  TourApp
//
//  Created by Cagatay Ceker on 27.02.2024.
//

import Foundation

protocol RegisterInteractorProtocol {
    
}

protocol RegisterInteractorCoordinatorDelegate: AnyObject {
    
}

final class RegisterInteractor {
    
    weak var coordinator: RegisterInteractorCoordinatorDelegate?
    private let presenter: RegisterPresenterProtocol
    private let authService: AuthServiceProtocol
    
    init(presenter: RegisterPresenterProtocol, authService: AuthServiceProtocol) {
        self.presenter = presenter
        self.authService = authService
    }
}

extension RegisterInteractor: RegisterInteractorProtocol {
    
}
