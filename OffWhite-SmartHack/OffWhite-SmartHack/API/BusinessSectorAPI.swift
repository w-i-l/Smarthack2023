//
//  BusinessSector.swift
//  OffWhite-SmartHack
//
//  Created by Mihai Ocnaru on 12.11.2023.
//

import Foundation
import Combine
import SwiftyJSON

class BusinessSectorAPI {
    
    static let shared = BusinessSectorAPI()
    
    private init() {}
    
    public func getAllBusinessSectors() -> Future<[BusinessSectorModel], Error> {
        Future<[BusinessSectorModel], Error> { promise in
            var urlComponents = URLComponents(string: "http://127.0.0.1:5000/api/v1/get_best_activity_domains")
            urlComponents?.queryItems = [
            ]
            
            var urlRequest = URLRequest(url: urlComponents!.url!)
            urlRequest.httpMethod = "GET"
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                guard error == nil else { return }
                guard let data else { return }
                
                do {
                    
                    let json = try JSON(data: data)
                    let data = json["activity_domains"].arrayValue
                    let sectors = data.map { BusinessSectorModel(name: $0.stringValue)}
                    
                    promise(.success(sectors))
                    
                } catch(let error) {
                    print(error)
                    promise(.failure(error))
                }
                
            }
            
            dataTask.resume()
        }
    }
}
