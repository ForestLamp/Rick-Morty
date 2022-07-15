//
//  NetworkManager.swift
//  Rick&Morty
//
//  Created by Alex Ch. on 14.04.2022.
//

import Foundation

    // MARK: - Protocol

protocol NetworkManagerDelegate: class {
    func showData(results: [PersonageModel])
    func showError()
}

final class NetworkManager {
    
    private let api = Api()
    weak var delegate: NetworkManagerDelegate?
    
    // MARK: - Methods
    
    func fetchData(url: String) {
        api.decodeData(url: url) { (result) in
            switch result {
            case .success(let personage):
                DispatchQueue.main.async {
                    self.delegate?.showData(results: personage?.results ?? [])
                }
            case .failure(_):
                self.delegate?.showError()
            }
        }
    }
}
