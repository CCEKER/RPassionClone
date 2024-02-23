//
//  AddCarFlowCoordinatorModule.swift
//  TourApp
//
//  Created by Cagatay Ceker on 12.02.2024.
//

import Foundation
import Swinject
import UIKit

protocol AddCarFlowCoordinatorResolver {
    func resolveSelectCarBrandViewController(delegate: SelectBrandInteractorCoordinatorDelegate) -> UIViewController
    func resolveSelectCarModelViewController(delegate: SelectModelInteractorCoordinatorDelegate, key: String) -> UIViewController
    func resolveSelectCarTrimViewController(delegate: SelectTrimInteractorCoordinatorDelegate, key: String) -> UIViewController
    func resolveSelectedCarViewController(delegate: SelectedCarInteractorCoordinatorDelegate, maker: Maker, makerModel: MakerModel, makerModelTrim: MakerModelTrim) -> UIViewController
}

final class AddCarFlowCoordinatorModule: AddCarFlowCoordinatorResolver {
    
    private let container: Container
    private let resolver: Resolver
    
    init(parentContainer: Container) {
        container = Container(parent: parentContainer)
        _ = Assembler([AddCarFlowCoordinatorAssembly()], container: container)
        
        self.resolver = container
    }
    
    func resolveSelectCarBrandViewController(delegate: SelectBrandInteractorCoordinatorDelegate) -> UIViewController {
        let brandService = resolver.resolve(BrandServiceProtocol.self)!
        return SelectBrandViewController.build(coordinator: delegate, brandService: brandService)
    }
    
    func resolveSelectCarModelViewController(delegate: SelectModelInteractorCoordinatorDelegate, key: String) -> UIViewController {
        let brandService = resolver.resolve(BrandServiceProtocol.self)!
        return SelectModelViewController.build(coordinator: delegate, key: key, brandService: brandService)
    }
    
    func resolveSelectCarTrimViewController(delegate: SelectTrimInteractorCoordinatorDelegate, key: String) -> UIViewController {
        let brandService = resolver.resolve(BrandServiceProtocol.self)!
        return SelectTrimViewController.build(coordinator: delegate, key: key, brandService: brandService)
    }
    func resolveSelectedCarViewController(delegate: SelectedCarInteractorCoordinatorDelegate, maker: Maker, makerModel: MakerModel, makerModelTrim: MakerModelTrim) -> UIViewController {
        let carService = resolver.resolve(CarServiceProtocol.self)!
        return SelectedCarViewController.build(coordinator: delegate, carService: carService, maker: maker, makerModel: makerModel, makerModelTrim: makerModelTrim)
    }
}
