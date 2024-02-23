//
//  SelectBrandInteractor.swift
//  TourApp
//
//  Created by Cagatay Ceker on 12.02.2024.
//

import Foundation
import UIKit

protocol SelectBrandInteractorProtocol {
    func viewDidLoad()
    func didTapCarMaker(_ index: Int)
}

protocol SelectBrandInteractorCoordinatorDelegate: AnyObject {
    func didTapMaker(maker: Maker)
}

final class SelectBrandInteractor {
    
    private let presenter: SelectBrandPresenterProtocol
    weak var coordinator: SelectBrandInteractorCoordinatorDelegate?
    private let brandService: BrandServiceProtocol
    private var makers: [Maker] = []
    
    init(presenter: SelectBrandPresenterProtocol, brandService: BrandServiceProtocol) {
        self.presenter = presenter
        self.brandService = brandService
    }
}

extension SelectBrandInteractor: SelectBrandInteractorProtocol {
    
    func viewDidLoad() {
        brandService.getMakers{ [weak self] result in
            guard let self else { return }
            
            switch result {
                
            case .success(let makers):
                self.makers = makers
                self.presenter.presentCarMakers(makers)
            
            case .failure:
                print("Error")
            }
        }
    }
    
    func didTapCarMaker(_ index: Int) {
        let maker = makers[index]
        coordinator?.didTapMaker(maker: maker)
    }
}
