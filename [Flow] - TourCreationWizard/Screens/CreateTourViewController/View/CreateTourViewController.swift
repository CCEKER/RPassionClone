//
//  CreateTourViewController.swift
//  TourApp
//
//  Created by Cagatay Ceker on 11.03.2024.
//

import UIKit

protocol CreateTourViewControllerProtocol: AnyObject {
    
}

class CreateTourViewController: UIViewController {
    
    private let interactor: CreateTourInteractorProtocol
    private let customView = CreateTourView()
    
    override func loadView() {
        view = customView
    }
    
    init(interactor: CreateTourInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension CreateTourViewController: CreateTourViewControllerProtocol {
    
}
