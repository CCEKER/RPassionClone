//
//  CoreAssembly.swift
//  TourApp
//
//  Created by Cagatay Ceker on 31.01.2024.
//

import Foundation
import Swinject

final class CoreAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(UserServiceProtocol.self) { _ in
            UserService()
        }.inObjectScope(.container)
    }
}
