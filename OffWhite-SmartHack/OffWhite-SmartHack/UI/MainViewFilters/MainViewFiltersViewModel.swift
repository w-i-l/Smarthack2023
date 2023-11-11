//
//  MainViewFiltersViewModel.swift
//  OffWhite-SmartHack
//
//  Created by Aldea Alexia on 11.11.2023.
//

import Foundation

class MainViewFiltersViewModel: ObservableObject {
    @Published var selectedCountry: String = "Romania"
    @Published var areaOfActivity: String = "IT"
    @Published var investment: String
    @Published var procentInvestment: String
    @Published var numberYears: String

    init(investment: String, procentInvestment: String, numberYears: String) {
        self.investment = investment
        self.procentInvestment = procentInvestment
        self.numberYears = numberYears
    }
}
