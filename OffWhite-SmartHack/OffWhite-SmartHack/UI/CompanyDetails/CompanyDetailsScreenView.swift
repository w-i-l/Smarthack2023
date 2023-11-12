//
//  CompanyDetailsScreenView.swift
//  OffWhite-SmartHack
//
//  Created by Aldea Alexia on 12.11.2023.
//

import SwiftUI

struct CompanyDetailsScreenView: View {
    @StateObject var viewModel: CompanyDetailsViewModel
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [CustomColors.myDarkGray, CustomColors.myBlack]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 12) {
                HStack(spacing: 0) {
                    BackButton()
                    
                    Text("Details")
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
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Company name")
                                .font(Poppins.Bold(size: 20))
                                .foregroundColor(CustomColors.myGray)
                                .padding(.bottom, 8)
                                .padding(.top, 32)
                            
                            Text("adresa adresa adresa adresa")
                                .font(Poppins.Bold(size: 14))
                                .foregroundColor(CustomColors.myGray.opacity(0.5))
                                .multilineTextAlignment(.leading)
                                .lineLimit(2)
                                .fixedSize(horizontal: true, vertical: false)
                            
                            HStack(spacing: 0) {
                                DetailsCard(description: "sdfvcbhdkfjhsbc kjshdabvcnkjhdsbv cbj vuhcifedksjvnchdkjfsbvncj fhd kjsdfhjbvnclhfdjskbcx vjkhsjdvbnclidfjksbv hdjksjbcvn fkhdjbcsvn cnx jdhkcnsv hdjbckx hdjskbcjxvn dhjlcxb jlhdckxb njdhcvx nhdjkcsbnv dljhk")
                                
                                Spacer()
                                
                                NumberCircleView(text: String(viewModel.number))
                            }.padding(.vertical, 12)
                            
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Main Activity Area")
                                    .font(Poppins.Regular(size: 12))
                                    .foregroundColor(CustomColors.myBlue)
                                    .padding(.bottom, 4)
                                
                                Text(viewModel.companyName)
                                    .font(Poppins.Regular(size: 16))
                                    .foregroundColor(CustomColors.myGray)
                                    .padding(.bottom, 12)
                                
                                Text("Revenue")
                                    .font(Poppins.Regular(size: 12))
                                    .foregroundColor(CustomColors.myBlue)
                                    .padding(.bottom, 4)
                                
                                Text(viewModel.revenue)
                                    .font(Poppins.Regular(size: 14))
                                    .foregroundColor(CustomColors.myGray)
                                    .padding(.bottom, 12)
                                
                                Text("Current stack price")
                                    .font(Poppins.Regular(size: 12))
                                    .foregroundColor(CustomColors.myBlue)
                                    .padding(.bottom, 4)
                                
                                Text(viewModel.stackPrice)
                                    .font(Poppins.Regular(size: 14))
                                    .foregroundColor(CustomColors.myGray)
                                    .padding(.bottom, 12)
                                
                                Text("Revenue increase in last year")
                                    .font(Poppins.Regular(size: 12))
                                    .foregroundColor(CustomColors.myBlue)
                                    .padding(.bottom, 4)
                                
                                Text("80%")
                                    .font(Poppins.Regular(size: 14))
                                    .foregroundColor(CustomColors.myGray)
                                    .padding(.bottom, 12)
                            }
                            
                        }
                    }
                }.padding(.horizontal, 24)
                
                Spacer(minLength: 80)
            }
            
            VStack(spacing: 0) {
                Spacer(minLength: 24)
                
                Text("Reach company on social media")
                    .font(Poppins.Regular(size: 16))
                    .foregroundColor(CustomColors.myGray)
                    .padding(.bottom, 12)
                
                HStack(spacing: 16) {
                    Button {
                        
                    } label: {
                        Image("facebook")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    Button {
                        
                    } label: {
                        Image("instagram")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    
                    Button {
                        
                    } label: {
                        Image("linkedin")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                }.padding(.bottom, 12)
                
                Button {
                    
                } label: {
                    Text("Visit the website")
                        .underline()
                        .font(Poppins.Regular(size: 14))
                        .foregroundColor(CustomColors.myGray)
                        .padding(.bottom, 24)
                    
                }
            }.padding(.horizontal, 24)
                    .padding(.bottom, 24)
        }.frame(maxWidth: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .leading, .trailing])
    }
}

struct DetailsCard: View {
    var description: String
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [CustomColors.myNude, CustomColors.myDarkGray]), startPoint: .top, endPoint: .bottom).borderRadius(CustomColors.myNude, width: 1, cornerRadius: 16, corners: [.topLeft, .bottomRight])
            
            Text(description)
                .font(Poppins.Regular(size: 14))
                .foregroundColor(CustomColors.myBlack)
                .multilineTextAlignment(.leading)
                .padding(.all, 12)
        }
        
    }
}
