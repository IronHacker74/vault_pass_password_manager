//
//  IdentifierTextFieldCellTests.swift
//  VaultPass - Password ManagerTests
//
//  Created by Andrew Masters on 9/10/23.
//

import XCTest
@testable import VaultPass___Password_Manager

final class IdentifierTextFieldCellTests: XCTestCase {

    func testIBOutletsNotNil() {
        // given
        let sut = IdentifierTextFieldCell.loadFromNib()
        // then
        XCTAssertNotNil(sut.identifierTextField)
        XCTAssertNotNil(sut.deleteButton)
    }
    
    func testIBActionsNotNil() {
        // given
        let sut = IdentifierTextFieldCell.loadFromNib()
        // then
        XCTAssertNotNil(sut.deleteButton.actions(forTarget: sut, forControlEvent: .touchUpInside))
    }
}
