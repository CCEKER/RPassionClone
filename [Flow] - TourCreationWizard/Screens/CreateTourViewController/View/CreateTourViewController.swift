//
//  CreateTourViewController.swift
//  TourApp
//
//  Created by Cagatay Ceker on 11.03.2024.
//

import UIKit

protocol CreateTourViewControllerProtocol: AnyObject {
    func displayViewState(_ viewState: CreateTourViewState)
}

class CreateTourViewController: UIViewController, RPLoadingDisplayable {
    
    private let interactor: CreateTourInteractorProtocol
    private let customView = CreateTourView()
    
    override func loadView() {
        view = customView
    }
    
    init(interactor: CreateTourInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.continueButton.addTarget(self, action: #selector(didTapContinueButton), for: .touchUpInside)
        
        interactor.viewDidLoad()
    }
    
    @objc private func didTapContinueButton() {
        guard let tourName = customView.tourNameTextField.text, !tourName.isEmpty else { return }
        guard let tourDescription = customView.tourDescriptionTextView.text else { return }
        
        interactor.createTour(title: tourName, description: tourDescription)
    }
}

extension CreateTourViewController: CreateTourViewControllerProtocol {
    
    func displayViewState(_ viewState: CreateTourViewState) {
        
        switch viewState {
        
        case .initial(let viewModel):
            customView.reloadWith(viewModel)
            self.title = viewModel.navigationTitle
        
        case .loading:
            showLoading(viewModel: .init(caption: "Loading..."))
        
        case .error(let errorViewModel):
            let alert = UIAlertController(title: errorViewModel.title, message: errorViewModel.description, preferredStyle: .alert)
            alert.addAction(.init(title: errorViewModel.cancelButtonTitle, style: .cancel))
            if let actionButtonTitle = errorViewModel.actionButtonTitle {
                alert.addAction(.init(title: actionButtonTitle, style: .default, handler: { _ in
                    print("error")
                }))
            }
            self.present(alert, animated: true)
        }
    }
}
