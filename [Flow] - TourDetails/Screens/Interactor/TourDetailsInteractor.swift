//
//  TourDetailsInteractor.swift
//  TourApp
//
//  Created by Cagatay Ceker on 8.02.2024.
//

import Foundation

protocol TourDetailsInteractorProtocol {
    func viewDidLoad()
    func didTapParticipants()
}

protocol TourDetailsInteractorCoordinatorDelegate: AnyObject {
    func didTapParticipant(tourId: String, participantsLimit: Int, participantsJoined: Int)
}

final class TourDetailsInteractor {
    
    private let presenter: TourDetailsPresenterProtocol
    weak var coordinator: TourDetailsInteractorCoordinatorDelegate?
    private let tourDetailService: TourDetailServiceProtocol
    private let tourId: String
    private var tourDetailModel: TourDetailModel?
    
    init(presenter: TourDetailsPresenterProtocol, tourDetailService: TourDetailServiceProtocol, tourId: String) {
        self.presenter = presenter
        self.tourDetailService = tourDetailService
        self.tourId = tourId
    }
}

extension TourDetailsInteractor: TourDetailsInteractorProtocol {
    
    func viewDidLoad() {
        
        tourDetailService.getTourDetail(tourId: tourId) { result in
            switch result {
            case .success(let response):
                self.tourDetailModel = response
                self.presenter.presentTourDetail(response)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func didTapParticipants() {
        guard let tourDetailModel = tourDetailModel else { return }
        coordinator?.didTapParticipant(tourId: tourDetailModel.id, participantsLimit: tourDetailModel.participantsLimit, participantsJoined: tourDetailModel.participantsJoined)
    }
}
