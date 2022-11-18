//
//  FileVault.swift
//  Nudge
//
//  Created by Lars Mellick on 15/11/2022.
//

import Foundation
import ShellOut

class Firewall {
    var status = FirewallStatus.On
    
    init(firewallCommand: String = "defaults read /Library/Preferences/com.apple.alf globalstate") {
        CheckFirewallStatus(firewallCommand: firewallCommand)
    }
    
    private func CheckFirewallStatus(firewallCommand: String) {
        do {
            let shellOutput = try shellOut(to: firewallCommand)
            status = try ParseFirewallStatus(shellOutput)
            
            firewallLog.info("\("Firewall status determined", privacy: .public)")
        } catch let error as ShellOutError {
            print(error.message)
        } catch {
            firewallLog.error("\("Firewall shell check returned unexpected value", privacy: .public)")
        }
    }
    
    private func ParseFirewallStatus(_ shellOutput: String) throws -> FirewallStatus {
        switch (shellOutput) {
        case "1":
            return FirewallStatus.On
        case "0":
            return FirewallStatus.Off
        default:
            throw FirewallError.InvalidReturnValue
        }
    }
}

enum FirewallError: Error {
    case InvalidReturnValue
}

enum FirewallStatus {
    case On
    case Off
}
