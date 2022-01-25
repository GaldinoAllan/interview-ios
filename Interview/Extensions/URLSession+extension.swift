//
//  URLSession+extension.swift
//  Interview
//
//  Created by Allan Gazola Galdino on 23/01/22.
//  Copyright © 2022 PicPay. All rights reserved.
//

import Foundation

extension URLSession: NetworkSession {

    func loadContacts(with url: URL,
                      completionHandler: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        let task = dataTask(with: url) { data, urlResponse, error in
            completionHandler(data, urlResponse, error)
        }
        task.resume()
    }
}
