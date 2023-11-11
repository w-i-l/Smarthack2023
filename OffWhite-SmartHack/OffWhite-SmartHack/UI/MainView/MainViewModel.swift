//
//  MainScreenViewModel.swift
//  OffWhite-SmartHack
//
//  Created by Aldea Alexia on 11.11.2023.
//

import Foundation
import SwiftUI
import Combine

class MainViewModel: BaseViewModel<DefaultViewModelEvent> {
    @Published var investment: String = ""
    @Published var procentInvestment: String = ""
    @Published var numberYears: String = ""
    @Published var errorMessage: String = ""
    @Published var isBestMatchOn: Bool = false
    
    override init() {
        
        super.init()
        
        CountriesAPI.shared.getAllCountries()
            .eraseToAnyPublisher()
            .sink { _ in
                
            } receiveValue: { value in
                print(value)
            }
            .store(in: &bag)

    }
    
    func validateFields() -> Bool {
        if self.investment.isEmpty || self.procentInvestment.isEmpty || self.numberYears.isEmpty {
            self.errorMessage = "This field is mandatory!"
            return false
        }
        return true 
    }
}
