//
//  SelectBrandPresenter.swift
//  TourApp
//
//  Created by Cagatay Ceker on 12.02.2024.
//

import Foundation

protocol SelectBrandPresenterProtocol {
    func presentCarMakers(_ maker: [Maker])
}

final class SelectBrandPresenter: SelectBrandPresenterProtocol {
    
    weak var viewController: SelectBrandViewControllerProtocol?
    
    func presentCarMakers(_ maker: [Maker]) {
        let viewModels = maker.map { maker in
            return SelectionTableViewCellModel(id: maker.id, title: maker.title, image: maker.image, key: maker.key)
        }
        viewController?.displayViewState(.list(viewModels))
    }
}
