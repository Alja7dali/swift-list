import XCTest
@testable import List

final class CombiningTests: XCTestCase {
  func testConcat() {
    var listX = List<Int>(1...5)
    var listY = List<Int>(6...10)
    var listZ = listX.concat(listY)

    XCTAssertEqual(Array(listZ), Array(1...10))
    XCTAssertEqual(listZ.count, 10)

    listX.removeAll()
    listY.removeAll()
    listZ.removeAll()
  }

  func testDifference() {
    var listX = List<Int>(1...4)
    var listY = List<Int>(3...6)
    var listZ = listX.difference(listY)
    var listW = listY.difference(listX)

    XCTAssertEqual(Array(listZ), [1, 2])
    XCTAssertEqual(listZ.count, 2)

    XCTAssertEqual(Array(listW), [5, 6])
    XCTAssertEqual(listW.count, 2)

    listX.removeAll()
    listY.removeAll()
    listZ.removeAll()
    listW.removeAll()
  }

  func testIntersect() {
    var listX = List<Int>(1...4)
    var listY = List<Int>(3...6)
    var listZ = listX.intersect(listY)
    var listW = listY.intersect(listX)

    XCTAssertEqual(Array(listZ), [3, 4])
    XCTAssertEqual(listZ.count, 2)

    XCTAssertEqual(Array(listW), [3, 4])
    XCTAssertEqual(listW.count, 2)

    listX.removeAll()
    listY.removeAll()
    listZ.removeAll()
    listW.removeAll()
  }

  func testUnion() {
    var listX = List<Int>(1...4)
    var listY = List<Int>(3...6)
    var listZ = listX.union(listY)
    var listW = listY.union(listX)

    XCTAssertEqual(Array(listZ), Array(1...6))
    XCTAssertEqual(listZ.count, 6)

    XCTAssertEqual(Array(listW), Array(3...6) + Array(1...2))
    XCTAssertEqual(listW.count, 6)

    listX.removeAll()
    listY.removeAll()
    listZ.removeAll()
    listW.removeAll()
  }

  static var allTests = [
    ("testConcat", testConcat),
    ("testDifference", testDifference),
    ("testIntersect", testIntersect),
    ("testUnion", testUnion),
  ]
}
