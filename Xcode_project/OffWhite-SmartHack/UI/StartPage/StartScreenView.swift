//
//  StartScreenView.swift
//  OffWhite-SmartHack
//
//  Created by Aldea Alexia on 11.11.2023.
//

import SwiftUI

struct StartScreenView: View {
    @ObservedObject var viewModel = StartViewModel()
    
    var body: some View {
        if viewModel.getOnboardingStatus() {
            InitialStateScreen()
        } else {
            OnboardingScreenView()
        }
    }
}
