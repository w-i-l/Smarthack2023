//
//  CountriesService.swift
//  OffWhite-SmartHack
//
//  Created by Mihai Ocnaru on 12.11.2023.
//

import Foundation
import Combine

class CountriesService: BaseViewModel<Any> {
    static let shared = CountriesService()
    
    private override init() {}
    
    public func getAllCountries() -> AnyPublisher<[CountryModel], Error> {
        return CountriesAPI.shared.getAllCountries()
            .eraseToAnyPublisher()
    }
}
