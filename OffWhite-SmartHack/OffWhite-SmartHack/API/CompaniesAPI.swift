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

class CompaniesAPI: BaseViewModel<Any> {
    
    static let shared = CompaniesAPI()
    
    override private init() {}
    
    public func getCompanyDetails(companyName: String, address: String, sustenaibleScore: Int) -> Future<CompanyModel, Error> {
        Future<CompanyModel, Error> { promise in
            
            var urlComponents = URLComponents(string: "http://127.0.0.1:\(PORT)/api/v1/get_company_details")
            
            urlComponents?.queryItems = [
                URLQueryItem(name: "company", value:  companyName),
                URLQueryItem(name: "location", value: address)
            ]
            
            var urlRequest = URLRequest(url: urlComponents!.url!)
            urlRequest.httpMethod = "GET"
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                guard error == nil else { return }
                guard let data else { return }
                
                do {
                    
                    let company = try JSON(data: data)
                    
                    let companyModel = CompanyModel(
                        businessTags: company["business_tags"].arrayValue.map { $0.stringValue},
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
                        technologies: company["technologies"].arrayValue.map { $0.stringValue},
                        yearFounded: company["year_founded"].intValue,
                        sustenaibleScore: sustenaibleScore
                    )
                    //                    print(companyModel)
                    promise(.success(companyModel))
                    
                } catch(let error) {
                    print(error)
                    promise(.failure(error))
                }
                
            }
            
            dataTask.resume()
        }
    }
    
    public func getAllCompanies(activityDomain: [String], location:String) -> Future<[CompanyModel], Error> {
        
        Future<[CompanyModel], Error> { promise in
            
            let allActivities = activityDomain + ["Artificial Intelligence",         "E-Commerce",         "Green Energy",         "Manufacturing",      "Telecommunications"]
            
            var urlComponents = URLComponents(string: "http://127.0.0.1:\(PORT)/api/v1/temp_get_companies")
            let stringFromActivityDomains = allActivities.reduce(into: "") { partialResult, into in
                partialResult += "\(into), "
            }
            print(stringFromActivityDomains)
            urlComponents?.queryItems = [
                URLQueryItem(name: "activity_domain", value:  stringFromActivityDomains),
                URLQueryItem(name: "location", value: location)
            ]
            
            var urlRequest = URLRequest(url: urlComponents!.url!)
            urlRequest.httpMethod = "GET"
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                guard error == nil else { return }
                guard let data else { return }
                
                do {
                    
                    let json = try JSON(data: data)
                    print(json)
                    let data = json["scores"].dictionaryValue
//                    var companies: [CompanyModel] = []
                    
                    var companiesPromises: [Future<CompanyModel, Error>] = []
                    print(data.keys)
                    data.keys.forEach { company in
                        let score = data[company]?.intValue
                        let companyPromise = self.getCompanyDetails(companyName: company, address: location, sustenaibleScore: score ??  0)
                        companiesPromises.append(companyPromise)
                    }
                    
                    Publishers.MergeMany(companiesPromises) // MergeMany combines multiple publishers into a single publisher
                        .collect() // Collect the results into an array
                        .sink(receiveCompletion: { completion in
                            switch completion {
                            case .finished:
                                break
                            case .failure(let error):
                                promise(.failure(error))
                            }
                        }, receiveValue: { companies in
                            print(companies)
                            promise(.success(companies))
                        })
                        .store(in: &self.bag)
            } catch(let error) {
                print(error)
                promise(.failure(error))
            }
            
        }
        
        dataTask.resume()
    }
}
}
