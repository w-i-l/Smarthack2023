//
//  CompaniesListScreenView.swift
//  OffWhite-SmartHack
//
//  Created by Aldea Alexia on 11.11.2023.
//

import SwiftUI

struct CompaniesListScreenView: View {
    @StateObject var viewModel: CompaniesListViewModel
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [CustomColors.myDarkGray, CustomColors.myBlack]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Best Match Companies")
                    .font(Poppins.Bold(size: 28))
                    .foregroundColor(CustomColors.myGray)
                    .padding(.top, 16)
                    .padding(.bottom, 20)
                
                HStack(spacing: 8) {
                    AssociateRectangleView(name: viewModel.investment + " USD", image: "dollar")
                    AssociateRectangleView(name: viewModel.procentInvestment + " return", image: "discount")
                    AssociateRectangleView(name: viewModel.numberYears + " years", image: "chart")
                }
                .padding(.bottom, 12)
                HStack(spacing: 8) {
                    AssociateRectangleView(name: viewModel.selectedCountry, image: "pin")
                    AssociateRectangleView(name: viewModel.selectedBusinessSector, image: "luggage")
                }.padding(.bottom, 32)
                
                Text("Based on your filters, we’re suggesting the following companies:")
                    .font(Poppins.Bold(size: 20))
                    .foregroundColor(CustomColors.myGray)
                    .padding(.bottom, 12)
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(0..<5) { _ in
                            CardView(companyName: "da", revenue: "da", stackPrice: "da", isPublic: true)
                                .padding(.bottom, 16)
                        }
                    }
                }
            }.padding(.horizontal, 24)
        }
    }
}

struct CardView: View {
    var companyName: String
    var revenue: String
    var stackPrice: String
    var isPublic: Bool
    @EnvironmentObject private var navigation: Navigation
    
    var body: some View {
        Button {
            let destinationVM = CompanyDetailsViewModel(companyName: "ddd", revenue: "dddd", stackPrice: "ddd")
            navigation.push(CompanyDetailsScreenView(viewModel: destinationVM).asDestination(), animated: true)
        } label: {
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Main Activity Area")
                            .font(Poppins.Regular(size: 12))
                            .foregroundColor(CustomColors.myBlue)
                            .padding(.bottom, 4)
                            .padding(.top, 12)
                        
                        Text(companyName)
                            .font(Poppins.Regular(size: 16))
                            .foregroundColor(CustomColors.myGray)
                            .padding(.bottom, 12)
                        
                        Text("Revenue")
                            .font(Poppins.Regular(size: 12))
                            .foregroundColor(CustomColors.myBlue)
                            .padding(.bottom, 4)
                        
                        Text(revenue)
                            .font(Poppins.Regular(size: 14))
                            .foregroundColor(CustomColors.myGray)
                            .padding(.bottom, 12)
                        
                        Text("Current stack price")
                            .font(Poppins.Regular(size: 12))
                            .foregroundColor(CustomColors.myBlue)
                            .padding(.bottom, 4)
                        
                        Text(stackPrice)
                            .font(Poppins.Regular(size: 14))
                            .foregroundColor(CustomColors.myGray)
                            .padding(.bottom, 12)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 0) {
                        if isPublic {
                            //todo: line chart
                            Button {
                               let modal = ModalView(title: "Predicted investment safety",
                                                     description: "We calculate this using a custom trained ML model").asDestination()
                                navigation.presentModal(modal, animated: true) {
                                } controllerConfig: { _ in
                                }

                            } label: {
                                HStack(spacing: 0) {
                                    Text("Sustainability Score")
                                        .font(Poppins.Bold(size: 14))
                                        .foregroundColor(CustomColors.myGray)
                                        .multilineTextAlignment(.center)
                                        .lineLimit(2)
                                        .fixedSize(horizontal: true, vertical: false)
                                    
                                    Image("info-circle")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 14)
                                        .padding(.leading, 4)
                                }
                            }
                        } else {
                            //todo: line chart
                            Button {
                                let modal = ModalView(title: "Sustainability Score",
                                                      description: "We calculate this score using AI to give meaningful insights to our users").asDestination()
                                navigation.presentModal(modal, animated: true) {
                                } controllerConfig: { _ in
                                }
                            } label: {
                                HStack(spacing: 0) {
                                    Text("Predicted Market Value")
                                        .font(Poppins.Bold(size: 14))
                                        .foregroundColor(CustomColors.myGray)
                                        .multilineTextAlignment(.center)
                                        .lineLimit(2)
                                        .fixedSize(horizontal: true, vertical: false)
                                    
                                    Image("info-circle")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 14)
                                        .padding(.leading, 4)
                                }
                            }
                        }
                    }
                }
            }.padding(.all, 12)
            .background(.white.opacity(0.14))
            .cornerRadius(12)

        }
    }
}

struct AssociateRectangleView: View {
    var name: String
    var image: String
    
    var body: some View {
        HStack(spacing: 8) {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(height: 16)
                .padding(.leading, 8)
            
            Text(name)
                .font(Poppins.SemiBold(size: 12))
                .foregroundColor(CustomColors.myGray)
                .fixedSize(horizontal: true, vertical: false)
                .lineLimit(1)
                .padding(.trailing, 8)
            
        }.frame(height: 28)
            .background(CustomColors.myGray.opacity(0.5))
            .overlay(
                RoundedRectangle(cornerRadius: 12).stroke(CustomColors.myGray, lineWidth: 1)
            )
            .cornerRadius(12)
    }
}
