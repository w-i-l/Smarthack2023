//
//  CompaniesAPI.swift
//  OffWhite-SmartHack
//
//  Created by Mihai Ocnaru on 12.11.2023.
//

import Foundation
import Combine
import SwiftyJSON
import SwiftUI

class CompaniesAPI {
     
    static let shared = CompaniesAPI()
    
    private init() {}
    
    public func getAllCompanies() -> Future<[CompanyModel], Error> {
        
        Future<[CompanyModel], Error> { promise in
            
            var urlComponents = URLComponents(string: "http://127.0.0.1:5000/api/v1/temp_get_companies")
            urlComponents?.queryItems = [
            ]
            
            var urlRequest = URLRequest(url: urlComponents!.url!)
            urlRequest.httpMethod = "GET"
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                guard error == nil else { return }
                guard let data else { return }
                
                do {
                    
                    let json = try JSON(data: data)
                    let data = json.arrayValue
                    let companies = data.map { company in
                        print(company["business_tags"].arrayValue as? [String] ?? [])
                        return CompanyModel(
                            businessTags: company["business_tags"].arrayValue as? [String] ?? [],
                            companyName: company["company_name"].stringValue,
                            companyType: company["company_type"].stringValue,
                            companyEmployeesCount: company["employee_count"].intValue,
                            revenue: company["estimated_revenue"].intValue,
                            facebookUrl: company["facebook_url"].string,
                            instagramUrl: company["instagram_url"].string,
                            linkedinUrl: company["linkedin_url"].string,
                            websiteUrl: company["website_url"].string,
                            description: company["long_description"].string,
                            mainIndustry: company["main_industry"].stringValue,
                            mainCountry: company["main_country"].stringValue,
                            technologies: company["technologies"].arrayValue as! [String],
                            yearFounded: company["year_founded"].intValue
                        )
                    }
                    
                    promise(.success(companies))
                    
                } catch(let error) {
                    print(error)
                    promise(.failure(error))
                }
                
            }
            
            dataTask.resume()
        }
    }
}
