//
//  CustomFont.swift
//  OffWhite-SmartHack
//
//  Created by Aldea Alexia on 11.11.2023.
//

import Foundation
import SwiftUI

enum Poppins {
    static func Regular(size: CGFloat) -> Font {
        return Font.custom("Poppins-Regular", size: size)
    }
    
    static func SemiBold(size: CGFloat) -> Font {
        return Font.custom("Poppins-SemiBold", size: size)
    }
    
    static func Bold(size: CGFloat) -> Font {
        return Font.custom("Poppins-Bold", size: size)
    }
}
