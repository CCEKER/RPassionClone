//
//  CreateTourWelcomeViewController.swift
//  TourApp
//
//  Created by Cagatay Ceker on 11.03.2024.
//

import UIKit

protocol CreateTourWelcomeViewControllerProtocol: AnyObject {
    func displayCreateTourWelcomeScreen(_ viewState: CreateTourWelcomeViewState)
}

class CreateTourWelcomeViewController: UIViewController, RPLoadingDisplayable {
    
    private let customView = CreateTourWelcomeView()
    private let interactor: CreateTourWelcomeInteractorProtocol
    
    init(interactor: CreateTourWelcomeInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        customView.startCreateTourButton.addTarget(self, action: #selector(didTapStartCreateTourButton), for: .touchUpInside)
        interactor.viewDidLoad()
    }
    
    @objc private func didTapCloseButton() {
        interactor.didTapCloseButton()
        print("hello")
    }
    
    @objc private func didTapStartCreateTourButton() {
        interactor.didTapStartCreateTourButton()
    }
}

extension CreateTourWelcomeViewController: CreateTourWelcomeViewControllerProtocol {
    
    func displayCreateTourWelcomeScreen(_ viewState: CreateTourWelcomeViewState) {
        switch viewState {
        case .initial(let createTourWelcomeViewModel):
            customView.reloadWith(createTourWelcomeViewModel)
        case .loading:
            hideLoading()
        case .error:
            print("CreateTourError")
        }
    }
}
