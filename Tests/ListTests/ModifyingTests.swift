import XCTest
@testable import List

final class ModifyingTests: XCTestCase {
  func testFill() {
    var listX = List<Int>(1...5)
    listX.fill(0)
    var listY = listX.filled(1)

    XCTAssertTrue(listX.allSatisfy { $0 == 0 })
    XCTAssertTrue(listY.allSatisfy { $0 == 1 })

    listX.removeAll()
    listY.removeAll()
  }

  func testReplace() {
    var listX = List<Int>(1...6)
    listX.replace(-2, 2, with: 0) // listX.replace(listX.count-2, listX.count-1, with: 0); listX.replace(0, 2, with: 0)

    var listY = List<Int>(1...6)
    listY.replace(2, -2, with: 0) // listY.replace(2, listY.count-2, with: 0)

    var listZ = List<Int>(1...6)
    listZ.replace(2, 2, with: 0) // listZ.replace(at: 2, with: 0)

    var listW = List<Int>(1...6)
    listW.replace(0, 2, with: 0)

    var listP = List<Int>(1...6)
    listP.replace(3, 5, with: 0)

    XCTAssertEqual(Array(listX), [0, 0, 0, 4, 0, 0])
    XCTAssertEqual(Array(listY), [1, 2, 0, 0, 0, 6])
    XCTAssertEqual(Array(listZ), [1, 2, 0, 4, 5, 6])
    XCTAssertEqual(Array(listW), [0, 0, 0, 4, 5, 6])
    XCTAssertEqual(Array(listP), [1, 2, 3, 0, 0, 0])

    listX.removeAll()
    listY.removeAll()
    listZ.removeAll()
    listW.removeAll()
    listP.removeAll()
  }

  func testReplaced() {
    var list = List<Int>(1...6)

    var listX = list.replaced(-2, 2, with: 0) // listX.replace(listX.count-2, listX.count-1, with: 0); listX.replace(0, 2, with: 0)

    var listY = list.replaced(2, -2, with: 0) // listY.replace(2, listY.count-2, with: 0)

    var listZ = list.replaced(2, 2, with: 0) // listZ.replace(at: 2, with: 0)

    var listW = list.replaced(0, 2, with: 0)

    var listP = list.replaced(3, 5, with: 0)

    XCTAssertEqual(Array(listX), [0, 0, 0, 4, 0, 0])
    XCTAssertEqual(Array(listY), [1, 2, 0, 0, 0, 6])
    XCTAssertEqual(Array(listZ), [1, 2, 0, 4, 5, 6])
    XCTAssertEqual(Array(listW), [0, 0, 0, 4, 5, 6])
    XCTAssertEqual(Array(listP), [1, 2, 3, 0, 0, 0])

    list.removeAll()
    listX.removeAll()
    listY.removeAll()
    listZ.removeAll()
    listW.removeAll()
    listP.removeAll()
  }

  static var allTests = [
    ("testFill", testFill),
    ("testReplace", testReplace),
    ("testReplaced", testReplaced),
  ]
}
