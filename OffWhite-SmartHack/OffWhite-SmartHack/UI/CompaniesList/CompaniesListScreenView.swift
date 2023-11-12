//
//  CompaniesListScreenView.swift
//  OffWhite-SmartHack
//
//  Created by Aldea Alexia on 11.11.2023.
//

import SwiftUI

struct NumberCircleView: View {
    @State private var progress: CGFloat = 0.5
    var text: String

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 10)
                .foregroundColor(CustomColors.myGray)
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .foregroundColor(CustomColors.myBlue)
                .rotationEffect(.degrees(-90))
            
            Text(text)
                .font(Poppins.Bold(size: 12))
                .foregroundColor(CustomColors.myBlue)
        }
//        .background(CustomColors.myGray)
        .frame(width: 70, height: 70)
        .animation(.easeInOut(duration: 1.0))
        .padding(20)
    }
}


struct CompaniesListScreenView: View {
    @StateObject var viewModel: CompaniesListViewModel
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [CustomColors.myDarkGray, CustomColors.myBlack]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 0) {
                    BackButton()
                    
                    Text("Best match companies")
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
                    .padding(.bottom)
                
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
                
                Spacer()
                
                switch viewModel.fetchingState {
                case .done:
                    
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 0) {
                            ForEach(viewModel.allCompanies, id: \.self.companyName) { company in
                                CardView(
                                    company: company
                                )
                                .padding(.bottom, 16)
                            }
                        }
                    }
                default:
                    VStack {
                        HStack {
                            Spacer()
                            ProgressView()
                                .progressViewStyle(.circular)
                                .tint(.white)
                            Spacer()
                        }
                        Spacer()
                    }
                }
            }.padding(.horizontal, 24)
        }
    }
}

struct CardView: View {
    
    let company: CompanyModel
    private let stockPrice: Float = .random(in: 100..<1000)
    
    @EnvironmentObject private var navigation: Navigation
    
    var body: some View {
        Button {
            let destinationVM = CompanyDetailsViewModel(company: company, stockPrice: stockPrice)
            navigation.push(CompanyDetailsScreenView(viewModel: destinationVM).asDestination(), animated: true)
        } label: {
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 0) {
                        
                        Text(company.companyName)
                            .font(Poppins.Regular(size: 16))
                            .foregroundColor(CustomColors.myGray)
                            .padding(.bottom, 12)
                        
                        Text("Main Activity Area")
                            .font(Poppins.Regular(size: 12))
                            .foregroundColor(CustomColors.myBlue)
                            .padding(.bottom, 4)
                            .padding(.top, 12)
                        
                        Text(company.mainIndustry)
                            .font(Poppins.Regular(size: 16))
                            .foregroundColor(CustomColors.myGray)
                            .padding(.bottom, 12)
                        
                        Text("Revenue")
                            .font(Poppins.Regular(size: 12))
                            .foregroundColor(CustomColors.myBlue)
                            .padding(.bottom, 4)
                        
                        Text(String(company.revenue))
                            .font(Poppins.Regular(size: 14))
                            .foregroundColor(CustomColors.myGray)
                            .padding(.bottom, 12)
                        
                        Text("Current stack price")
                            .font(Poppins.Regular(size: 12))
                            .foregroundColor(CustomColors.myBlue)
                            .padding(.bottom, 4)
                        
                        Text(String(stockPrice))
                            .font(Poppins.Regular(size: 14))
                            .foregroundColor(CustomColors.myGray)
                            .padding(.bottom, 12)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 0) {
                        if company.isPublic {
                            NumberCircleView(text: String(company.sustenaibleScore ?? 0)).padding(.leading, 12)
                            Button {
                               let modal = ModalView(title: "Predicted growth status",
                                                     description: "We calculate this using a custom trained ML model").asDestination()
                                navigation.presentModal(modal, animated: true) {
                                } controllerConfig: { _ in
                                }

                            } label: {
                                HStack(spacing: 0) {
                                    Text("Sustainability Score")
                                        .bold()
                                        .font(.system(size: 14))
                                        .foregroundColor(CustomColors.myGray)
                                        .multilineTextAlignment(.center)
                                        .lineLimit(2)
                                        .fixedSize(horizontal: true, vertical: false)
                                    
                                    Image("info-circle")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 18)
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
                                        .bold()
                                        .font(.system(size: 14))
                                        .foregroundColor(CustomColors.myGray)
                                        .multilineTextAlignment(.center)
                                        .lineLimit(2)
                                        .fixedSize(horizontal: true, vertical: false)
                                    
                                    Image("info-circle")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 18)
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
