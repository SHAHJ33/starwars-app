//
//  NetworkManager.swift
//  starwars-app
//
//  Created by ShahJee on 18/10/2023.
//

import Foundation

typealias OnError = (String) -> Void
typealias OnRootSuccess = (RootResult) -> Void
typealias OnPeopleSuccess = (PeopleResult) -> Void
typealias OnFilmsSuccess = (FilmsResult) -> Void
typealias OnStarshipsSuccess = (StarshipsResult) -> Void
typealias OnVehiclesSuccess = (VehiclesResult) -> Void
typealias OnSpeciesSuccess = (SpeciesResult) -> Void
typealias OnPlanetsSuccess = (PlanetsResult) -> Void

typealias OnSuccess = (Codable) -> Void
typealias OnFailure = (Error) -> Void

protocol NetworkManagerDelegate {
    func didReceivePeopleResult(_ networkManager: NetworkManager, peopleResult: PeopleResult)
    func didFailWithError(error: Error)
}

class NetworkManager {
    
    static let instance = NetworkManager()
    
    var delegate: NetworkManagerDelegate?
    
    let BASE_URL = "https://swapi.dev/api/"
    let PEOPLE_URL = "people/"
    let FILMS_URL = "films/"
    let STARSHIPS_URL = "starships/"
    let VEHICLES_URL = "vehicles/"
    let SPECIES_URL = "species/"
    let PLANETS_URL = "planets/"
    
    let session = URLSession(configuration: .default)
    
    func getRootList(onSuccess: @escaping OnRootSuccess, onError: @escaping OnError) {
        if let url = URL(string: "\(BASE_URL)") {
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    onError(error.localizedDescription)
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    onError("Invalid data or response.")
                    return
                }
                
                do {
                    if response.statusCode == 200 {
                        let root = try JSONDecoder().decode(RootResult.self, from: data)
                        onSuccess(root)
                    } else {
                        onError("ERROR Response -> \(response.statusCode)")
                    }
                } catch {
                    onError(error.localizedDescription)
                }
            }
            task.resume()
        }
    }
    
    func getPeopleList(onSuccess: @escaping OnPeopleSuccess, onError: @escaping OnError) {
        if let url = URL(string: "\(BASE_URL)\(PEOPLE_URL)") {
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    onError(error.localizedDescription)
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    onError("Invalid data or response.")
                    return
                }
                
                do {
                    if response.statusCode == 200 {
                        let result = try JSONDecoder().decode(PeopleResult.self, from: data)
                        onSuccess(result)
                    } else {
                        onError("ERROR Response -> \(response.statusCode)")
                    }
                } catch {
                    debugPrint(error)
                    onError(error.localizedDescription)
                }
            }
            task.resume()
        }
    }
    
    func getFilmsList(onSuccess: @escaping OnFilmsSuccess, onError: @escaping OnError) {
        if let url = URL(string: "\(BASE_URL)\(FILMS_URL)") {
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    onError(error.localizedDescription)
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    onError("Invalid data or response.")
                    return
                }
                
                do {
                    if response.statusCode == 200 {
                        let result = try JSONDecoder().decode(FilmsResult.self, from: data)
                        onSuccess(result)
                    } else {
                        onError("ERROR Response -> \(response.statusCode)")
                    }
                } catch {
                    debugPrint(error)
                    onError(error.localizedDescription)
                }
            }
            task.resume()
        }
    }
}
