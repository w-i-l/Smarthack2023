//
//  CompaniesListViewModel.swift
//  OffWhite-SmartHack
//
//  Created by Aldea Alexia on 11.11.2023.
//

import Foundation

class CompaniesListViewModel: ObservableObject {
    @Published var investment: String
    @Published var procentInvestment: String
    @Published var numberYears: String
    @Published var selectedCountry: String
    @Published var areaOfActivity: String
    
    init(investment: String, procentInvestment: String, numberYears: String, selectedCountry: String, areaOfActivity: String) {
        self.investment = investment
        self.procentInvestment = procentInvestment
        self.numberYears = numberYears
        self.selectedCountry = selectedCountry
        self.areaOfActivity = areaOfActivity
    }
}
