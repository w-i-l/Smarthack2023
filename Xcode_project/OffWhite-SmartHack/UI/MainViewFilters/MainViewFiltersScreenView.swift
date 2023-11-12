//
//  MainViewFiltersScreenView.swift
//  OffWhite-SmartHack
//
//  Created by Aldea Alexia on 11.11.2023.
//

import SwiftUI

struct MainViewFiltersScreenView: View {
    @StateObject var viewModel: MainViewFiltersViewModel
    @EnvironmentObject private var navigation: Navigation
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [CustomColors.myDarkGray, CustomColors.myBlack]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            switch viewModel.fetchingState {
            case .done:
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        BackButton()
                        
                        Text("Apply additional filters")
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

                            Spacer()
                            
                            Text("Filter by location")
                                .font(Poppins.SemiBold(size: 16))
                                .foregroundColor(CustomColors.myGray)
                                .padding(.bottom, 8)
                                .padding(.top, 32)

                            CustomPickerView<String>(
                                image: "location",
                                itemsList: viewModel.allCountries.map {$0.name},
                                width: UIScreen.main.bounds.width - 100,
                                selection: $viewModel.selectedCountry
                            )
                                
                            
                        }.padding(.all, 12)
                        
                        Text("Filter by the domain of activity        ")
                            .font(Poppins.Bold(size: 16))
                            .foregroundColor(CustomColors.myGray)
                            .padding(.bottom, 8)
                        
                        CustomPickerView<String>(
                            image: "luggage",
                            itemsList: viewModel.allBusinessSectors.map {$0.name},
                            width: UIScreen.main.bounds.width - 100,
                            selection: $viewModel.selectedBusinessSector
                        )
                        
                            Spacer(minLength: 60)
                            
                        }
                    }.padding(.horizontal, 24)
                    
                    Spacer(minLength: 80)
                    
                VStack(spacing: 0) {
                    Spacer(minLength: 24)
                    RoundedButton(text: "Apply Filters") {
                        let destinationVM = CompaniesListViewModel(investment: viewModel.investment,
                                                                   procentInvestment: viewModel.procentInvestment,
                                                                   numberYears: viewModel.numberYears,
                                                                   selectedCountry: viewModel.selectedCountry,
                                                                   selectedBusinessSector: viewModel.selectedBusinessSector)
                        navigation.push(CompaniesListScreenView(viewModel: destinationVM).asDestination(), animated: true)
                    }.padding(.top, 20)
                        .padding(.horizontal, 24)
                        .padding(.bottom, 12)
                    
                    RoundedButton(text: "Skip for now",
                                  style: .outlined) {
                        let destinationVM = CompaniesListViewModel(investment: viewModel.investment,
                                                                   procentInvestment: viewModel.procentInvestment,
                                                                   numberYears: viewModel.numberYears,
                                                                   selectedCountry: viewModel.selectedCountry,
                                                                   selectedBusinessSector: viewModel.selectedBusinessSector)
                        navigation.push(CompaniesListScreenView(viewModel: destinationVM).asDestination(), animated: true)
                    }.padding(.horizontal, 24)
                        .padding(.bottom, 24)
                }
            
            default:
                ProgressView()
                    .progressViewStyle(.circular)
                    .tint(.white)
            }
            
        }.frame(maxWidth: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .leading, .trailing])
    }
}

