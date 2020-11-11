import XCTest
@testable import List

final class AddingTests: XCTestCase {
  func testAppend() {
    var list = List<Int>()

    list.append(1)
    list.append(2...9)
    list.append(10)

    XCTAssertEqual(Array(list), Array(1...10))
    XCTAssertEqual(list.count, 10)

    list.removeAll()
  }

  func testPrepend() {
    var list = List<Int>()

    list.prepend(1)
    list.prepend(2...9)
    list.prepend(10)

    XCTAssertEqual(Array(list), Array(1...10).reversed())
    XCTAssertEqual(list.count, 10)

    list.removeAll()
  }

  func testInsert() {
    var list = List<Int>()

    list.insert(1, at: 0)
    list.insert((2...9).reversed(), at: 0)
    list.insert(10, at: 0)

    XCTAssertEqual(Array(list), [10] + Array(2...9) + [1])
    XCTAssertEqual(list.count, 10)

    list.removeAll()
  }

  static var allTests = [
    ("testAppend", testAppend),
    ("testPrepend", testPrepend),
    ("testInsert", testInsert),
  ]
}
