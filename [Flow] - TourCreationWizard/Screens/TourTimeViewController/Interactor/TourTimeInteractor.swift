//
//  TourTimeInteractor.swift
//  TourApp
//
//  Created by Cagatay Ceker on 13.03.2024.
//

import Foundation

protocol TourTimeInteractorProtocol {
    func didTapDatePickerDoneButton(date: String)
    func viewDidLoad()
    func decrementDay()
    func incrementDay()
    func didTapContinueButton()
}

protocol TourTimeInteractorCoordinatorDelegate: AnyObject {
    func tourTimeInteractorDidTapContinueButton(tourId: String)
}

final class TourTimeInteractor {
    
    enum Constant {
        static let minimumDayCount = 1
        static let maximumDayCount = 7
    }
    
    private let presenter: TourTimePresenterProtocol
    weak var coordinator: TourTimeInteractorCoordinatorDelegate?
    private let tourService: TourServiceProtocol
    private let tourId: String
    private var count = Constant.minimumDayCount
    
    init(presenter: TourTimePresenterProtocol, tourId: String, tourService: TourServiceProtocol) {
        self.presenter = presenter
        self.tourId = tourId
        self.tourService = tourService
    }
}
extension TourTimeInteractor: TourTimeInteractorProtocol {
    
    func didTapDatePickerDoneButton(date: String) {
        
        tourService.startDay(startDay: date, tourId: tourId) { _ in
        }
    }
    
    func decrementDay() {
        if count > Constant.minimumDayCount {
            count -= 1
        }
        if count < Constant.maximumDayCount && count > Constant.minimumDayCount {
            presenter.presentUpdateDay(count, isMinusButtonActive: true, isPlusButtonActive: true)
        } else {
            presenter.presentUpdateDay(count, isMinusButtonActive: false, isPlusButtonActive: true)
        }
    }
    
    func incrementDay() {
        
        if count < Constant.maximumDayCount {
            count += 1
        }
        if count > Constant.minimumDayCount && count < Constant.maximumDayCount {
            presenter.presentUpdateDay(count, isMinusButtonActive: true, isPlusButtonActive: true)
        } else {
            presenter.presentUpdateDay(count, isMinusButtonActive: true, isPlusButtonActive: false)
        }
    }
    
    func viewDidLoad() {
        presenter.presentUpdateDay(count, isMinusButtonActive: false, isPlusButtonActive: true)
    }
    
    func didTapContinueButton() {
        let group = DispatchGroup()
        
		for _ in 0..<count {
			group.enter()
		}
		
        for _ in 0..<count {
			tourService.createTourDay(tourId: tourId) { _ in
				group.leave()
			}
        }
		
        group.notify(queue: .main) {
            self.coordinator?.tourTimeInteractorDidTapContinueButton(tourId: self.tourId)
        }
    }
}
