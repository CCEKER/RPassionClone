//
//  SelectBrandViewController.swift
//  TourApp
//
//  Created by Cagatay Ceker on 12.02.2024.
//

import UIKit

protocol SelectBrandViewControllerProtocol: AnyObject {
    func displayViewState(_ viewState: SelectBrandViewState)
}

class SelectBrandViewController: UIViewController {
    
    private let customView = SelectBrandView()
    private let interactor: SelectBrandInteractorProtocol
    private var tableData: [SelectionTableViewCellModel] = []
    
    init(interactor: SelectBrandInteractorProtocol) {
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
        setupTableView()
        
        interactor.viewDidLoad()
    }
    
    private func configureNavigationBar() {
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        self.title = "Select Brand"
    }
    
    private func setupTableView() {
        customView.tableView.dataSource = self
        customView.tableView.delegate = self
    }
}

extension SelectBrandViewController: SelectBrandViewControllerProtocol {
    
    func displayViewState(_ viewState: SelectBrandViewState) {
        switch viewState {
        case .list(let brandList):
            self.tableData = brandList
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

extension SelectBrandViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SelectionsTableViewCell
        let carModel = tableData[indexPath.row]
        cell.reloadWith(carBrand: carModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor.didTapCarMaker(indexPath.row)
    }
}
