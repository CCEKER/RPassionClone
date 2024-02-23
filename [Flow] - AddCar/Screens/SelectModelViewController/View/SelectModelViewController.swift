//
//  SelectModelViewController.swift
//  TourApp
//
//  Created by Cagatay Ceker on 12.02.2024.
//

import UIKit

protocol SelectModelViewControllerProtocol: AnyObject {
    func displayViewState(_ viewState: SelectModelViewState)
}

class SelectModelViewController: UIViewController {
    
    private let customView = SelectModelView()
    private let interactor: SelectModelInteractorProtocol
    private var tableData: [SelectModelViewModel] = []
    
    init(interactor: SelectModelInteractorProtocol) {
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
        
        setupTableView()
        configureNavigationBar()
        
        interactor.viewDidLoad()
    }
    
    private func setupTableView() {
        customView.tableView.dataSource = self
        customView.tableView.delegate = self
    }
    
    private func configureNavigationBar() {
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        self.navigationController?.navigationBar.tintColor = .white
        self.title = "Select Model"
    }
}

extension SelectModelViewController: SelectModelViewControllerProtocol {
    
    func displayViewState(_ viewState: SelectModelViewState) {
       switch viewState {
       
       case .list(let modelList):
            self.tableData = modelList
            self.customView.tableView.reloadData()
        
        case .loading:
            customView.tableView.isHidden = true
        
        case .error(let errorViewModel):
            let alert = UIAlertController(title: errorViewModel.title, message: errorViewModel.description, preferredStyle: .alert)
            alert.addAction(.init(title: errorViewModel.cancelButtonTitle, style: .cancel))
            if let actionButtonTitle = errorViewModel.actionButtonTitle {
                alert.addAction(.init(title: actionButtonTitle, style: .default, handler: { _ in
                    print("Error")
                }))
            }
            self.present(alert, animated: true)
        }
    }
}

extension SelectModelViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SelectModelTableViewCell
        let model = tableData[indexPath.row]
        cell.reloadWith(model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor.didTapCarModel(indexPath.row)
    }
}
