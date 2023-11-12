//
//  CompaniesListViewModel.swift
//  OffWhite-SmartHack
//
//  Created by Aldea Alexia on 11.11.2023.
//

import Foundation

class CompaniesListViewModel: BaseViewModel<Any> {
    @Published var investment: String
    @Published var procentInvestment: String
    @Published var numberYears: String
    @Published var selectedCountry: String
    @Published var selectedBusinessSector: String
    
    @Published var fetchingState: FetchingState = .loading
    @Published var allCompanies: [CompanyModel] = []
    
    init(investment: String, procentInvestment: String, numberYears: String, selectedCountry: String, selectedBusinessSector: String) {
      
        
        self.investment = investment
        self.procentInvestment = procentInvestment
        self.numberYears = numberYears
        self.selectedCountry = selectedCountry
        self.selectedBusinessSector = selectedBusinessSector
        super.init()
        
        CompaniesAPI.shared.getAllCompanies(activityDomain: [selectedBusinessSector], location: selectedCountry)
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: { [weak self] companies in
                self?.fetchingState = .done
                self?.allCompanies = companies
            }
            .store(in: &self.bag)
        
    }
}
