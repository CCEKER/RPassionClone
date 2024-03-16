//
//  LocationDetailViewController.swift
//  TourApp
//
//  Created by Cagatay Ceker on 16.03.2024.
//

import UIKit

protocol LocationDetailViewControllerProtocol: AnyObject {
    func displayViewState(_ viewState: LocationDetailViewState)
}

class LocationDetailViewController: UIViewController {
  
    private let customView = LocationDetailView()
    private let interactor: LocationDetailInteractorProtocol
    
    override func loadView() {
        view = customView
    }
    
    init(interactor: LocationDetailInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor.viewDidLoad()
    }
    
    func didTapTimePickerDoneButton(time: String) {
        
    }
}

extension LocationDetailViewController: LocationDetailViewControllerProtocol {
    
    func displayViewState(_ viewState: LocationDetailViewState) {
        
        switch viewState {
        case .initial(let viewModel):
            customView.reloadWith(viewModel)
        case .loading:
            break
        case .error(let errorViewModel):
            break
        }
    }
}
