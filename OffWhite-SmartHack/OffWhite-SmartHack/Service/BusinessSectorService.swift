//
//  BusinessSectorService.swift
//  OffWhite-SmartHack
//
//  Created by Mihai Ocnaru on 12.11.2023.
//

import Foundation
import Combine

class BusinessSectorService: BaseViewModel<Any> {
    static let shared = BusinessSectorService()
    
    override private init() {}
    
    private (set) var allBusinessSectors: [BusinessSectorModel]?
    
    public func getAllBusniessSectors() -> AnyPublisher<[BusinessSectorModel], Error> {
        
        if allBusinessSectors == nil {
            
            BusinessSectorAPI.shared.getAllBusinessSectors()
                .sink { _ in
                    
                } receiveValue: { [weak self] businessSectors in
                    self?.allBusinessSectors = businessSectors
                }
                .store(in: &self.bag)

            
            return BusinessSectorAPI.shared.getAllBusinessSectors()
                .eraseToAnyPublisher()
        } else {
            return Future<[BusinessSectorModel], Error> { [weak self] promise in
                promise(.success((self?.allBusinessSectors)!))
            }
            .eraseToAnyPublisher()
        }
    }
    
    public func setBusinessSector(newValue: [BusinessSectorModel]) {
        self.allBusinessSectors = newValue
    }
    
    public func resetBusinessSector() {
        self.allBusinessSectors = nil
    }
}
