//
//  UserService.swift
//  OffWhite-SmartHack
//
//  Created by Aldea Alexia on 11.11.2023.
//

import Foundation
import Combine

class UserService: ObservableObject {
    
    private var userDefaultsService = UserDefaultsService.shared
    static let shared = UserService()
    
    private init() { }
}
