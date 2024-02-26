//
//  RegisterFlowCoordinatorAssembly.swift
//  TourApp
//
//  Created by Cagatay Ceker on 27.02.2024.
//

import Foundation
import Swinject

final class RegisterFlowCoordinatorAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(AuthServiceProtocol.self) { resolver in
            AuthService()
        }
    }
}
