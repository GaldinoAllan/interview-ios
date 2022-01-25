//
//  NetworkSession.swift
//  Interview
//
//  Created by Allan Gazola Galdino on 23/01/22.
//  Copyright © 2022 PicPay. All rights reserved.
//

import Foundation

protocol NetworkSession {

    func loadContacts(with url: URL,
                      completionHandler: @escaping((Data?, URLResponse?, Error?) -> Void))
}
