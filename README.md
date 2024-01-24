![Github Image](https://github.com/codehacker74/vault_pass_password_manager/assets/23727704/8f2b287c-f667-4cd7-89f8-d2ac52f54bbd)
Written strictly in Swift, VaultPass is designed to be an offline, account credential vault that makes it simple and secure to store and use usernames and passwords.
For questions, concerns, or complains please email me: codehacker.andrew@gmail.com

# Features
Here are a list of the features that I built into VaultPass as well as some explaintions for their use and any issues I ran into whil developing.
### Security
Accessing your credentials is important to happen by you alone (obviously). The optimal way to keep users out while also not requiring another password to access is to use the respective Apple device's biometric capability. 
The other point of concern is the credentials themselves; VaultPass keeps things encrypted until you actually want to see them. The main screen that is filled with all your credentials is not sitting unencrypted. Only when you should the username and password will these be unencrypted. From first creation to storage to iCloud, at no point in the process is sensitive data unencrypted. 

### Easily accessing credentials
One of the problems that I wanted to solve with my own password manager is quickly accessing usernames and/or passwords to login into the necessary portal. Autofill would be one solution but in case the user does not want to enable this feature or you're attempting logging into a website or app that does not support autofill, then copying and pasting credentials becomes the fastest way to make this happen.

### Autofill
Not many apps seem to use this since only information I had to build Autofill was Apple's documentation. Typically this would be fine but Autofill is a tool that cannot be debugged outside the production flow due to the lack of Autofill's API support. Apple has it tied to their own system tightly which makes it difficult to develop with. However, upon completing this users would be able to easily autofill their

### Automatically adding identifiers
Upon an initial prompt, each time you use a credential from autofill VaultPass will add the url to a list of identifiers for that credential. You can also manually add or remove identifiers from the credential that you used it The lack of this feature is my biggest issue with Apple's password system because while their are some instances where Apple will request to update the identifier you use for your credentials, they do not perform this automatically causing constant Autofill repetitions that would be more easily fixed from automatically updating the identifiers that you use. VaultPass fixes this issue by, upon prompt, always updating the identifiers that you use to login.

### iCloud
In order to access your credentials from multiple devices I wanted to add iCloud support. An issue that arose was the local encryption key must be transferred between devices in order to unencrypt all the credentials then unencrypt each username and password.

### Testing
I attempted to cover as much code as possible with testing but some things (such as Autofill) could not be tested at all. I also began a list of manual tests that needed to be performed prior to a new release.

# Branches
To keep things clean between development, testing, and release three branches were constructed to separate these out.
### dev
Development process of the application and trial sub-branches would be generated to assist in separating out specific features before pushing to dev.
### test
Strictly for testing purposes that gets pushed to Testflight to locally test and to run all the tests as well upon getting merged into from dev. Rarely gets it's own commits but if a test fails or a small mistake happens then a commit will be generated for the fix.
### release
The release of the application to the App Store; this has no other responsibility and only gets a commit for App Store breaking issues.
