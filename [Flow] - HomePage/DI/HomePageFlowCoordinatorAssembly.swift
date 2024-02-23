//
//  HomePageFlowCoordinatorAssembly.swift
//  TourApp
//
//  Created by Cagatay Ceker on 31.01.2024.
//

import Foundation
import Swinject

final class HomePageFlowCoordinatorAssembly: Assembly {
    func assemble(container: Container) {
        container.register(HomePageServiceProtocol.self) { resolver in
            HomePageService()
        }
    }
}
