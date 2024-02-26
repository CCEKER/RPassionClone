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
    private var welcomeFlowCoordinator: WelcomeFlowCoordinatorProtocol?
    private var loginFlowCoordinator: LoginFlowCoordinatorProtocol?
    private var dashboardFlowCoordinator: DashboardFlowCoordinatorProtocol?
    private var profileFlowCoordinator: ProfileFlowCoordinatorProtocol?
    private var garageFlowCoordinator: GarageFlowCoordinatorProtocol?
    private var registerFlowCoordinator: RegisterFlowCoordinatorProtocol?
    private let resolver: ApplicationFlowCoordinatorResolver
   
    init(window: UIWindow, resolver: ApplicationFlowCoordinatorResolver) {
        self.window = window
        self.resolver = resolver
    }
    
    func start() {
        welcomeFlowCoordinator = resolver.resolveWelcomeFlowCoordinator(window: self.window, delegate: self)
        welcomeFlowCoordinator?.start()
    }
}

extension ApplicationFlowCoordinator: WelcomeFlowCoordinatorDelegate {
    
    func welcomeFlowCoordinatorDidFinish() {
        loginFlowCoordinator = resolver.resolveLoginFlowCoordinator(window: self.window, delegate: self)
        loginFlowCoordinator?.start()
        welcomeFlowCoordinator = nil
    }
}

extension ApplicationFlowCoordinator: LoginFlowCoordinatorDelegate {
    
    func loginFlowDidTapRegister() {
        registerFlowCoordinator = resolver.resolveRegisterFlowCoordinator(window: self.window, delegate: self)
        registerFlowCoordinator?.start()
        loginFlowCoordinator = nil
    }

    func loginFlowCoordinatorDidFinish() {
       
        dashboardFlowCoordinator = resolver.resolveDashBoardFlowCoordinator(window: window, delegate: self)
        dashboardFlowCoordinator?.start()
        loginFlowCoordinator = nil
    }
}

extension ApplicationFlowCoordinator: RegisterFlowCoordinatorDelegate {
    
}

extension ApplicationFlowCoordinator: DashboardFlowCoordinatorDelegate {
    
    func profileFlowCoordinatorDidFinish() {
    
        loginFlowCoordinator = resolver.resolveLoginFlowCoordinator(window: window, delegate: self)
        loginFlowCoordinator?.start()
        profileFlowCoordinator = nil
    }
    
    func garageFlowCoordinatorDidFinish() {
        dashboardFlowCoordinator = resolver.resolveDashBoardFlowCoordinator(window: window, delegate: self)
        dashboardFlowCoordinator?.start()
        garageFlowCoordinator = nil
    }
}
