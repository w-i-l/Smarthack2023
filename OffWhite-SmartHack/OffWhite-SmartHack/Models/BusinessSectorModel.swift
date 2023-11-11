//
//  BusinessSector.swift
//  OffWhite-SmartHack
//
//  Created by Mihai Ocnaru on 12.11.2023.
//

import Foundation

struct BusinessSectorModel {
    let name: String
}

extension BusinessSectorModel: Equatable {
    static func ==(_ lhs: BusinessSectorModel, _ rhs: BusinessSectorModel) -> Bool {
        return lhs.name == rhs.name
    }
}
