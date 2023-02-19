//
//  NetworkManager.swift
//  VKServices
//
//  Created by Yana Dudareva on 18.02.2023.
//

import Foundation

final class NetworkManager {
    
    // MARK: - Public Properties
    
    static let shared = NetworkManager()
    var servicesArray = [Item]()
    weak var output: NetworkManagerProtocolOutput!
    
    // MARK: - Constants

    private enum Constants {
        static let url = NSLocalizedString("url", comment: "")
        static let failedDecode = NSLocalizedString("failedDecode", comment: "")
        static let checkJSON = NSLocalizedString("checkJSON", comment: "")
        static let error = NSLocalizedString("error", comment: "")
    }
    
    // MARK: - Private Methods
    
    private func performRequest(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                completion(.success(data))
        }.resume()
    }
    
    // MARK: - Public Methods
    
    func fetchData(completion: @escaping () -> Void) {
        let url = Constants.url
        performRequest(urlString: url) { [self] (result) in
            switch result {
            case .success(let data):
                do {
                    let servicesData = try JSONDecoder().decode(VKServicesModel.self, from: data)
                    servicesArray = servicesData.items
                    completion()
                }
                catch let error {
                    print(Constants.failedDecode, error)
                    self.output?.error(title: Constants.failedDecode, message: Constants.checkJSON)
                }
            case .failure(let error):
                self.output?.error(title: Constants.error, message: "\(error.localizedDescription)")
                print(Constants.error, error.localizedDescription)
            }
        }
    }
}
