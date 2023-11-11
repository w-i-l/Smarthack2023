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
