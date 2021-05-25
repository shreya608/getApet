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

class Robot {
  
  let test: XCTestCase
  let app: GetAPetUIApplication
  
  init(app: GetAPetUIApplication, test: XCTestCase) {
    self.app = app
    self.test = test
  }
  /// Override with specific Screen class if required public
  @discardableResult
  func assertThat(_ screen: @escaping ((TestScreen) -> Void)) -> Self {
    screen(TestScreen(self))
    return self
  }
  
  /// For screen change assertions
  @discardableResult
  func assertThat<T: Robot>(_ screen: @escaping ((TestScreen) -> T)) -> T {
    return screen(TestScreen(self))
  }
  
  @discardableResult
  func swipeUp() -> Self {
    app.swipeUp()
    return self
  }
  
  @discardableResult
  func swipeDown() -> Self {
    app.swipeDown()
    return self
  }
  
  @discardableResult
  func swipeTo(element: XCUIElement, direction: SwipeDirection = SwipeDirection.up) -> Self {
    // This needs to be fixed.
    let yCoord = (direction == SwipeDirection.up) ? -262.0 : 262.0
    
    while !element.firstMatch.isHittable {
      let startCoord = app.tables.element.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
      let endCoord = startCoord.withOffset(CGVector(dx: 0.0, dy: yCoord))
      startCoord.press(forDuration: 0.01, thenDragTo: endCoord)
    }
    return self
  }
  
  @discardableResult
  func swipeTo(text: String, direction: SwipeDirection = SwipeDirection.up) -> Self {
    let element = app.collectionViews.staticTexts[text]
    swipeTo(element: element, direction: direction)
    return self
  }
  
  func tap(text: String) -> Self {
    app.staticTexts[text].tap()
    return self
  }
  
  @discardableResult
  func tapBack() -> Self {
    app.navigationBars["GetAPet.PetDetailView"].buttons["Pet Explorer"].tap()
    return self
  }
  
  func type(text: String) -> Self {
    app.typeText(text)
    return self
  }
  
  func tapCollectionViewElement(text: String) {
    let collectionViewsQuery = app.collectionViews
    collectionViewsQuery.buttons[text].otherElements.containing(.staticText,identifier:text).element.tap()
  }
  
  func tapCollectionViewStatictext(text: String) {
    app.collectionViews.staticTexts[text].tap()
  }
  
  func tapDropDown(text:String){
    app.collectionViews["View"].otherElements[text].tap()
  }
  
  func tapStatictext(text: String) {
    app.staticTexts[text].tap()
  }

  func waitForLoadingIndicator() {
    let pet = app.staticTexts["petName"]
    app.waitFor(predicate: elementNonExistentPredicate, element: pet, waitTime: acceptanceTestsLongTimeout)
  }
}

