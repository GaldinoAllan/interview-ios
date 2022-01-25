//
//  NetworkErrors.swift
//  Interview
//
//  Created by Allan Gazola Galdino on 23/01/22.
//  Copyright © 2022 PicPay. All rights reserved.
//

import Foundation

enum NetworkErrors: Error {
    case invalidUrl
    case emptyResponse
    case serverError(message: String)
    case jsonDecoding(message: String)

    var localizedDescription: String {
        switch self {
        case .invalidUrl:
            return "Invalid URL"
        case .emptyResponse:
            return "Empty response"
        case .serverError(_):
            return "Error returning data from the server"
        case .jsonDecoding(_):
            return "Could not decode JSON"
        }
    }
}
