//
//  MainViewFiltersViewModel.swift
//  OffWhite-SmartHack
//
//  Created by Aldea Alexia on 11.11.2023.
//

import Foundation

enum FetchingState {
    case loading
    case done
    case error
}

class MainViewFiltersViewModel: BaseViewModel<Any> {
    @Published var selectedCountry: String = "Romania"
    @Published var selectedBusinessSector: String = "IT"
    @Published var investment: String
    @Published var procentInvestment: String
    @Published var numberYears: String
    
    @Published var allCountries: [CountryModel] = []
    @Published var allBusinessSectors: [BusinessSectorModel] = []
    
    @Published var fetchingState: FetchingState = .loading

    init(investment: String, procentInvestment: String, numberYears: String) {
        
        
        self.investment = investment
        self.procentInvestment = procentInvestment
        self.numberYears = numberYears

        super.init()
        
        CountriesService.shared.getAllCountries()
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: { [weak self] countries in
                self?.allCountries = countries
                if let first = countries.first {
                    self?.selectedCountry = first.name
                    if self?.fetchingState == .loading && self?.allBusinessSectors != [] {
                        self?.fetchingState = .done
                    }
                }
            }
            .store(in: &self.bag)
        
        BusinessSectorService.shared.getAllBusniessSectors()
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: { [weak self] sectors in
                print(sectors)
                self?.allBusinessSectors = sectors
                if let first = sectors.first {
                    self?.selectedBusinessSector = first.name
                    if self?.fetchingState == .loading && self?.allCountries != [] {
                        self?.fetchingState = .done
                    }
                }
            }
            .store(in: &self.bag)

    }
}
