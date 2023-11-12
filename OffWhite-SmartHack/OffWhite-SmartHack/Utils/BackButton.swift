//
//  BackButton.swift
//  OffWhite-SmartHack
//
//  Created by Aldea Alexia on 11.11.2023.
//

import Foundation
import SwiftUI

struct BackButton: View {
    @EnvironmentObject private var navigation: Navigation
    
    var body: some View {
        Button(action: {
            navigation.pop(animated: true)
        }) {
            Image("ic_nav_up")
                .frame(width: 32, height: 32)
        }
    }
}

struct ModalView: View {
    let title: String
    let description: String
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            VStack(spacing: 0) {
                Image("info-circle-big")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .padding(32)
                
                Text(title)
                    .font(Poppins.Bold(size: 20))
                    .foregroundColor(CustomColors.myGray)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 12)
                
                Text(description)
                    .font(Poppins.Regular(size: 16))
                    .foregroundColor(CustomColors.myGray)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 12)
                
            }.padding(.horizontal, 16)
                .padding(.vertical, 16)
                .background(CustomColors.myBlack.cornerRadius(8))
                .padding(.horizontal, 36)
        }.ignoresSafeArea()
    }
}
