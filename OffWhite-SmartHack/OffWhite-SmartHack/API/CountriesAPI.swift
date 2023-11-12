//
//  CountriesAPI.swift
//  OffWhite-SmartHack
//
//  Created by Mihai Ocnaru on 11.11.2023.
//

import Foundation
import SwiftyJSON
import Combine

let PORT: String = "8000"

class CountriesAPI {
    
    static let shared = CountriesAPI()
    
    private init() {}
    
    public func getAllCountries() -> Future<[CountryModel], Error> {
        Future<[CountryModel], Error> { promise in
            
            
            var urlComponents = URLComponents(string: "http://127.0.0.1:\(PORT)/api/v1/get_all_countries")
            urlComponents?.queryItems = [
            ]
            
            var urlRequest = URLRequest(url: urlComponents!.url!)
            urlRequest.httpMethod = "GET"
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                guard error == nil else { return }
                guard let data else { return }
                
                do {
                    
                    let json = try JSON(data: data)
                    let data = json["countries"].arrayValue[0]
                    let countries = data.map { CountryModel(name: $0.1.stringValue)}
                    
                    promise(.success(countries))
                    
                } catch(let error) {
                    print(error)
                    promise(.failure(error))
                }
                
            }
            
            dataTask.resume()
        }
    }
}
