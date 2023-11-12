//
//  RoundedButton.swift
//  OffWhite-SmartHack
//
//  Created by Aldea Alexia on 11.11.2023.
//

import SwiftUI

struct RoundedButton: View {
    
    enum Style {
        case filled
        case outlined
    }
    
    let text: String
    var style: Style = .filled
    var loading: Bool = false
    var fillColor: Color?
    var iconName: String?
    let action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 0) {
                if loading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: style == .outlined ? CustomColors.myNude : CustomColors.myBlack))
                } else {
                    if let iconName {
                        Image(iconName)
                            .frame(width: 24, height: 24)
                            .padding(.trailing, 4)
                    }
                    
                    Text(text)
                        .font(Poppins.Bold(size: 20))
                        .foregroundColor(style == .outlined ? CustomColors.myNude : CustomColors.myBlack)
                        .multilineTextAlignment(.center)
                    
                }
            }.frame(maxWidth: .infinity)
                .padding(.vertical, 14)
        }.frame(maxWidth: .infinity)
            .frame(height: 48)
            .background(style == .outlined ? CustomColors.myBlack : fillColor != nil ? fillColor : CustomColors.myNude)
            .cornerRadius(16, corners: [.topLeft, .bottomRight])
            .borderRadius(style == .outlined ? CustomColors.myNude : CustomColors.myBlack, width: 1, cornerRadius: 16, corners: [.topLeft, .bottomRight])
    }
}

