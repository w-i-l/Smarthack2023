//
//  CompanyModel.swift
//  OffWhite-SmartHack
//
//  Created by Mihai Ocnaru on 12.11.2023.
//

import Foundation

struct CompanyModel {
    let businessTags: [String]
    let companyName: String
    let companyType: String
    let companyEmployeesCount: Int
    let revenue: Int
    let facebookUrl: String?
    let instagramUrl: String?
    let linkedinUrl: String?
    let websiteUrl: String?
    let description: String?
    let mainIndustry: String
    let mainCountry: String
    let technologies: [String]
    let yearFounded: Int
    var isPublic: Bool {
        return companyType == "Public"
    }
}
