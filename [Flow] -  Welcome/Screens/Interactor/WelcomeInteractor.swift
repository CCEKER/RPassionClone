//
//  WelcomeInteractor.swift
//  TourApp
//
//  Created by Cagatay Ceker on 26.02.2024.
//

import Foundation

protocol WelcomeInteractorProtocol {
    func viewDidLoad()
    func didTapStartButton()
}

protocol WelcomeInteractorCoordinatorDelegate: AnyObject {
    func welcomeFlowDidTapStartButton()
}

final class WelcomeInteractor {
    
    weak var coordinator: WelcomeInteractorCoordinatorDelegate?
    private let presenter: WelcomePresenterProtocol
    
    init(presenter: WelcomePresenterProtocol) {
        self.presenter = presenter
    }
}

extension WelcomeInteractor: WelcomeInteractorProtocol {
    
    func viewDidLoad() {
        presenter.setupInitialState()
    }
    
    func didTapStartButton() {
        coordinator?.welcomeFlowDidTapStartButton()
    }
}
