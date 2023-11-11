//
//  BaseViewModel.swift
//  OffWhite-SmartHack
//
//  Created by Aldea Alexia on 11.11.2023.
//

import Foundation
import Combine

enum DefaultViewModelEvent {
    case completed(message: String?)
}

class BaseViewModel<T: Any> {
    var bag = Set<AnyCancellable>()
    @Published var isLoading = false
}
