//
//  MyGarageInteractor.swift
//  TourApp
//
//  Created by Cagatay Ceker on 12.02.2024.
//

import Foundation

protocol MyGarageInteractorProtocol {
    func viewDidLoad()
    func didTapAddCarButton()
    func addNewCarToList(_ newCar: Car)
}

protocol MyGarageInteractorCoordinatorDelegate: AnyObject {
    func didTapAddCarButton()
    func myGarageFlowDidFinish()
}

final class MyGarageInteractor {
    
    private let presenter: MyGaragePresenterProtocol
    weak var coordinator: MyGarageInteractorCoordinatorDelegate?
    private let carService: CarServiceProtocol
    private let userId: String
    private var cars: [Car] = []
    
    init(presenter: MyGaragePresenterProtocol, carService: CarServiceProtocol, userId: String) {
        self.presenter = presenter
        self.carService = carService
        self.userId = userId
    }
}

extension MyGarageInteractor: MyGarageInteractorProtocol {
    
    func viewDidLoad() {
        presenter.presentLoading()
        carService.getCarList(userId: userId) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let list):
                self.cars = list
                self.presenter.presentList(cars: list)
            case .failure:
                self.presenter.presentError()
            }
        }
    }
    
    func addNewCarToList(_ newCar: Car) {
        cars.insert(newCar, at: 0)
        presenter.presentList(cars: cars)
    }
    
    func didTapAddCarButton() {
        coordinator?.didTapAddCarButton()
    }
}
