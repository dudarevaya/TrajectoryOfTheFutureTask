//
//  DetailScreenViewController.swift
//  VKServices
//
//  Created by Yana Dudareva on 18.02.2023.
//

import UIKit

final class DetailScreenViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var viewModel: Item? {
        didSet {
            bindViewModel()
        }
    }
    
    // MARK: - Constants

    private enum Constants {
        static let nameLabelSize: CGFloat = 30
        static let labelSize: CGFloat = 16
        static let imageViewSize: CGFloat = 80
        static let indent: CGFloat = 20
        static let minusIndent: CGFloat = -20
    }
    
    // MARK: - Outlets
    
    private lazy var nameLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.nameLabelSize)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.labelSize)
        label.numberOfLines = 0
        return label
    }()
    
    private let serviceUrlLabel: LinkTextView = {
        var label = LinkTextView()
        label.font = UIFont.systemFont(ofSize: Constants.indent)
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        var image = UIImageView()
        return image
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        return view
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    // MARK: - Private Methods
    
    private func initialSetup() {
        view.backgroundColor = .white
        
        configureSubviews()
        makeConstraints()
    }
    
    private func bindViewModel() {
        if let vm = viewModel {
            self.navigationItem.title = vm.name
            nameLabel.text = vm.name
            descriptionLabel.text = vm.description
            let link = vm.serviceUrl
            serviceUrlLabel.text = "\(link)"
            serviceUrlLabel.addLinks([link: vm.serviceUrl])
            serviceUrlLabel.onLinkTap = { url in
                return true
            }
            self.imageView.load(url: vm.iconUrl)
        }
    }
    
    private func configureSubviews() {
        view.addSubviews([nameLabel,
                          descriptionLabel,
                          serviceUrlLabel,
                          imageView,
                          activityIndicator
                         ])
    }
    
    private func makeConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                       constant: Constants.indent).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: Constants.imageViewSize).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: Constants.imageViewSize).isActive = true
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor,
                                              constant: Constants.indent).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                  constant: Constants.indent).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                   constant: Constants.minusIndent).isActive = true
        
        serviceUrlLabel.translatesAutoresizingMaskIntoConstraints = false
        serviceUrlLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor,
                                             constant: Constants.indent).isActive = true
        serviceUrlLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                 constant: Constants.indent).isActive = true
    }
}
