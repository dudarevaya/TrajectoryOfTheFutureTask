//
//  ListScreenViewController.swift
//  VKServices
//
//  Created by Yana Dudareva on 18.02.2023.
//

import UIKit

protocol NetworkManagerProtocolOutput: AnyObject {
    func error(title: String, message: String)
}

final class ListScreenViewController: UIViewController {

    // MARK: - Private Properties
    
    private var viewModel: ListScreenViewModelProtocol?
    private var networkManager = NetworkManager.shared
    
    // MARK: - Constants

    private enum Constants {
        static let heightForRowAt: CGFloat = 60
        static let vkProjects = NSLocalizedString("vkProjects", comment: "")
        static let ok = NSLocalizedString("ok", comment: "")
    }
    
    // MARK: - TableView
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ListScreenCell.self,
                           forCellReuseIdentifier: ListScreenCell.identifier)
        return tableView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        var refreshControl = UIRefreshControl()
        refreshControl.addTarget(self,
                                 action: #selector(refreshControlAction(_:)),
                                 for: UIControl.Event.valueChanged
        )
        return refreshControl
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
    }
    
    // MARK: - Private Methods
    
    private func initialSetup() {
        view.backgroundColor = .white
        networkManager.output = self
        
        setTableView()
        setNavigationBar()
        configureSubviews()
        makeConstraints()
        setData()
    }
    
    private func setData() {
        viewModel = ListScreenViewModel()
        
        viewModel?.getData() {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = Constants.vkProjects
    }
    
    private func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
    
    private func configureSubviews() {
        view.addSubview(tableView)
        tableView.addSubview(refreshControl)
    }
    
    private func makeConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    // MARK: - Actions
    
    @objc func refreshControlAction(_ refreshControl: UIRefreshControl) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            refreshControl.endRefreshing()
        }
    }
}

// MARK: - UITableViewDataSource

extension ListScreenViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.count() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: ListScreenCell.identifier
        ) as? ListScreenCell {
            cell.viewModel = viewModel?.services(at: indexPath.row)
            cell.accessoryType = .disclosureIndicator
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.heightForRowAt
    }
}

// MARK: - UITableViewDelegate

extension ListScreenViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let _ = tableView.cellForRow(at: indexPath) as? ListScreenCell {
            let vc = DetailScreenViewController()
            vc.viewModel = viewModel?.services(at: indexPath.row)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: - NetworkManagerProtocolOutput

extension ListScreenViewController: NetworkManagerProtocolOutput {
    
    func error(title: String, message: String) {
        DispatchQueue.main.async {
            let dialogMessage = UIAlertController(title: title,
                                                  message: message,
                                                  preferredStyle: .alert
            )
            let ok = UIAlertAction(title: Constants.ok,
                                   style: .default,
                                   handler: nil
            )
            dialogMessage.addAction(ok)
            self.present(dialogMessage, animated: true, completion: nil)
        }
    }
}
