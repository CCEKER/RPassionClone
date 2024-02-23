//
//  ApplicationFlowCoordinator.swift
//  TourApp
//
//  Created by Cagatay Ceker on 5.01.2024.
//

import UIKit

protocol ApplicationFlowCoordinatorProtocol {
    func start()
}

final class ApplicationFlowCoordinator: ApplicationFlowCoordinatorProtocol {
    
    private let window: UIWindow
    private var loginFlowCoordinator: LoginFlowCoordinatorProtocol?
    private var dashboardFlowCoordinator: DashboardFlowCoordinatorProtocol?
    private var profileFlowCoordinator: ProfileFlowCoordinatorProtocol?
    private let resolver: ApplicationFlowCoordinatorResolver
   
    init(window: UIWindow, resolver: ApplicationFlowCoordinatorResolver) {
        self.window = window
        self.resolver = resolver
    }
    
    func start() {
        loginFlowCoordinator = resolver.resolveLoginFlowCoordinator(window: window, delegate: self)
        loginFlowCoordinator?.start()
    }
}

extension ApplicationFlowCoordinator: LoginFlowCoordinatorDelegate {
    
    func loginFlowCoordinatorDidFinish() {
       
        dashboardFlowCoordinator = resolver.resolveDashBoardFlowCoordinator(window: window, delegate: self)
        dashboardFlowCoordinator?.start()
        loginFlowCoordinator = nil
    }
}

extension ApplicationFlowCoordinator: DashboardFlowCoordinatorDelegate {
    
    func profileFlowCoordinatorDidFinish() {
    
        loginFlowCoordinator = resolver.resolveLoginFlowCoordinator(window: window, delegate: self)
        loginFlowCoordinator?.start()
        profileFlowCoordinator = nil
    }
    
    func myGarageFlowCoordinatorDidFinish() {
        
    }
}
