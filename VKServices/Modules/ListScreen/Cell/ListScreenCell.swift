//
//  ListScreenCell.swift
//  VKServices
//
//  Created by Yana Dudareva on 18.02.2023.
//

import UIKit

class ListScreenCell: UITableViewCell {
    
    // MARK: - Public Properties
    
    var viewModel: Item? {
        didSet {
            bindViewModel()
        }
    }
    
    // MARK: - Constants

    private enum Constants {
        static let labelSize: CGFloat = 16
        static let cornerRadius: CGFloat = 10
        static let imageViewSize: CGFloat = 40
        static let indent: CGFloat = 10
    }
    
    // MARK: - Outlets
    
    private lazy var name: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.labelSize)
        return label
    }()
    
    private lazy var image: UIImageView = {
        var image = UIImageView()
        image.backgroundColor = .systemGray4
        image.layer.cornerRadius = Constants.cornerRadius
        return image
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        image.image = nil
    }
    
    // MARK: - Private Methods
    
    private func bindViewModel() {
        if let vm = viewModel {
            self.name.text = vm.name
            self.image.load(url: vm.iconUrl)
        }
    }
    
    private func setupViews() {
        contentView.addSubview(image)
        contentView.addSubview(name)
    }
    
    private func setupConstraints() {
        image.translatesAutoresizingMaskIntoConstraints = false
        image.leadingAnchor.constraint(equalTo: leadingAnchor,
                                       constant: Constants.indent).isActive = true
        image.topAnchor.constraint(equalTo: topAnchor,
                                   constant: Constants.indent ).isActive = true
        image.heightAnchor.constraint(equalToConstant: Constants.imageViewSize).isActive = true
        image.widthAnchor.constraint(equalToConstant: Constants.imageViewSize).isActive = true
        
        name.translatesAutoresizingMaskIntoConstraints = false
        name.leadingAnchor.constraint(equalTo: image.trailingAnchor,
                                      constant: Constants.indent).isActive = true
        name.centerYAnchor.constraint(equalTo: image.centerYAnchor).isActive = true
    }
}
