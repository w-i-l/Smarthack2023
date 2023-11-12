//
//  CompanyDetailsViewModel.swift
//  OffWhite-SmartHack
//
//  Created by Aldea Alexia on 12.11.2023.
//

import Foundation

class CompanyDetailsViewModel: ObservableObject {
    @Published var companyName: String
    @Published var revenue: String
    @Published var stackPrice: String
    @Published var number: Double
    
    init(companyName: String, revenue: String, stackPrice: String, number: Double) {
        self.companyName = companyName
        self.revenue = revenue
        self.stackPrice = stackPrice
        self.number = number
    }
}
