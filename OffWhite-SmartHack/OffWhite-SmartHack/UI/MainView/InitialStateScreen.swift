//
//  InitialStateScreen.swift
//  OffWhite-SmartHack
//
//  Created by Aldea Alexia on 11.11.2023.
//

import SwiftUI

struct InitialStateScreen: View {
    @EnvironmentObject private var navigation: Navigation
    
    var body: some View {
       ZStack {
           VStack {
               Image("initial_state")
           }
           
           VStack(spacing: 0) {
               Spacer(minLength: 24)
               RoundedButton(text: "Start Searching") {
                   navigation.push(MainScreenView().asDestination(), animated: true)
               }.padding(.horizontal, 24)
                   .padding(.bottom, 56)
           }
        }.frame(maxWidth: .infinity)
            .ignoresSafeArea(.container, edges: .all)
    }
}

