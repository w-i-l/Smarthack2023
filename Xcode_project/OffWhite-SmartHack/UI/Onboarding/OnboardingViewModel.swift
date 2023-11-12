//
//  OnboardingViewModel.swift
//  OffWhite-SmartHack
//
//  Created by Aldea Alexia on 12.11.2023.
//

import Foundation

class OnboardingViewModel: ObservableObject {
    @Published var pageIndex = 0
    var userDefaultsService = UserDefaultsService.shared
}
