//
//  CreateTourInteractor.swift
//  TourApp
//
//  Created by Cagatay Ceker on 11.03.2024.
//

import Foundation

protocol CreateTourInteractorProtocol {
    
}

protocol CreateTourInteractorCoordinatorDelegate: AnyObject {
    
}

final class CreateTourInteractor {
    
    private let presenter: CreateTourPresenterProtocol
    weak var coordinator: CreateTourInteractorCoordinatorDelegate?
    
    init(presenter: CreateTourPresenterProtocol) {
        self.presenter = presenter
    }
}

extension CreateTourInteractor: CreateTourInteractorProtocol {
    
}
