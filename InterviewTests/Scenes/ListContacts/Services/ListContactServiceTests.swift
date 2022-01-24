import XCTest
@testable import Interview

class ListContactServiceTests: XCTestCase {

    private var subjectUnderTest: ListContactService!
    private var session: NetworkSessionMock!

    override func setUp() {
        session = NetworkSessionMock()
        subjectUnderTest = ListContactService(urlSession: session)
    }

    override func tearDown() {
        session = nil
        subjectUnderTest = nil
    }

    func testFetchContactsWithoutDataShouldFailWithEmptyList() {
        subjectUnderTest.fetchContacts { result in
            switch result {
            case .success(_):
                XCTFail("There should not be any contacts here")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "Empty response")
            }
        }
    }

    func testFetchContactsWithMockedDataShouldHaveBeyonceContact() {
        session = NetworkSessionMock(data: ContactsFactory.crateBeyonceContact())
        subjectUnderTest = ListContactService(urlSession: session)

        let expectedContact = Contact(id: 2,
                                      name: "Beyonce",
                                      photoURL: "https://api.adorable.io/avatars/285/a2.png")

        subjectUnderTest.fetchContacts { result in
            switch result {
            case .success(let contacts):
                XCTAssertEqual(contacts, [expectedContact])
            case .failure(let error):
                XCTFail("Load contacts list failed with error: \(error.localizedDescription)")
            }
        }
    }
}
