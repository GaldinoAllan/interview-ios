//
//  ListContactsViewModelDelegateSpy.swift
//  InterviewTests
//
//  Created by Allan Gazola Galdino on 25/01/22.
//  Copyright © 2022 PicPay. All rights reserved.
//

import Foundation
@testable import Interview

class ListContactsViewModelDelegateSpy: ListContactsViewModelDelegate {
    var methodCalled = ""

    func contactsDidLoad() {
        methodCalled = "contactsDidLoad"
    }

    func contactsLoadFailed(withErrorInfo errorInfo: (title: String, message: String)) {
        methodCalled = "contactsLoadFailed"
    }
}
