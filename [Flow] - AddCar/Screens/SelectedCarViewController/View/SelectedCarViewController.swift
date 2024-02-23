//
//  SelectedCarViewController.swift
//  TourApp
//
//  Created by Cagatay Ceker on 16.02.2024.
//

import UIKit

protocol SelectedCarViewControllerProtocol: AnyObject {
    func displayViewState(_ viewState: SelectedCarViewState)
}

class SelectedCarViewController: UIViewController {
    
    private let customView = SelectedCarView()
    private let interactor: SelectedCarInteractorProtocol
    
    init(interactor: SelectedCarInteractorProtocol) {
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
        
        configureNavigationBar()
        
        customView.saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        
        customView.makerHolderView.didTapClear = {
            self.interactor.didTapMaker()
        }
        
        customView.makerModelHolderView.didTapClear = {
            self.interactor.didTapMakerModel()
        }
        
        customView.makerModelTrimHolderView.didTapClear = {
            self.interactor.didTapMakerModelTrim()
        }
    
        interactor.viewDidLoad()
    }
        
    @objc private func didTapSaveButton() {
        
        guard let nickname = customView.nickNameTextField.text, !nickname.isEmpty else {
            return
        }
        
        interactor.createCar(nickname: nickname)
    }

    private func configureNavigationBar() {
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        self.title = "Selected Car"
    }
}

extension SelectedCarViewController: SelectedCarViewControllerProtocol {
    
    func displayViewState(_ viewState: SelectedCarViewState) {
        
        switch viewState {
        
        case .initial(let selectedCarViewModel):
            customView.reloadWith(selectedCarViewModel)
       
        case .loading:
            break
        
        case .error(let errorViewModel):
            let alert = UIAlertController(title: errorViewModel.title, message: errorViewModel.description, preferredStyle: .alert)
            alert.addAction(.init(title: errorViewModel.cancelButtonTitle, style: .cancel))
            if let actionButtonTitle = errorViewModel.actionButtonTitle {
                alert.addAction(.init(title: actionButtonTitle, style: .default, handler: { _ in
                    print("error")
                }))
            }
            self.present(alert, animated: true)
        }
    }
}
