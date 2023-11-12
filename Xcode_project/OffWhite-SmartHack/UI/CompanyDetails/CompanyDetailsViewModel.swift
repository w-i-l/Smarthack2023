//
//  CompanyDetailsViewModel.swift
//  OffWhite-SmartHack
//
//  Created by Aldea Alexia on 12.11.2023.
//

import Foundation

class CompanyDetailsViewModel: ObservableObject {
    @Published var company: CompanyModel
    let stockPrice: Float
    
    init(company: CompanyModel, stockPrice: Float) {
        self.company = company
        self.stockPrice = stockPrice
    }
}
