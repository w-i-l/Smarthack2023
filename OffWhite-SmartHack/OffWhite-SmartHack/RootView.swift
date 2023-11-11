//
//  OffWhite_SmartHackApp.swift
//  OffWhite-SmartHack
//
//  Created by Aldea Alexia on 11.11.2023.
//

import SwiftUI
//import FirebaseAuth
//import Firebase

struct RootView: View {
    
    @ObservedObject var navigation: Navigation
    
    var body: some View {
        ZStack(alignment: .bottom) {
            NavigationHostView(navigation: navigation)
        }.ignoresSafeArea()
    }
    
}
