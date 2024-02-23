//
//  SelectModelPresenter.swift
//  TourApp
//
//  Created by Cagatay Ceker on 12.02.2024.
//

import Foundation

protocol SelectModelPresenterProtocol {
    func presentMakerModels(_ makerModel: [MakerModel])
}

final class SelectModelPresenter: SelectModelPresenterProtocol {
    
    weak var viewController: SelectModelViewControllerProtocol?
    
    func presentMakerModels(_ makerModel: [MakerModel]) {
        let viewModels = makerModel.map { makerModel in
            SelectModelViewModel(title: makerModel.title, key: makerModel.key, id: makerModel.id)
        }
        viewController?.displayViewState(.list(viewModels))
    }
}
