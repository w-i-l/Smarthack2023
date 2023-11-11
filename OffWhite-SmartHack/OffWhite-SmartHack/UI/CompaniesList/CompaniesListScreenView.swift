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
                    AssociateRectangleView(name: viewModel.areaOfActivity, image: "luggage")
                }.padding(.bottom, 32)
                
                Text("Based on your filters, we’re suggesting the following companies:")
                    .font(Poppins.Bold(size: 20))
                    .foregroundColor(CustomColors.myDarkGray)
                
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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Main Activity Area")
                        .font(Poppins.Regular(size: 12))
                        .foregroundColor(CustomColors.myBlue)
                        .padding(.bottom, 4)
                    
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
                        
                        Text("Sustainability Score")
                            .font(Poppins.Bold(size: 14))
                            .foregroundColor(CustomColors.myGray)
                    } else {
                        //todo: line chart
                        
                        Text("Predicted Market Value")
                            .font(Poppins.Bold(size: 14))
                            .foregroundColor(CustomColors.myGray)
                    }
                }
            }
        }.padding(.all, 12)
        .background(.white.opacity(0.14))
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
            .background(CustomColors.myDarkGray.opacity(0.5))
            .overlay(
                RoundedRectangle(cornerRadius: 16).stroke(CustomColors.myGray, lineWidth: 1)
            )
            .cornerRadius(16)
    }
}
