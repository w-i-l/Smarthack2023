//
//  MainScreenViewModel.swift
//  OffWhite-SmartHack
//
//  Created by Aldea Alexia on 11.11.2023.
//

import Foundation
import SwiftUI

class MainViewModel: BaseViewModel<DefaultViewModelEvent>, ObservableObject {
    @Published var investment: String = ""
    @Published var procentInvestment: String = ""
    @Published var numberYears: String = ""
    @Published var errorMessage: String = ""
    @Published var isBestMatchOn: Bool = false
    
    func validateFields() -> Bool {
        if self.investment.isEmpty || self.procentInvestment.isEmpty || self.numberYears.isEmpty {
            self.errorMessage = "This field is mandatory!"
            return false
        }
        return true 
    }
}
