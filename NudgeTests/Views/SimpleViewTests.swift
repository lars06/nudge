//
//  NudgeUITests.swift
//  NudgeTests
//
//  Created by Lars Mellick on 25/11/22.
//

import XCTest
@testable import Nudge
import ViewInspector

extension SimpleMode: Inspectable {}

class SimpleViewTests: XCTestCase {
    func testSoftwareUpdatedMessagePresentWhenUpToDate() {
        let viewState = ViewState()
        viewState.showSoftwareUpdatePrompt = false
        let simpleView = SimpleMode(viewObserved: viewState)
        
        let softwareUpdateMessage = try? simpleView.inspect().find(viewWithId: "softwareUpdateNoAction").text().string()
        XCTAssertEqual(softwareUpdateMessage, "Your Mac is fully updated ✅")
        
        let softwareUpdatePrompt = try? simpleView.inspect().find(viewWithId: "softwareUpdatePrompt")
        XCTAssertNil(softwareUpdatePrompt)
        let softwareUpdateButton = try? simpleView.inspect().find(viewWithId: "softwareUpdateButton")
        XCTAssertNil(softwareUpdateButton)
    }
    
    func testSoftwareUpdatePromptPresentWhenNotUpToDate() {
        let viewState = ViewState()
        viewState.showSoftwareUpdatePrompt = true
        let simpleView = SimpleMode(viewObserved: viewState)
        
        let softwareUpdatePrompt = try? simpleView.inspect().find(viewWithId: "softwareUpdatePrompt").text().string()
        XCTAssertEqual(softwareUpdatePrompt, "Your macOS version is out of date")
        let softwareUpdateButton = try? simpleView.inspect().find(button: "Update Device")
        XCTAssertNotNil(softwareUpdateButton)

        let softwareUpdateMessage = try? simpleView.inspect().find(viewWithId: "softwareUpdateNoAction")
        XCTAssertNil(softwareUpdateMessage)
    }
    
    func testFileVaultOnMessagePresentWhenEnabled() {
        let viewState = ViewState()
        viewState.showFileVaultPrompt = false
        let simpleView = SimpleMode(viewObserved: viewState)
        
        let fileVaultMessage = try? simpleView.inspect().find(viewWithId: "fileVaultNoAction").text().string()
        XCTAssertEqual(fileVaultMessage, "Your Mac is FileVault encrypted ✅")
        
        let fileVaultPrompt = try? simpleView.inspect().find(viewWithId: "fileVaultPrompt")
        XCTAssertNil(fileVaultPrompt)
        let fileVaultButton = try? simpleView.inspect().find(viewWithId: "fileVaultButton")
        XCTAssertNil(fileVaultButton)
    }
    
    func testFileVaultPromptPresentWhenNotEnabled() {
        let viewState = ViewState()
        viewState.showFileVaultPrompt = true
        let simpleView = SimpleMode(viewObserved: viewState)
        
        let fileVaultPrompt = try? simpleView.inspect().find(viewWithId: "fileVaultPrompt").text().string()
        XCTAssertEqual(fileVaultPrompt, "Your Mac is not FileVault encrypted")
        let fileVaultButton = try? simpleView.inspect().find(button: "Enable FileVault")
        XCTAssertNotNil(fileVaultButton)

        let fileVaultMessage = try? simpleView.inspect().find(viewWithId: "fileVaultNoAction")
        XCTAssertNil(fileVaultMessage)
    }
    
    func testFirewallOnMessagePresentWhenEnabled() {
        let viewState = ViewState()
        viewState.showFirewallPrompt = false
        let simpleView = SimpleMode(viewObserved: viewState)
        
        let firewallMessage = try? simpleView.inspect().find(viewWithId: "firewallNoAction").text().string()
        XCTAssertEqual(firewallMessage, "Your Mac is Firewall enabled ✅")

        let firewallPrompt = try? simpleView.inspect().find(viewWithId: "firewallPrompt")
        XCTAssertNil(firewallPrompt)
        let firewallButton = try? simpleView.inspect().find(viewWithId: "firewallButton")
        XCTAssertNil(firewallButton)
    }
    
    func testFirewallPromptPresentWhenNotEnabled() {
        let viewState = ViewState()
        viewState.showFirewallPrompt = true
        let simpleView = SimpleMode(viewObserved: viewState)
        
        let firewallPrompt = try? simpleView.inspect().find(viewWithId: "firewallPrompt").text().string()
        XCTAssertEqual(firewallPrompt, "Your Mac Firewall is not enabled")
        let firewallButton = try? simpleView.inspect().find(button: "Enable Firewall")
        XCTAssertNotNil(firewallButton)

        let firewallMessage = try? simpleView.inspect().find(viewWithId: "firewallNoAction")
        XCTAssertNil(firewallMessage)
    }
}
