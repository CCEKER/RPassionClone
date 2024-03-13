//
//  TourTimeViewController.swift
//  TourApp
//
//  Created by Cagatay Ceker on 13.03.2024.
//

import UIKit

protocol TourTimeViewControllerProtocol: AnyObject {
    
}

class TourTimeViewController: UIViewController, TourTimeViewProtocol {
  
    private let customView = TourTimeView()
    private let interactor: TourTimeInteractorProtocol
    
    init(interactor: TourTimeInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        customView.delegate = self
    }
    
    func didTapDatePickerDoneButton(date: String) {
        interactor.didTapDatePickerDoneButton(date: date)
    }
}

extension TourTimeViewController: TourTimeViewControllerProtocol {
    
}
