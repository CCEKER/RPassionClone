//
//  SelectTrimInteractor.swift
//  TourApp
//
//  Created by Cagatay Ceker on 16.02.2024.
//

import Foundation

protocol SelectTrimInteractorProtocol {
    func viewDidLoad()
    func didTapMakerModelTrim(_ index: Int)
}

protocol SelectTrimInteractorCoordinatorDelegate: AnyObject {
    func didTapMakerModelTrim(makerModelTrim: MakerModelTrim)
}

final class SelectTrimInteractor {
    
    private let presenter: SelectTrimPresenterProtocol
    weak var coordinator: SelectTrimInteractorCoordinatorDelegate?
    private let key: String
    private let brandService: BrandServiceProtocol
    private var makerModelTrims: [MakerModelTrim] = []
    
    init(presenter: SelectTrimPresenterProtocol, key: String, brandService: BrandServiceProtocol) {
        self.presenter = presenter
        self.key = key
        self.brandService = brandService
    }
}

extension SelectTrimInteractor: SelectTrimInteractorProtocol {
    
    func viewDidLoad() {
        brandService.getMakerModelTrims(key: key) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let makerModelTrim):
                self.makerModelTrims = makerModelTrim
                self.presenter.presentMakerModelTrim(makerModelTrim)
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func didTapMakerModelTrim(_ index: Int) {
        let selectedTrim = makerModelTrims[index]
        coordinator?.didTapMakerModelTrim(makerModelTrim: selectedTrim)
    }
}
