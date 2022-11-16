//
//  FileVault.swift
//  Nudge
//
//  Created by Lars Mellick on 15/11/2022.
//

import Foundation
import ShellOut

class FileVault {
    var enabled = true
    
    init(fileVaultCommand: String = "fdesetup status") {
        do {
            let shellOutput = try shellOut(to: fileVaultCommand)
            enabled = try ParseShellOutput(shellOutput: shellOutput)
        } catch let error as ShellOutError {
            print(error.message)
        } catch {
            print("FileVault shell check returned unexpected value")
        }
    }
    
    private func ParseShellOutput(shellOutput: String) throws -> Bool {
        switch (shellOutput) {
        case "FileVault is On.":
            return false // change back after UI checked
        case "FileVault is Off.":
            return false
        default:
            throw FileVaultError.InvalidReturnValue
        }
    }
}

enum FileVaultError: Error {
    case InvalidReturnValue
}
