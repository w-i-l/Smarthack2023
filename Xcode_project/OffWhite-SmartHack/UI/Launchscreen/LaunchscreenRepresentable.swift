//
//  LaunchscreenRepresentable.swift
//  OffWhite-SmartHack
//
//  Created by Aldea Alexia on 11.11.2023.
//

import SwiftUI

struct LaunchscreenRepresentable: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UIViewController {
        UIStoryboard(name: "Launchscreen", bundle: .main).instantiateInitialViewController()!
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {

    }
}
