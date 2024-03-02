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
    private var verificationFlowCoordinator: VerificationCodeFlowCoordinatorProtocol?
    private var editProfileFlowCoordinator: EditProfileFlowCoordinatorProtocol?
    private let resolver: ApplicationFlowCoordinatorResolver
    private let userService: UserServiceProtocol
   
    init(window: UIWindow, resolver: ApplicationFlowCoordinatorResolver, userService: UserServiceProtocol) {
        self.window = window
        self.resolver = resolver
        self.userService = userService
    }
    
    func start() {
        
        if userService.user != nil {
            dashboardFlowCoordinator = resolver.resolveDashBoardFlowCoordinator(window: self.window, delegate: self)
            dashboardFlowCoordinator?.start()
        } else {
            welcomeFlowCoordinator = resolver.resolveWelcomeFlowCoordinator(window: self.window, delegate: self)
            welcomeFlowCoordinator?.start()
        }
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
    
    func verificationCodeFlowDidFinish() {
        editProfileFlowCoordinator = resolver.resolveEditProfileFlowCoordinator(window: self.window, delegate: self)
        editProfileFlowCoordinator?.start()
        verificationFlowCoordinator = nil
        registerFlowCoordinator = nil
    }
    
    func registerFlowCoordinatorDidFinish() {
        loginFlowCoordinator = resolver.resolveLoginFlowCoordinator(window: self.window, delegate: self)
        loginFlowCoordinator?.start()
        registerFlowCoordinator = nil
    }
}

extension ApplicationFlowCoordinator: DashboardFlowCoordinatorDelegate {
    
    func profileFlowCoordinatorDidFinish() {
        
        
        loginFlowCoordinator = resolver.resolveLoginFlowCoordinator(window: window, delegate: self)
        loginFlowCoordinator?.start()
        userService.logout()
        profileFlowCoordinator = nil
    }
    
    func garageFlowCoordinatorDidFinish() {
        dashboardFlowCoordinator = resolver.resolveDashBoardFlowCoordinator(window: window, delegate: self)
        dashboardFlowCoordinator?.start()
        garageFlowCoordinator = nil
    }
}

extension ApplicationFlowCoordinator: EditProfileFlowCoordinatorDelegate {
    
    func editProfileFlowDidFinis(user: User) {
        guard let token = userService.token else { return }
        self.userService.updateLoggedInUser(user: user, token: token)
        dashboardFlowCoordinator = resolver.resolveDashBoardFlowCoordinator(window: self.window, delegate: self)
        dashboardFlowCoordinator?.start()
        editProfileFlowCoordinator = nil
    }
}
