//
//  CreateTourInteractor.swift
//  TourApp
//
//  Created by Cagatay Ceker on 11.03.2024.
//

import Foundation

protocol CreateTourInteractorProtocol {
    func viewDidLoad()
    func createTour(title: String, description: String)
}

protocol CreateTourInteractorCoordinatorDelegate: AnyObject {
    func didTapCreateTourButton(tourId: String)
}

final class CreateTourInteractor {
    
    private let presenter: CreateTourPresenterProtocol
    weak var coordinator: CreateTourInteractorCoordinatorDelegate?
    private let tourService: TourServiceProtocol
    
    init(presenter: CreateTourPresenterProtocol, tourService: TourServiceProtocol) {
        self.presenter = presenter
        self.tourService = tourService
    }
}

extension CreateTourInteractor: CreateTourInteractorProtocol {
    
    func viewDidLoad() {
        presenter.presentCreateTourScreen()
    }
    
    func createTour(title: String, description: String) {
        
        tourService.createTour(title: title, description: description, tourType: 1) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    print(response.id)
                    
                case .failure:
                    print("error")
                }
            }
        }
    }
}
