//
//  CatsSource.swift
//  DogImages
//
//  Created by Александр Кузьминов on 30.08.23.
//

import Foundation


struct WelcomeElement: Codable {
    let id: String
    let width, height: Int
    let url: String
    let breeds: [Breed]
}

// MARK: - Breed
struct Breed: Codable {
    let weight: Weight
    let id, name, temperament, origin: String
    let countryCodes, countryCode, lifeSpan: String
    let wikipediaURL: String

    enum CodingKeys: String, CodingKey {
        case weight, id, name, temperament, origin
        case countryCodes = "country_codes"
        case countryCode = "country_code"
        case lifeSpan = "life_span"
        case wikipediaURL = "wikipedia_url"
    }
}

// MARK: - Weight
struct Weight: Codable {
    let imperial, metric: String
}
