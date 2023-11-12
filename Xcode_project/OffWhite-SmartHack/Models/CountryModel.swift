//
//  CountryModel.swift
//  OffWhite-SmartHack
//
//  Created by Mihai Ocnaru on 11.11.2023.
//

import Foundation

struct CountryModel {
    let name: String
}

extension CountryModel: Equatable {
    static func ==(_ lhs: CountryModel, _ rhs: CountryModel) -> Bool {
        return lhs.name == rhs.name
    }
}
