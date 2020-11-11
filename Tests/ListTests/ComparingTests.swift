import XCTest
@testable import List

final class ComparingTests: XCTestCase {
  func testCompare() {
    var listX1 = List<Int>(1...5)
    var listY1 = List<Int>(6...10)
    let diff1 = listX1.compare(listY1)

    var listX2 = List<Int>(1...5)
    var listY2 = List<Int>(6...9)
    let diff2 = listX2.compare(listY2)

    var listX3 = List<Int>(2...5)
    var listY3 = List<Int>(6...10)
    let diff3 = listX3.compare(listY3)

    XCTAssertEqual(diff1, 0)
    XCTAssertEqual(diff2, 1)
    XCTAssertEqual(diff3, -1)

    listX1.removeAll()
    listY1.removeAll()
    listX2.removeAll()
    listY2.removeAll()
    listX3.removeAll()
    listY3.removeAll()
  }

  func testDisjoint() {
    var listX1 = List<Int>(1...5)
    var listY1 = List<Int>(6...10)
    let disjoint1 = listX1.disjoint(listY1)

    var listX2 = List<Int>(1...5)
    var listY2 = List<Int>(5...10)
    let disjoint2 = listX2.disjoint(listY2)

    XCTAssertTrue(disjoint1)
    XCTAssertFalse(disjoint2)

    listX1.removeAll()
    listY1.removeAll()
    listX2.removeAll()
    listY2.removeAll()
  }

  func testEquals() {
    var listX1 = List<Int>(1...5)
    var listY1 = List<Int>(1...5)
    let equals1 = listX1.equals(listY1)

    var listX2 = List<Int>(1...5)
    var listY2 = List<Int>(5...10)
    let equals2 = listX2.equals(listY2)

    XCTAssertTrue(equals1)
    XCTAssertFalse(equals2)

    listX1.removeAll()
    listY1.removeAll()
    listX2.removeAll()
    listY2.removeAll()
  }

  func testSubset() {
    var listX1 = List<Int>(1...5)
    var listY1 = List<Int>(1...5)
    let subset1 = listX1.subset(listY1)

    var listX2 = List<Int>(2...4)
    var listY2 = List<Int>(1...5)
    let subset2 = listX2.subset(listY2)

    var listX3 = List<Int>(1...5)
    var listY3 = List<Int>(2...6)
    let subset3 = listX3.subset(listY3)

    XCTAssertTrue(subset1)
    XCTAssertTrue(subset2)
    XCTAssertFalse(subset3)

    listX1.removeAll()
    listY1.removeAll()
    listX2.removeAll()
    listY2.removeAll()
    listX3.removeAll()
    listY3.removeAll()
  }

  func testSuperset() {
    var listX1 = List<Int>(1...5)
    var listY1 = List<Int>(1...5)
    let superset1 = listX1.superset(listY1)

    var listX2 = List<Int>(1...5)
    var listY2 = List<Int>(2...4)
    let superset2 = listX2.superset(listY2)

    var listX3 = List<Int>(1...5)
    var listY3 = List<Int>(2...6)
    let superset3 = listX3.superset(listY3)

    XCTAssertTrue(superset1)
    XCTAssertTrue(superset2)
    XCTAssertFalse(superset3)

    listX1.removeAll()
    listY1.removeAll()
    listX2.removeAll()
    listY2.removeAll()
    listX3.removeAll()
    listY3.removeAll()
  }

  static var allTests = [
    ("testCompare", testCompare),
    ("testDisjoint", testDisjoint),
    ("testEquals", testEquals),
    ("testSubset", testSubset),
    ("testSuperset", testSuperset),
  ]
}
