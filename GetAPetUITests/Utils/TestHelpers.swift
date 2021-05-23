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

let acceptanceTestsDefaultTimeout: TimeInterval = 5
let acceptanceTestsLongTimeout: TimeInterval = 10

let elementVisiblePredicate = NSPredicate(format: "exists == true AND enabled == true AND hittable = true")
let elementExistsPredicate = NSPredicate(format: "exists == true AND enabled == true")
let elementNonExistentPredicate = NSPredicate(format: "exists == false AND enabled == false AND hittable = false")
let elementNotEnabledPredicate = NSPredicate(format: "enabled == false")

enum SwipeDirection {
  case up, down
}

class GetAPetUIApplication: XCUIApplication {
  let test: XCTestCase
  
  init(_ test: XCTestCase) {
    self.test = test
    super.init()
    }
  
  override func launch() {
    launchEnvironment = [ "UI_TESTS": "YES" ]
    super.launch()
    }
  
  func waitFor(predicate: NSPredicate,
               element: XCUIElement,
               waitTime: TimeInterval? = acceptanceTestsLongTimeout,
               file: String = #file,
               line: Int = #line) {
    let expectation = XCTNSPredicateExpectation(predicate: predicate, object: element)
    
    if (XCTWaiter().wait(for: [expectation], timeout: waitTime!) != .completed) {
      let message = "Failed to find \(element) after \(waitTime!) seconds."
      let issue = XCTIssue(type: .assertionFailure, compactDescription: message)
      self.test.record(issue)
    }
  }
}

