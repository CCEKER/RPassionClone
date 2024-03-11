//
//  HomePageInteractor.swift
//  TourApp
//
//  Created by Cagatay Ceker on 5.01.2024.
//

import Foundation

protocol HomePageInteractorProtocol {
    func viewDidLoad()
    func didTapTourDetail(_ index: Int)
    func didTapCreateTourButton()
}

protocol HomePageInteractorCoordinatorDelegate: AnyObject {
    func didTapTourDetail(tourId: String)
    func didTapCreateTourButton()
}

final class HomePageInteractor {
    
    private let presenter: HomePagePresenterProtocol
    weak var coordinator: HomePageInteractorCoordinatorDelegate?
    private let homePageService: HomePageServiceProtocol
    private var tourDetailList: HomePageModel?
    
    init(presenter: HomePagePresenterProtocol, homePageService: HomePageServiceProtocol) {
        self.presenter = presenter
        self.homePageService = homePageService
    }
}

extension HomePageInteractor: HomePageInteractorProtocol {
    
    func viewDidLoad() {
        homePageService.homePageService { result in
            switch result {
            case .success(let result):
                self.tourDetailList = result
                self.presenter.presentTourList(result)
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func didTapTourDetail(_ index: Int) {
        guard let tourDetail = tourDetailList?.list[index] else { return }
        coordinator?.didTapTourDetail(tourId: tourDetail.id)
    }
    
    func didTapCreateTourButton() {
        coordinator?.didTapCreateTourButton()
    }
}
