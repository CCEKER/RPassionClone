//
//  WelcomeViewController.swift
//  TourApp
//
//  Created by Cagatay Ceker on 26.02.2024.
//

import UIKit

protocol WelcomeViewControllerProtocol: AnyObject {
    func displayViewState(_ viewState: WelcomeViewState)
}

class WelcomeViewController: UIViewController {
    
    private let customView = WelcomeView()
    private let interactor: WelcomeInteractorProtocol
    
    init(interactor: WelcomeInteractorProtocol) {
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
        
        customView.startButton.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
        interactor.viewDidLoad()
    }
    
    @objc private func didTapStartButton() {
        interactor.didTapStartButton()
    }
}

extension WelcomeViewController: WelcomeViewControllerProtocol {
    func displayViewState(_ viewState: WelcomeViewState) {
        
        switch viewState {
        
        case .initial:
            break
        
        case .loading:
            break
        
        case .error:
            break
        }
    }
}
