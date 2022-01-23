//
//  NetworkSession.swift
//  InterviewTests
//
//  Created by Allan Gazola Galdino on 23/01/22.
//  Copyright © 2022 PicPay. All rights reserved.
//

import Foundation
@testable import Interview

struct NetworkSessionMock: NetworkSession {
    var data: Data?
    var urlResponse: URLResponse?
    var error: Error?

    func loadContacts(with url: URL,
                      completionHandler: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        completionHandler(data, urlResponse, error)
    }
}
