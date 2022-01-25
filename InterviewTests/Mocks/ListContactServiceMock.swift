//
//  ListContactServiceMock.swift
//  InterviewTests
//
//  Created by Allan Gazola Galdino on 25/01/22.
//  Copyright © 2022 PicPay. All rights reserved.
//

import Foundation
@testable import Interview

class ListContactServiceMock: ListContactServiceProtocol {

    var contactsList = [Contact]()

    func fetchContacts(completionHandler completion: @escaping (Result<[Contact],
                                                                NetworkErrors>) -> Void) {
        completion(.success(contactsList))
    }
}
