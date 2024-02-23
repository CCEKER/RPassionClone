//
//  ParticipantsInteractor.swift
//  TourApp
//
//  Created by Cagatay Ceker on 20.02.2024.
//

import Foundation

protocol ParticipantsInteractorProtocol {
    func viewDidLoad()
}

protocol ParticipantsInteractorCoordinatorDelegate: AnyObject {
    
}

final class ParticipantsInteractor {
    
    weak var coordinator: ParticipantsInteractorCoordinatorDelegate?
    private let presenter: ParticipantsPresenterProtocol
    private let tourService: TourDetailServiceProtocol
    private var tourId: String
    private var participantsLimit: Int
    private var participantsJoined: Int
    
    
    init(presenter: ParticipantsPresenterProtocol, tourService: TourDetailServiceProtocol, tourId: String, participantsLimit: Int, participantsJoined: Int) {
        self.presenter = presenter
        self.tourService = tourService
        self.tourId = tourId
        self.participantsLimit = participantsLimit
        self.participantsJoined = participantsJoined
    }
}

extension ParticipantsInteractor: ParticipantsInteractorProtocol {
    
    func viewDidLoad() {
        tourService.getParticipants(tourId: tourId) { [weak self] result in
            switch result {
            case .success(let response):
                self?.presenter.presentParticipants(response, participantsLimit: self?.participantsLimit ?? 5, participantsJoined: self?.participantsJoined ?? 5)
                
            case .failure(let error):
                print("Interactor Error: \(error)")
            }
        }
    }
}
