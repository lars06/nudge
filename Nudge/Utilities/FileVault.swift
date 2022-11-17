//
//  FileVault.swift
//  Nudge
//
//  Created by Lars Mellick on 15/11/2022.
//

import Foundation
import ShellOut

class FileVault {
    var status = FileVaultStatus.On
    
    init(fileVaultCommand: String = "fdesetup status") {
        CheckFileVaultStatus(fileVaultCommand: fileVaultCommand)
    }
    
    private func CheckFileVaultStatus(fileVaultCommand: String) {
        do {
            let shellOutput = try shellOut(to: fileVaultCommand)
            status = try ParseFileVaultStatus(shellOutput)
            
            fileVaultLog.info("\("FileVault status determined", privacy: .public)")
        } catch let error as ShellOutError {
            print(error.message)
        } catch {
            fileVaultLog.error("\("FileVault shell check returned unexpected value", privacy: .public)")
        }
    }
    
    private func ParseFileVaultStatus(_ shellOutput: String) throws -> FileVaultStatus {
        switch (shellOutput) {
        case "FileVault is On.":
            return FileVaultStatus.On
        case "FileVault is Off.":
            return FileVaultStatus.Off
        default:
            throw FileVaultError.InvalidReturnValue
        }
    }
}

enum FileVaultError: Error {
    case InvalidReturnValue
}

enum FileVaultStatus {
    case On
    case Off
}
