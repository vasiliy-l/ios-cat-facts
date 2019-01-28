# CatFacts iOS Application

Simple iOS application for reading different cat facts from a [demo resource](https://cat-fact.herokuapp.com/facts), written in Swift.

![](Screenshots/1-login-logout.gif) ![](Screenshots/2-registration.gif)

![](Screenshots/3-session-saving.gif) ![](Screenshots/4-incorrect-data.gif)

Main features:
1. Local user registration and authorization ([Core Data](https://developer.apple.com/documentation/coredata)); input data validation.
2. User session storing in the application ([Keychain Services](https://developer.apple.com/documentation/security/keychain_services)).
3. Data fetching from the internet.

List of CocoaPods dependencies used in the project:
1. [Alamofire](https://cocoapods.org/pods/Alamofire) for networking.
2. [SwiftyJSON](https://cocoapods.org/pods/SwiftyJSON) for working with data in JSON format.
3. [SwiftKeychainWrapper](https://cocoapods.org/pods/SwiftKeychainWrapper) to simplify the work with iOS Keychain.

## Usage
1. Download the repository
```
$ git clone https://github.com/vasiliy-l/ios-cat-facts.git
$ cd ios-cat-facts
```
2. Open the project in Xcode
```
$ open CatFacts.xcworkspace
```
3. Compile and run the application

# Requirements
- Xcode 10.1
- iOS 12.1
