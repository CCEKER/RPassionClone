//
//  MapViewController.swift
//  TourApp
//
//  Created by Cagatay Ceker on 16.03.2024.
//

import UIKit

protocol MapViewControllerProtocol: AnyObject {
    func displayViewState(_ viewState: MapViewState)
}

class MapViewController: UIViewController {
    private let customView = MapView()
    private let interactor: MapInteractorProtocol
    
    init(interactor: MapInteractorProtocol) {
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
        
        customView.checkAddressButton.addTarget(self, action: #selector(didTapCheckAddressButton), for: .touchUpInside)
        interactor.viewDidLoad()
    }
    
    @objc private func didTapCheckAddressButton() {
        
        guard let latitude = customView.centerCoordinate?.coordinate.latitude else { return }
        guard let longitude = customView.centerCoordinate?.coordinate.longitude else { return }
        interactor.didTapCheckAddressButton(latitude: latitude, longitude: longitude)
    }
}

extension MapViewController: MapViewControllerProtocol {
    
    func displayViewState(_ viewState: MapViewState) {
        switch viewState {
        case .inital(let mapViewModel):
            self.title = mapViewModel.navigationTitle
            self.customView.checkAddressButton.setTitle(mapViewModel.checkAddressButtonTitle, for: .normal)
        case .loading:
            break
        case .error(let errorViewModel):
            break
        }
    }
}
