//
//  OnboardingScreenView.swift
//  OffWhite-SmartHack
//
//  Created by Aldea Alexia on 12.11.2023.
//

import SwiftUI

struct OnboardingScreenView: View {
    @StateObject private var viewModel = OnboardingViewModel()
    @State var imageSize: CGSize = CGSize()
    @State var buttonsVstackSize: CGFloat = CGFloat()
    @EnvironmentObject private var navigation: Navigation
    
    init() {
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ZStack() {
                    ScrollView(.horizontal, showsIndicators: false) {
                        TabView(selection: $viewModel.pageIndex) {
                            ForEach(0..<2, id: \.self) { index in
                                if index == 1 {
                                    ZStack {
                                        Image("onboarding2")
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                            .ignoresSafeArea(.container, edges: [.bottom, .leading, .trailing])
                                        
                                        VStack {
                                            Spacer()
                                            RoundedButton(text: "Next") {
                                                viewModel.userDefaultsService.setOnboarding(onboardingIsOver: true)
                                                navigation.replaceNavigationStack([InitialStateScreen().asDestination()], animated: true)
                                            }
                                            .padding(.vertical, 40)
                                            .padding(.horizontal, 24)
                                        }
                                    }
                                } else {
                                    Image("onboarding1")
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        .ignoresSafeArea(.all)
                                }
                            }
                        }.frame(width: UIScreen.main.bounds.width)
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    }.ignoresSafeArea(.all)
                    
                    VStack(spacing: 0) {
                        Spacer()
                        NavSlider(currentStep: $viewModel.pageIndex)
                            .padding([.leading, .bottom], 24)
                    }
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            
        }.frame(maxWidth: .infinity)
            .background(CustomColors.black2)
            .ignoresSafeArea(.container, edges: [.bottom, .leading, .trailing])
    }
}

struct NavSlider: View {
    let steps = 2
    @Binding var currentStep: Int
    
    var body: some View {
        HStack {
            ForEach(0..<steps, id: \.self) { step in
                if step == currentStep {
                    Image(systemName: "circlebadge")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                        .border(.white, width: 2, cornerRadius: 6)
                } else {
                    Image(systemName: "circlebadge.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                        .foregroundColor(.white)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 12)
    }
}
