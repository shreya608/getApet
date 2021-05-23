/// Copyright (c) 2021 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation
import XCTest

class TestScreen {
  
  let test: XCTestCase
  let app: GetAPetUIApplication
  
  init(_ robot: Robot) {
    self.app = robot.app
    self.test = robot.test
  }
  
  /// Checks if Screen is displayed to user
  
  func isDisplayed() {
    XCTFail("Screen missing isDisplayed override public!")
  }
  
  /// Checks if the given title is displayed
  
  func has(title: String) {
    XCTAssertTrue(app.navigationBars[title].exists)
  }
  
  /// Checks if the navigation view controller has back button
  
  func hasBackButton() {
    XCTAssertTrue(app.navigationBars["GetAPet.PetDetailView"].buttons["Pet Explorer"].exists)
  }
  
  /// Checks if the given text is displayed
  
  func has(text: String) {
    let textOnScreen = app.staticTexts[text]
    app.waitFor(predicate: elementVisiblePredicate, element: textOnScreen)
  }
  
  /// Checks if the given error text is displayed
  
  func has(errorText: String) {
    let textOnScreen = app.staticTexts[errorText]
    app.waitFor(predicate: elementVisiblePredicate, element: textOnScreen)
  }
  
  /// Checks if the given validation text is displayed
  
  func has(validationText: String) {
    let textOnScreen = app.staticTexts[validationText]
    app.waitFor(predicate: elementVisiblePredicate, element: textOnScreen, waitTime: acceptanceTestsLongTimeout)
  }
  
  /// Checks if the given text is displayed in some capacity
  
  func contains(text: String) {
    let predicate = NSPredicate(format: "label CONTAINS[c] %@", text)
    let result = app.staticTexts.containing(predicate)
    
    app.waitFor(predicate: elementVisiblePredicate, element: result.element, waitTime: acceptanceTestsLongTimeout)
  }
    
  /// Checks if the loading indicator is no longer present
  
  func hasNoLoadingIndicator() {
    let petImage = app.images["spinner"]
    app.waitFor(predicate: elementNonExistentPredicate, element: petImage, waitTime: acceptanceTestsLongTimeout)
  }
  
  /// Asserts next Screen is displayed and returns the new Robot
  
  @discardableResult
  func hasChanged<T: Robot>(to nextRobot: @escaping (GetAPetUIApplication, XCTestCase) -> T) -> T {
    return nextRobot(app, test).assertThat({ screen in
      screen.hasNoLoadingIndicator()
      screen.isDisplayed()
    })
  }
}

