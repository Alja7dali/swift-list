import XCTest
@testable import List

final class SelectingTests: XCTestCase {
  func testPartition() {
    var list = List<Int>(1...6)
    let pivotIndex = list.partition(by: { $0 % 2 == 0 })

    XCTAssertEqual(Array(list), [5, 3, 1, 2, 4, 6])
    XCTAssertEqual(pivotIndex, 3)

    list.removeAll()
  }

  func testReverse() {
    var list = List<Int>(1...6)
    list.reverse()

    XCTAssertEqual(Array(list), Array(1...6).reversed())

    list.removeAll()
  }

  func testReversed() {
    var list = List<Int>(1...6)
    var listX = list.reversed()

    XCTAssertEqual(Array(list), Array(1...6))
    XCTAssertEqual(Array(listX), Array(1...6).reversed())

    list.removeAll()
    listX.removeAll()
  }

  func testSwapAt() {
    var list = List<Int>(1...6)
    list.swapAt(2, -2)
    var arr = Array(1...6)
    arr.swapAt(2, arr.count-2)

    XCTAssertEqual(Array(list), arr)

    list.removeAll()
  }

  static var allTests = [
    ("testPartition", testPartition),
    ("testReverse", testReverse),
    ("testReversed", testReversed),
    ("testSwapAt", testSwapAt),
  ]
}
