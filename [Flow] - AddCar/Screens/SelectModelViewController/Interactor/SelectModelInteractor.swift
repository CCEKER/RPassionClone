//
//  SelectModelInteractor.swift
//  TourApp
//
//  Created by Cagatay Ceker on 12.02.2024.
//

import Foundation

protocol SelectModelInteractorProtocol {
    func viewDidLoad()
    func didTapCarModel(_ index: Int)
}

protocol SelectModelInteractorCoordinatorDelegate: AnyObject {
    func didTapMakerModel(makerModel: MakerModel)
}

final class SelectModelInteractor {
    
    private let presenter: SelectModelPresenterProtocol
    weak var coordinator: SelectModelInteractorCoordinatorDelegate?
    private var key: String
    private let brandService: BrandServiceProtocol
    private var makerModels: [MakerModel] = []
    
    init(presenter: SelectModelPresenterProtocol, key: String, brandService: BrandServiceProtocol) {
        self.presenter = presenter
        self.key = key
        self.brandService = brandService
    }
}

extension SelectModelInteractor: SelectModelInteractorProtocol {
    
    func viewDidLoad() {
        brandService.getMakerModels(key: key) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let makerModel):
                self.makerModels = makerModel
                self.presenter.presentMakerModels(makerModel)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func didTapCarModel(_ index: Int) {
        let makerModel = makerModels[index]
        coordinator?.didTapMakerModel(makerModel: makerModel)
    }
}
