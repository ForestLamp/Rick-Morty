//
//  NetworkManager.swift
//  Rick&Morty
//
//  Created by Alex Ch. on 14.04.2022.
//

import Foundation

class NetworkManager {
    
    private let baseURL = "https://rickandmortyapi.com/api/character/"
    
    func fetchData(completion: @escaping (Result<AllData?, Error>)-> Void) {
        guard let url = URL(string: baseURL) else {return}
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Ошибка запроса: \(error)")
            }
            guard let data = data else {return}
            do {
                let json = try JSONDecoder().decode(AllData.self, from: data)
                completion(.success(json))
            } catch let error {
                print("Ошибка парсинга: \(error)")
            }
        }.resume()
    }
}
