//
//  LoginFlowCoordinatorAssembly.swift
//  TourApp
//
//  Created by Cagatay Ceker on 31.01.2024.
//

import Foundation
import Swinject

final class LoginFlowCoordinatorAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(LoginServiceProtocol.self) { resolver in
            LoginService()
        }
    }
}
