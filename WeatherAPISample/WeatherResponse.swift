//
//  ApiResponseModel.swift
//  WeatherAPISample
//
//  Created by 石川寛人 on 2023/01/11.
//

import Foundation

struct WeatherResponse: Decodable {
    var publishingOffice: String
    var reportDatetime: String
    var targetArea: String
    var headlineText: String
    var text: String
}
