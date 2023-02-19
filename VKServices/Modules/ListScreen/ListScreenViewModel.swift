//
//  ListScreenViewModel.swift
//  VKServices
//
//  Created by Yana Dudareva on 18.02.2023.
//

import UIKit

protocol ListScreenViewModelProtocol {
    func getData(completion: @escaping () -> Void)
    func count() -> Int
    func services(at index: Int) -> Item
}

final class ListScreenViewModel: ListScreenViewModelProtocol {
    
    // MARK: - Private Properties

    private let networkManager = NetworkManager.shared
    private var servicesArray: [Item] = []
    
    // MARK: - Public Methods
    
    func getData(completion: @escaping () -> Void) {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        networkManager.fetchData() { [weak self] in
            self?.servicesArray = self?.networkManager.servicesArray ?? [Item]()
            dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main) {
            completion()
        }
    }
    
    func count() -> Int {
        return servicesArray.count
    }
    
    func services(at index: Int) -> Item {
        return servicesArray[index]
    }
}
