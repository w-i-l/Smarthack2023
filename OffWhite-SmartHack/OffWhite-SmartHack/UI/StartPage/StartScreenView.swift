//
//  StartScreenView.swift
//  OffWhite-SmartHack
//
//  Created by Aldea Alexia on 11.11.2023.
//

import SwiftUI
//import Firebase

struct StartScreenView: View {
    @ObservedObject var viewModel = StartViewModel()
    
    var body: some View {
//        if viewModel.isLoggedIn() {
            InitialStateScreen()
//        } else {
//            if viewModel.getOnboardingStatus() {
//                LogInScreenView()
//            } else {
//                OnBoardingScreenView()
//            }
//        }
    }
}
