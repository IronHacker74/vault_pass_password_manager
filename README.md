![Github Image](https://github.com/codehacker74/vault_pass_password_manager/assets/23727704/8f2b287c-f667-4cd7-89f8-d2ac52f54bbd)
Written strictly in Swift, VaultPass is designed to be an offline, account credential vault that makes it simple and secure to store and use usernames and passwords.<br>
For questions, concerns, or complains please email me: <codehacker.andrew@gmail.com>
<br><br>
[VaultPass is in the App Store](https://apps.apple.com/be/app/vaultpass-password-manager/id6451467003)
<br><br>
# Features
Here is a list of features that I built into VaultPass as well as some explaintions for their use and any issues I ran into while developing.
### Security
Accessing your credentials is important to happen by you alone (obviously). The optimal way to keep out unwanted access while also not requiring another password to access sensitive information is to use the respective Apple device's biometric capability.
The other point of concern is the credentials themselves; VaultPass keeps things encrypted until you actually need to see or use them. The home screen that is filled with all your credentials is not held unencrypted. Only when you reveal, copy, or autofill the username and password will they be unencrypted. From creation to storage to iCloud, the entire process considers the sensitivity of the data and keeps it encrypted. 
### Easily accessing credentials
It seemed non-trivial when developing my own password manager is quickly accessing usernames and/or passwords to login into the necessary portal. Autofill would be one solution but in case the user does not want to enable this feature or you're attempting to log into a website or app that does not support autofill, then copying and pasting credentials becomes the fastest way to make this happen.
### Autofill
When a textfield is marked as `password` or `sensitive` it shows the `Password` button above the keyboard (on MacOS this button is a key icon inside the left corner of the focused field) and this pulls up the autofill screen. The autofill feature had a curve to its development since little information exists outside Apple's documentation to implement Apple's Autofill Entitlement. Typically only utilizing a feature using documentation would be fine but the Autofill Entitlement is a tool that cannot be debugged outside the production flow due to the lack of the API support. Apple has it tied to their own system tightly making it difficult to ensure it works as intended. The other difficult part of this feature was allowing users to create a credentail inside autofill. Each file and piece of code that is involved in creating a new credential had to be carefully added to the Autofill Entitlement to both allow users to create a new credential while not exposing any sensitive data. However, upon completing this users would be able to easily autofill their credentials to login or create an account.
### Automatically adding identifiers
The lack of this feature is my biggest issue with Apple's password system. When you use a credential from autofill, it should (after accepting a prompt) automatically update the identifiers that they are used. Upon an initial prompt, each time you use a credential from autofill, VaultPass will add the url to a list of identifiers for that credential. You can also manually add or remove identifiers from the credential that you used it. While their are some instances where Apple will request to update the identifier you use for your credentials, they do not perform this automatically causing constant autofill repetitions. VaultPass has made the proper adjustments for this issue.
### iCloud
In order to access your credentials from multiple devices I wanted to add iCloud support. To make this work the biggest change (other than turning on iCloud and adding the necessary code) is where the encryption keys were being stored. Originally stored locally, the encryption key now needed to be stored in Keychain in order to access from any device. With the encryption key already encrypted, adding it to keychain doubled it's encryption making it very difficult to crack.
### Testing
I attempted to cover as much code as possible with testing but some things (such as autofill) could not be tested at all. However, the priority for the tests were to ensure that the general flow and system of the app worked. I also began a list of manual tests that needed to be performed prior to a new release.
# Branches
To keep things clean between development, testing, and release three branches were constructed to separate these out.
### dev
Development process of the application and performing manual tests; sub-branches would be generated to assist in separating out specific features before pushing to dev.
### test
Strictly for testing purposes that gets pushed to Testflight to locally test and to run all the tests as well upon getting merged with dev. Rarely gets it's own commits but if a test fails or a small mistake occurs then a commit will be generated for the fix.
### release
The release of the application to the App Store; this has no other responsibility and only gets a commit for issues prohibiting App Store release.
