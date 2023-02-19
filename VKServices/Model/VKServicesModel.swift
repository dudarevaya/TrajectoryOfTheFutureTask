//
//  VKServicesModel.swift
//  VKServices
//
//  Created by Yana Dudareva on 18.02.2023.
//

import Foundation

struct VKServicesModel: Codable {
    let items: [Item]
}

struct Item: Codable {
    let name, description: String
    let iconUrl: String
    let serviceUrl: String
    
    enum CodingKeys: String, CodingKey {
        case name, description
        case iconUrl = "icon_url"
        case serviceUrl = "service_url"
    }
}
