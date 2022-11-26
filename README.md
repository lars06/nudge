# Nudge fork: FileVault and Firewall
This fork extends Nudge's functionality to check the status of additional security concerns: FileVault and Firewall. The software update prompt from the original Nudge is replaced with three prompts which conditionally show the status and provide actions for these security issues.

The proof of concept was completed only in the app's Simple mode, which can be run with the `-simple-mode` argument. Since FileVault and Firewall can be difficult to disable on a dev Mac, the app functionality is difficult to test locally, however the code can be fiddled with to show the desired state.

## Example UI
<img src="/assets/simple_mode/dark-mode.png" width=75% height=75%>

FileVault and Firewall prompts direct the user to the appropriate settings screens on their Mac when the button is clicked. If the user has resolved a security concern, the prompt will change to a success message with a ✅

## Next steps
This was a proof of concept, so there are multiple areas for further development:
- Determine logic for when a user resolves a security issue. Since there are now multiple security prompts, the interface will need to be refreshed and updated as the user makes the changes (eg. turning on FileVault and Firewall).
- Test on earlier versions of macOS (< 13.0). Different settings navigation anchors exist for versions >=13.0 and <13.0. This logic is included but has not been tested on other machines.
- Extract strings (UI messages and settings anchors) into a centralised location.
- Determine if the Nudge standard mode UI is needed, or if simple mode is enough for the requirements. If standard mode is required, the UI will need to be reworked.
- Host light and dark versions of company logo to reference in Nudge JSON. This can also be done locally by referencing a local file in the Nudge JSON.
