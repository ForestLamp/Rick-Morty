//
//  PersonageModel.swift
//  Rick&Morty
//
//  Created by Alex Ch. on 14.04.2022.
//

import Foundation

struct AllData: Decodable {
    let results: [PersonageModel]
}

struct PersonageModel: Decodable {
    
    let id: Int
    let name: String
    let species: String
    let gender: String
    let status: String
    let location: Location
    let image: String
    let episode: [String]
}

// MARK: - Location
    struct Location: Decodable {
        let name: String
    }
