//
//  TourTimeViewController.swift
//  TourApp
//
//  Created by Cagatay Ceker on 13.03.2024.
//

import UIKit

protocol TourTimeViewControllerProtocol: AnyObject {
    func displayViewModel(_ viewModel: TourTimeViewModel)
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

        customView.minusButton.addTarget(self, action: #selector(didTapMinusButton), for: .touchUpInside)
        customView.plusButton.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
        
        interactor.viewDidLoad()
    }
    
    @objc private func didTapMinusButton() {
        interactor.decrementDay()
    }
    
    @objc private func didTapPlusButton() {
        interactor.incrementDay()
    }
    
    func didTapDatePickerDoneButton(date: String) {
        interactor.didTapDatePickerDoneButton(date: date)
    }
}

extension TourTimeViewController: TourTimeViewControllerProtocol {
    
    func displayViewModel(_ viewModel: TourTimeViewModel) {
        customView.reloadWith(viewModel)
        self.title = viewModel.navigationTitle
    }
}
