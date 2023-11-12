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
    
    init(companyName: String, revenue: String, stackPrice: String) {
        self.companyName = companyName
        self.revenue = revenue
        self.stackPrice = stackPrice
    }
}
