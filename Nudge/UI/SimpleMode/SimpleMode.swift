//
//  SimpleMode.swift
//  Nudge
//
//  Created by Erik Gomez on 2/2/21.
//

import Foundation
import SwiftUI

// SimpleMode
struct SimpleMode: View {
    @ObservedObject var viewObserved: ViewState
    // Get the color scheme so we can dynamically change properties
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.openURL) var openURL
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor

    let bottomPadding: CGFloat = 10
    let contentWidthPadding: CGFloat = 25
    
    let logoWidth: CGFloat = 300
    let logoHeight: CGFloat = 80

    // Nudge UI
    var body: some View {
        VStack {
            // display the (?) info button
            AdditionalInfoButton()
                .padding(3)

            VStack(alignment: .center, spacing: 8) {
                Spacer()
                // Company Logo
                CompanyLogo(width: logoWidth, height: logoHeight)
                Spacer()

                // mainHeader
                HStack {
                    Text(getMainHeader())
                        .font(.title)
                        .fontWeight(.bold)
                }
 
                // Days or Hours Remaining
                HStack(spacing: 3.5) {
                    if (viewObserved.daysRemaining > 0 && !Utils().demoModeEnabled()) || Utils().demoModeEnabled() {
                        Text("Days Remaining To Resolve:".localized(desiredLanguage: getDesiredLanguage()))
                        Text(String(viewObserved.daysRemaining))
                            .foregroundColor(colorScheme == .light ? .accessibleSecondaryLight : .accessibleSecondaryDark)
                    } else if viewObserved.daysRemaining == 0 && !Utils().demoModeEnabled() {
                            Text("Hours Remaining To Resolve:".localized(desiredLanguage: getDesiredLanguage()))
                            Text(String(viewObserved.hoursRemaining))
                                .foregroundColor(differentiateWithoutColor ? .accessibleRed : .red)
                                .fontWeight(.bold)
                    } else {
                        Text("Days Remaining To Resolve:".localized(desiredLanguage: getDesiredLanguage()))
                        Text(String(viewObserved.daysRemaining))
                            .foregroundColor(differentiateWithoutColor ? .accessibleRed : .red)
                            .fontWeight(.bold)

                    }
                }

                // Deferral Count
                if showDeferralCount {
                    HStack{
                        Text("Deferred Count:".localized(desiredLanguage: getDesiredLanguage()))
                            .font(.title2)
                        Text(String(viewObserved.userDeferrals))
                            .foregroundColor(colorScheme == .light ? .accessibleSecondaryLight : .accessibleSecondaryDark)
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                } else {
                    HStack{
                        Text("Deferred Count:".localized(desiredLanguage: getDesiredLanguage()))
                            .font(.title2)
                        Text(String(viewObserved.userDeferrals))
                            .foregroundColor(colorScheme == .light ? .accessibleSecondaryLight : .accessibleSecondaryDark)
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    .hidden()
                }
                Spacer()
                
                HStack {
                    Text("Your macOS version is out of date".localized(desiredLanguage: getDesiredLanguage()))
                    
                    // actionButton
                    Button(action: {
                        Utils().updateDevice()
                    }) {
                        Text(actionButtonText)
                            .frame(minWidth: 120)
                    }
                    .keyboardShortcut(.defaultAction)
                }
                
                if !viewObserved.showFileVault {
                    HStack {
                        Text("Your Mac is not FileVault encrypted".localized(desiredLanguage: getDesiredLanguage()))
                        
                        // actionButton
                        Button(action: {
                            Utils().navigateToFileVault()
                        }) {
                            Text("Enable FileVault") // extract to property
                                .frame(minWidth: 120)
                        }
                        .keyboardShortcut(.defaultAction)
                    }
                } else {
                    HStack {
                        Text("Your Mac is FileVault encrypted ✅".localized(desiredLanguage: getDesiredLanguage()))
                    }
                }
                
                Spacer()
            }
            .frame(alignment: .center)

            // Bottom buttons
            HStack {
                // informationButton
                InformationButton()
                
                if viewObserved.allowButtons || Utils().demoModeEnabled() {
                    QuitButtons(viewObserved: viewObserved)
                }
            }
            .padding(.bottom, bottomPadding)
            .padding(.leading, contentWidthPadding)
            .padding(.trailing, contentWidthPadding)
        }
    }
}

#if DEBUG
// Xcode preview for both light and dark mode
struct SimpleMode_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(["en", "es"], id: \.self) { id in
                SimpleMode(viewObserved: nudgePrimaryState)
                    .preferredColorScheme(.light)
                    .environment(\.locale, .init(identifier: id))
            }
            ZStack {
                SimpleMode(viewObserved: nudgePrimaryState)
                    .preferredColorScheme(.dark)
            }
        }
    }
}
#endif
