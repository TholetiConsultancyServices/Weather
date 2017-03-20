# Weather iOS Test App
An iPhone app for iOS 10 that displays the 5-day weather forecast for the current location of the device.

## How to Run, Build and Test

- The project can be run using Xcode 8.2 and built/tested using the standard Xcode build (⌘B) and test (⌘U) commands.
- Local weather JSON file is embedded in the test target to run the tests without relying on the network. 

## Summary of implementation details:

- Developed the App using Xcode 8.2 and Swift 3.0.

- Used location service to find the current location of the device to fetch the weather information.

- Main focus on implementing right architecture, design patterns and performance of the App.

- Implemented UI modules using storyboards and auto layouts.

- Followed VIPER based architecture and MVC design patterns.

- Used dependency injection across the App to facilitate the unit testing of the classes.

- Implemented unit tests using XCTestCase and Mock Objects.

- Used NSURLSession for network operations.

- Used ObjectMapper framework for parsing JSON data.

- Used Reachability framework for network availability check.

- Added refresh Data option

- Added support to run in both landscape and portrait mode

- Provided API documentation.

## Further Improvements

The following are some of the improvements to the project that should be made given more time:

- Eye-catching UI elements
- Persist weather data to display in offline mode
- Custom Forecast cell for more advanced layout of forecast information
- Parse and show more forecast info such as wind direction and humidity
- More unit tests for a complete coverage
- UI tests

