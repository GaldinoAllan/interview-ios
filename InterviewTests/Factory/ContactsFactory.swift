//
//  ContactsFactory.swift
//  InterviewTests
//
//  Created by Allan Gazola Galdino on 23/01/22.
//  Copyright © 2022 PicPay. All rights reserved.
//

import Foundation



class ContactsFactory {
    static func crateBeyonceContact() -> Data? {
        var mockData: Data? {
    """
    [{
      "id": 2,
      "name": "Beyonce",
      "photoURL": "https://api.adorable.io/avatars/285/a2.png"
    }]
    """.data(using: .utf8)
        }
        return mockData
    }
}
