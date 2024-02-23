//
//  AddCarFlowCoordinator.swift
//  TourApp
//
//  Created by Cagatay Ceker on 12.02.2024.
//

import Foundation
import UIKit

protocol AddCarFlowCoordinatorProtocol {
    func start()
}

protocol AddCarFlowCoordinatorDelegate {
    func addCarFlowCoordinatorDidFinish(createdCar: Car)
}

struct AddCarFlowCoordinatorDataStore {
    var maker: Maker?
    var makerModel: MakerModel?
    var makerModelTrim: MakerModelTrim?
}

final class AddCarFlowCoordinator: AddCarFlowCoordinatorProtocol {
    
    private let delegate: AddCarFlowCoordinatorDelegate
    private var resolver: AddCarFlowCoordinatorResolver
    private let presentingViewController: UINavigationController
    private var dataStore = AddCarFlowCoordinatorDataStore()
    
    
    init(delegate: AddCarFlowCoordinatorDelegate, resolver: AddCarFlowCoordinatorResolver, presentingViewController: UINavigationController) {
        self.delegate = delegate
        self.resolver = resolver
        self.presentingViewController = presentingViewController
    }
    
    func start() {
        let selectBrandViewController = resolver.resolveSelectCarBrandViewController(delegate: self)
        presentingViewController.pushViewController(selectBrandViewController, animated: true)
    }
}

extension AddCarFlowCoordinator: SelectBrandInteractorCoordinatorDelegate {
    func didTapMaker(maker: Maker) {
        self.dataStore.maker = maker
        let selectModelViewController = resolver.resolveSelectCarModelViewController(delegate: self, key: maker.key)
        presentingViewController.pushViewController(selectModelViewController, animated: true)
    }
}

extension AddCarFlowCoordinator: SelectModelInteractorCoordinatorDelegate {
    
    func didTapMakerModel(makerModel: MakerModel) {
        self.dataStore.makerModel = makerModel
        let selectTrimViewController = resolver.resolveSelectCarTrimViewController(delegate: self, key: makerModel.key)
        presentingViewController.pushViewController(selectTrimViewController, animated: true)
    }
}

extension AddCarFlowCoordinator: SelectTrimInteractorCoordinatorDelegate {
    
    func didTapMakerModelTrim(makerModelTrim: MakerModelTrim) {
        self.dataStore.makerModelTrim = makerModelTrim
        
        guard let maker = dataStore.maker, let makerModel = dataStore.makerModel, let makerModelTrim = dataStore.makerModelTrim else {
            return
        }
        let selectedCarViewController = resolver.resolveSelectedCarViewController(delegate: self, maker: maker, makerModel: makerModel, makerModelTrim: makerModelTrim)
        presentingViewController.pushViewController(selectedCarViewController, animated: true)
    }
}

extension AddCarFlowCoordinator: SelectedCarInteractorCoordinatorDelegate {
    
    func didTapMakerModelTrim() {
        let viewControllers = presentingViewController.viewControllers
        for viewController in viewControllers {
            if viewController is SelectTrimViewController {
                presentingViewController.popToViewController(viewController, animated: true)
            }
        }
    }
    
    func didTapMakerModel() {
        let viewControllers = presentingViewController.viewControllers
        for viewController in viewControllers {
            if viewController is SelectModelViewController {
                presentingViewController.popToViewController(viewController, animated: true)
            }
        }
    }
    
    func didTapMaker() {
        let viewControllers = presentingViewController.viewControllers
        for viewController in viewControllers {
            if viewController is SelectBrandViewController {
                presentingViewController.popToViewController(viewController, animated: true)
            }
        }
    }

    func selectedCarInteractorDidCreateCar(createdCar: Car) {
        delegate.addCarFlowCoordinatorDidFinish(createdCar: createdCar)
    }
}



