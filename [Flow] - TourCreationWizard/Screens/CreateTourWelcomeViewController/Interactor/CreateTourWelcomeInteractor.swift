//
//  CreateTourWelcomeInteractor.swift
//  TourApp
//
//  Created by Cagatay Ceker on 11.03.2024.
//

import Foundation

protocol CreateTourWelcomeInteractorProtocol {
    func viewDidLoad()
    func didTapStartCreateTourButton()
    func didTapCloseButton()
}

protocol CreateTourWelcomeInteractorCoordinatorDelegate: AnyObject {
    func createTourWelcomeInteractorDidTapCloseButton()
    func didTapStartCreateTourButton()
}

final class CreateTourWelcomeInteractor {
    
    private let presenter: CreateTourWelcomePresenterProtocol
    weak var coordinator: CreateTourWelcomeInteractorCoordinatorDelegate?
    
    init(presenter: CreateTourWelcomePresenterProtocol) {
        self.presenter = presenter
    }
}

extension CreateTourWelcomeInteractor: CreateTourWelcomeInteractorProtocol {
    
    func viewDidLoad() {
        presenter.presentCreateTourWelcomeScreen()
    }
    
    func didTapCloseButton() {
        coordinator?.createTourWelcomeInteractorDidTapCloseButton()
    }
    
    func didTapStartCreateTourButton() {
        coordinator?.didTapStartCreateTourButton()
    }
}
