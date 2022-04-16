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
    let species: Species
    let gender: Gender
    let status: String
    let location: Location
    let image: String
    let episode: [String]
}
// MARK: - Gender
enum Gender: String, Decodable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
}

// MARK: - Location
    struct Location: Decodable {
        let name: String
    }
// MARK: - Race
enum Species: String, Decodable {
    case alien = "Alien"
    case human = "Human"
}
