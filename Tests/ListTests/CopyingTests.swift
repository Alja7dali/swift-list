import XCTest
@testable import List

final class CopyingTests: XCTestCase {
  func testCopy() {
    var listX = List<Int>(1...5)
    var listY = listX.copy()
    listY.rotateLeft()

    XCTAssertEqual(Array(listX), Array(1...5))
    XCTAssertEqual(Array(listY), Array(2...5) + [1])

    listX.removeAll()
    listY.removeAll()
  }

  func testSlice() {
    var listX = List<Int>(1...5)
    var listY1 = listX.slice(-2, 2)
    var listY2 = listX[listX.count-2...listX.count-1] + listX[0...2]
    var listZ1 = listX.slice(0, 1)
    var listZ2 = listX[0...1]
    var listW1 = listX.slice(3, 4)
    var listW2 = listX[listX.count-2...listX.count-1]

    XCTAssertEqual(Array(listY1), [4, 5, 1, 2, 3])
    XCTAssertEqual(Array(listY1), Array(listY2))
    XCTAssertEqual(Array(listZ1), [1, 2])
    XCTAssertEqual(Array(listZ1), Array(listZ2))
    XCTAssertEqual(Array(listW1), [4, 5])
    XCTAssertEqual(Array(listW1), Array(listW2))

    listX.removeAll()
    listY1.removeAll()
    listY2.removeAll()
    listZ1.removeAll()
    listZ2.removeAll()
    listW1.removeAll()
    listW2.removeAll()
  }

  static var allTests = [
    ("testCopy", testCopy),
    ("testSlice", testSlice),
  ]
}
