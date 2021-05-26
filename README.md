# GetAPet Automation

Automation has been written for GetAPet app using `XCUITest` and [Robot Framework](https://robotframework.org/)

## How to run?

- Clone the repo and open the project in Xcode
- Goto the folder GetAPetUITests
- The files inside the folder have the testsfiles 

## Framework Overview

The test is written for 2 screens:
   * A Pet Explorer Screen which has the list of pets
   * The screen to adopt the pet

The test framwork is divided into 3 parts:

- Utils:

A helper class where the test is initialised and has some common functionalities which will be used throughout the test like default wait time and asynchronus wait for element.

- Robots:

A base Robot class that contains some common functions like asserting elements exist and tapping on the screen. Each screen then have its own Robot class that extends Robot. These screen-specific Robots contain actions specific to that screen.

- Tests:

These then helped in writing the tests.



