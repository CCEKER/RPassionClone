//
//  SelectedCarInteractor.swift
//  TourApp
//
//  Created by Cagatay Ceker on 16.02.2024.
//

import Foundation

protocol SelectedCarInteractorProtocol {
    func viewDidLoad()
    func createCar(nickname: String)
    func didTapMaker()
    func didTapMakerModel()
    func didTapMakerModelTrim()
}

protocol SelectedCarInteractorCoordinatorDelegate: AnyObject {
    func selectedCarInteractorDidCreateCar(createdCar: Car)
    func didTapMaker()
    func didTapMakerModel()
    func didTapMakerModelTrim()
}

final class SelectedCarInteractor {
    
    private let presenter: SelectedCarPresenterProtocol
    private let carService: CarServiceProtocol
    weak var coordinator: SelectedCarInteractorCoordinatorDelegate?
   
    private var nickname: String?
    private var maker: Maker
    private var makerModel: MakerModel
    private var makerModelTrim: MakerModelTrim
    
    init(presenter: SelectedCarPresenterProtocol, carService: CarServiceProtocol, maker: Maker, makerModel: MakerModel, makerModelTrim: MakerModelTrim) {
        self.presenter = presenter
        self.carService = carService
        self.maker = maker
        self.makerModel = makerModel
        self.makerModelTrim = makerModelTrim
    }
}

extension SelectedCarInteractor: SelectedCarInteractorProtocol {
    
    func createCar(nickname: String) {
        
        carService.createCar(trimId: makerModelTrim.id, nickname: nickname) { [weak self] result in
            guard let self else { return }
            
            switch result {
            
            case .success(let response):
                coordinator?.selectedCarInteractorDidCreateCar(createdCar: response)
               

            case .failure(let error):
                print("Errorrr: \(error)")
            }
        }
    }
    
    func viewDidLoad() {
       
        presenter.presentSelectedCar(maker: maker, makerModel: makerModel, makerModelTrim: makerModelTrim)
    }
    
    func didTapMaker() {
        coordinator?.didTapMaker()
    }
    
    func didTapMakerModel() {
        coordinator?.didTapMakerModel()
    }
    
    func didTapMakerModelTrim() {
        coordinator?.didTapMakerModelTrim()
    }
}
