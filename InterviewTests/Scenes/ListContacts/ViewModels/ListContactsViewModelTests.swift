//
//  ListContactsViewModelTests.swift
//  InterviewTests
//
//  Created by Allan Gazola Galdino on 25/01/22.
//  Copyright © 2022 PicPay. All rights reserved.
//

import XCTest
@testable import Interview

class ListContactsViewModelTests: XCTestCase {

    var subjectUnderTest: ListContactsViewModel?
    var service = ListContactServiceMock()
    let delegateSpy = ListContactsViewModelDelegateSpy()

    override func setUp() {
        subjectUnderTest = ListContactsViewModel(service: service)
        subjectUnderTest?.delegate = delegateSpy
    }

    override func tearDown() {
        subjectUnderTest = nil
    }

    func testLoadContactsWithMockedContactsListShouldReturnSuccess() {
        let contactsList = ContactsFactory.createContactsList(withContactsCount: 2)
        service.contactsList = contactsList
        subjectUnderTest?.loadContacts()
        XCTAssertEqual(subjectUnderTest?.contacts, contactsList)
        XCTAssertEqual(delegateSpy.methodCalled, "contactsDidLoad")
    }
}
