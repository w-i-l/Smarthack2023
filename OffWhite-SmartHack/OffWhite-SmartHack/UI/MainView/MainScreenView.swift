//
//  MainScreenView.swift
//  OffWhite-SmartHack
//
//  Created by Aldea Alexia on 11.11.2023.
//

import SwiftUI

struct MainScreenView: View {
    @StateObject var viewModel = MainViewModel()
    @EnvironmentObject private var navigation: Navigation
    @FocusState private var isInvestmentFocused: Bool
    @FocusState private var isProcentFocused: Bool
    @FocusState private var isNbYearsFocused: Bool
    @State var isKeyboardVisible = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [CustomColors.myDarkGray, CustomColors.myBlack]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 12) {
                HStack(spacing: 0) {
                    BackButton()
                    
                    Text("Apply main parameters")
                        .font(Poppins.Bold(size: 24))
                        .foregroundColor(CustomColors.myGray)
                        .padding(.leading, 8)
                    
                    Spacer()
                }.padding(.top, 16)
                    .padding(.bottom, 12)
                    .padding(.horizontal, 24)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(CustomColors.myNude)
                    .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Grow your assets")
                            .font(Poppins.Bold(size: 16))
                            .foregroundColor(CustomColors.myGray)
                            .padding(.bottom, 8)
                            .padding(.top, 32)
                        
                        HStack(spacing: 0) {
                            Image("dollar")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 24)
                                .foregroundColor(.black)
                                .padding(.trailing, 6)
                            
                            TextField("", text: $viewModel.investment)
                                .foregroundColor(CustomColors.myGray)
                                .font(Poppins.Regular(size: 12))
                                .placeholder(when: viewModel.investment.isEmpty) {
                                    Text("Enter the amount you want to invest")
                                        .foregroundColor(CustomColors.myGray)
                                        .font(Poppins.Regular(size: 12))
                                }
                            
                        }.padding(.all, 12)
                            .focused($isInvestmentFocused)
                            .border(isInvestmentFocused ? CustomColors.myNude : CustomColors.myGray, width: 1)
                            .cornerRadius(3, corners: .allCorners)
                        
                        if !viewModel.errorMessage.isEmpty && viewModel.investment.isEmpty {
                            Text(viewModel.errorMessage)
                                .foregroundColor(CustomColors.myError)
                                .font(Poppins.Regular(size: 12))
                                .padding(.top, 4)
                        }
                        
                        Text("Go for more")
                            .font(Poppins.Bold(size: 16))
                            .foregroundColor(CustomColors.myGray)
                            .padding(.top, 20)
                            .padding(.bottom, 8)
                        
                        HStack(spacing: 0) {
                            Image("discount")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 24)
                                .foregroundColor(.black)
                                .padding(.trailing, 6)
                            
                            TextField("", text: $viewModel.procentInvestment)
                                .foregroundColor(CustomColors.myGray)
                                .font(Poppins.Regular(size: 12))
                                .placeholder(when: viewModel.procentInvestment.isEmpty) {
                                    Text("Enter the return of investment you expect")
                                        .foregroundColor(CustomColors.myGray)
                                        .font(Poppins.Regular(size: 12))
                                }
                            
                        }.padding(.all, 12)
                            .focused($isProcentFocused)
                            .border(isProcentFocused ? CustomColors.myNude : CustomColors.myGray, width: 1)
                            .cornerRadius(3, corners: .allCorners)
                        
                        if !viewModel.errorMessage.isEmpty && viewModel.procentInvestment.isEmpty {
                            Text(viewModel.errorMessage)
                                .foregroundColor(CustomColors.myError)
                                .font(Poppins.Regular(size: 12))
                                .padding(.top, 4)
                        }
                        
                        Text("Worth the wait")
                            .font(Poppins.Bold(size: 16))
                            .foregroundColor(CustomColors.myGray)
                            .padding(.top, 20)
                            .padding(.bottom, 8)
                        
                        HStack(spacing: 0) {
                            Image("chart")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 24)
                                .foregroundColor(.black)
                                .padding(.trailing, 6)
                            
                            TextField("Enter the timeframe of your investment", text: $viewModel.numberYears)
                                .foregroundColor(CustomColors.myGray)
                                .font(Poppins.Regular(size: 12))
                                .placeholder(when: viewModel.numberYears.isEmpty) {
                                    Text("Enter the timeframe of your investment")
                                        .foregroundColor(CustomColors.myGray)
                                        .font(Poppins.Regular(size: 12))
                                }
                            
                        }.padding(.all, 12)
                            .focused($isNbYearsFocused)
                            .border(isNbYearsFocused ? CustomColors.myNude : CustomColors.myGray, width: 1)
                            .cornerRadius(3, corners: .allCorners)
                        
                        if !viewModel.errorMessage.isEmpty && viewModel.numberYears.isEmpty {
                            Text(viewModel.errorMessage)
                                .foregroundColor(CustomColors.myError)
                                .font(Poppins.Regular(size: 12))
                                .padding(.top, 4)
                        }
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Toggle(isOn: $viewModel.isBestMatchOn) {
                                Text("Find best match")
                                    .foregroundColor(CustomColors.myGray)
                                    .font(Poppins.Regular(size: 16))
                                
                            }
                            .toggleStyle(CheckboxToggleStyle())
                            .padding(.top, 20)
                            
                            if !viewModel.errorMessage.isEmpty && !viewModel.isBestMatchOn {
                                Text("This field is required")
                                    .foregroundColor(CustomColors.myError)
                                    .font(Poppins.Regular(size: 12))
                                    .padding(.top, 4)
                            }
                        }
                    }
                }.padding(.horizontal, 24)
                
                Spacer(minLength: 80)
            }
            
            VStack(spacing: 0) {
                Spacer(minLength: 24)
                RoundedButton(text: "Next",
                              loading: viewModel.isLoading) {
                    if viewModel.validateFields() {
                        let destinationVM = MainViewFiltersViewModel(investment: viewModel.investment,
                                                                     procentInvestment: viewModel.procentInvestment,
                                                                     numberYears: viewModel.numberYears)
                        navigation.push(MainViewFiltersScreenView(viewModel: destinationVM).asDestination(), animated: true)
                    }
                }.padding(.horizontal, 24)
                    .padding(.bottom, 24)
            }
        }.frame(maxWidth: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .leading, .trailing])
    }
}

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(configuration.isOn ? "toggle_on" : "toggle")
                .resizable()
                .frame(width: 40, height: 32)
                .onTapGesture { configuration.isOn.toggle() }
            configuration.label
        }
    }
}
