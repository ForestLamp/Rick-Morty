//
//  NetworkManager.swift
//  Rick&Morty
//
//  Created by Alex Ch. on 14.04.2022.
//

import Foundation

final class NetworkManager {
    
    func fetchData(url: String, completion: @escaping (Result<AllData?, Error>)-> Void) {
        guard let url = URL(string: url) else {return}
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
