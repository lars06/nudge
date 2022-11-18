//
//  FirewallTests.swift
//  NudgeTests
//
//  Created by Lars Mellick on 18/11/2022.
//

import Foundation
import XCTest
@testable import Nudge

class FirewallTests: XCTestCase {
    func testFirewallOn() {
        let firewall = Firewall(firewallCommand: "echo 1")
        XCTAssert(firewall.status == FirewallStatus.On)
    }
    
    func testFileVaultOff() {
        let firewall = Firewall(firewallCommand: "echo 0")
        XCTAssert(firewall.status == FirewallStatus.Off)
    }
    
    func testInvalidResponse() {
        let firewall = Firewall(firewallCommand: "echo something")
        XCTAssert(firewall.status == FirewallStatus.On) // user not alerted if there is a system error
    }
}
