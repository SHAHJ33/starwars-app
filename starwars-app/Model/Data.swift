//
//  Data.swift
//  starwars-app
//
//  Created by ShahJee on 18/10/2023.
//

import Foundation

struct Root {
    let name: String
    let url: String
}

struct RootResult: Codable {
    var people: String
    var planets: String
    var films: String
    var species: String
    var vehicles: String
    var starships: String
}

struct PeopleResult: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: Array<People>?
}

struct FilmsResult: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: Array<Film>?
}

struct PlanetsResult: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Planet]?
}

struct SpeciesResult: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Species]?
}

struct StarshipsResult: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Starship]?
}

struct VehiclesResult: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Vehicle]?
}

struct People: Codable {
    let name, height, mass, hairColor: String?
    let skinColor, eyeColor, birthYear, gender: String?
    let homeworld: String?
    let films, species, vehicles, starships: Array<String>?
    let created, edited: String?
    let url: String?
}

struct Film: Codable {
    let title: String?
    let episode_id: Int
    let opening_crawl, director, producer, release_date: String?
    let characters, planets, starships, vehicles, species: [String]?
    let created, edited: String?
    let url: String?
}

struct Planet: Codable {
    let name: String?
}

struct Species: Codable {
    let name: String?
}

struct Vehicle: Codable {
    let name: String?
}

struct Starship: Codable {
    let name: String?
}

