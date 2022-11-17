//
//  FileVaultTests.swift
//  NudgeTests
//
//  Created by Lars Mellick on 16/11/2022.
//

import Foundation
import XCTest
@testable import Nudge

class FileVaultTests: XCTestCase {
    func testFileVaultOn() {
        let fileVault = FileVault(fileVaultCommand: "echo FileVault is On.")
        XCTAssert(fileVault.status == FileVaultStatus.On)
    }
    
    func testFileVaultOff() {
        let fileVault = FileVault(fileVaultCommand: "echo FileVault is Off.")
        XCTAssert(fileVault.status == FileVaultStatus.Off)
    }
    
    func testInvalidResponse() {
        let fileVault = FileVault(fileVaultCommand: "echo something")
        XCTAssert(fileVault.status == FileVaultStatus.On) // user not alerted if there is a system error
    }
}
