import XCTest
@testable import List

final class FindingTests: XCTestCase {
  func testAllSatisfy() {
    var list = List<Int>(1...5)

    XCTAssertTrue(list.allSatisfy { $0 < 6 })
    XCTAssertFalse(list.allSatisfy { $0 % 2 == 0 })
    XCTAssertFalse(list.allSatisfy { $0 % 2 == 1 })

    list.removeAll()
  }

  func testContains() {
    var list = List<Int>(1...5)

    XCTAssertTrue(list.contains { $0 < 6 })
    XCTAssertTrue(list.contains { $0 % 2 == 0 })
    XCTAssertTrue(list.contains { $0 % 2 == 1 })

    list.removeAll()
  }

  func testIndices() {
    var list = List<Int>(1...6)

    XCTAssertEqual(list.indices(of: 1, 2, 3), [0, 1, 2])
    XCTAssertEqual(list.indices(of: 1, 3, 5), [0, 2, 4])
    XCTAssertEqual(list.indices(of: 2, 4, 6), [1, 3, 5])

    list.removeAll()
  }

  static var allTests = [
    ("testAllSatisfy", testAllSatisfy),
    ("testContains", testContains),
    ("testIndices", testIndices),
  ]
}
