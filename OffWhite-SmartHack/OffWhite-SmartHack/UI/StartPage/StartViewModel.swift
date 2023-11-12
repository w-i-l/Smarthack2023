//
//  StartViewModel.swift
//  OffWhite-SmartHack
//
//  Created by Aldea Alexia on 11.11.2023.
//

import Foundation

class StartViewModel: ObservableObject {
    var userDefaultsService = UserDefaultsService.shared
    
    func getOnboardingStatus() -> Bool {
        return userDefaultsService.getOnboardingStatus()
    }
}
