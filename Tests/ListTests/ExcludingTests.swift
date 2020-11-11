import XCTest
@testable import List

final class ExcludingTests: XCTestCase {
  func testDelete() {
    var listX = List<Int>(1...6)
    listX.delete(-2, 2) // listX.delete(listX.count-2, listX.count-1); listX.delete(0, 2)

    var listY = List<Int>(1...6)
    listY.delete(2, -2) // listY.delete(2, listY.count-2)

    var listZ = List<Int>(1...6)
    listZ.delete(2, 2) // listZ.delete(at: 2)

    var listW = List<Int>(1...6)
    listW.delete(0, 2)

    var listP = List<Int>(1...6)
    listP.delete(3, 5)

    XCTAssertEqual(Array(listX), [4])
    XCTAssertEqual(listX.count, 1)
    XCTAssertEqual(Array(listY), [1, 2, 6])
    XCTAssertEqual(listY.count, 3)
    XCTAssertEqual(Array(listZ), [1, 2, 4, 5, 6])
    XCTAssertEqual(listZ.count, 5)
    XCTAssertEqual(Array(listW), [4, 5, 6])
    XCTAssertEqual(listW.count, 3)
    XCTAssertEqual(Array(listP), [1, 2, 3])
    XCTAssertEqual(listP.count, 3)

    listX.removeAll()
    listY.removeAll()
    listZ.removeAll()
    listW.removeAll()
    listP.removeAll()
  }

  func testDrop() {
    var list = List<Int>(1...6)
    var listX = list.dropFirst(2)
    var listY = list.dropLast(2)
    var listZ = list.drop { $0 < 3 } // list.dropFirst(2)
    var listW = list.filter { $0 > 2 } // list.dropFirst(2)

    XCTAssertEqual(Array(listX), [3, 4, 5, 6])
    XCTAssertEqual(listX.count, 4)
    XCTAssertEqual(Array(listY), [1, 2, 3, 4])
    XCTAssertEqual(listY.count, 4)
    XCTAssertEqual(Array(listZ), [3, 4, 5, 6])
    XCTAssertEqual(listZ.count, 4)
    XCTAssertEqual(Array(listW), [3, 4, 5, 6])
    XCTAssertEqual(listW.count, 4)

    list.removeAll()
    listX.removeAll()
    listY.removeAll()
    listZ.removeAll()
    listW.removeAll()
  }

  func testRemove() {
    var listX = List<Int>(1...6)
    var listX1 = listX.remove(-2, 2) // listX.remove(listX.count-2, listX.count-1); listX.remove(0, 2)

    var listY = List<Int>(1...6)
    var listY1 = listY.remove(2, -2) // listY.remove(2, listY.count-2)

    var listZ = List<Int>(1...6)
    var listZ1 = listZ.remove(2, 2) // listZ.remove(at: 2)

    var listW = List<Int>(1...6)
    var listW1 = listW.remove(0, 2)

    var listP = List<Int>(1...6)
    var listP1 = listP.remove(3, 5)

    XCTAssertEqual(Array(listX), [4])
    XCTAssertEqual(listX.count, 1)
    XCTAssertEqual(Array(listY), [1, 2, 6])
    XCTAssertEqual(listY.count, 3)
    XCTAssertEqual(Array(listZ), [1, 2, 4, 5, 6])
    XCTAssertEqual(listZ.count, 5)
    XCTAssertEqual(Array(listW), [4, 5, 6])
    XCTAssertEqual(listW.count, 3)
    XCTAssertEqual(Array(listP), [1, 2, 3])
    XCTAssertEqual(listP.count, 3)

    XCTAssertEqual(Array(listX1), [5, 6, 1, 2, 3])
    XCTAssertEqual(listX1.count, 5)
    XCTAssertEqual(Array(listY1), [3, 4, 5])
    XCTAssertEqual(listY1.count, 3)
    XCTAssertEqual(Array(listZ1), [3])
    XCTAssertEqual(listZ1.count, 1)
    XCTAssertEqual(Array(listW1), [1, 2, 3])
    XCTAssertEqual(listW1.count, 3)
    XCTAssertEqual(Array(listP1), [4, 5, 6])
    XCTAssertEqual(listP1.count, 3)

    listX.removeAll()
    listY.removeAll()
    listZ.removeAll()
    listW.removeAll()
    listP.removeAll()

    listX1.removeAll()
    listY1.removeAll()
    listZ1.removeAll()
    listW1.removeAll()
    listP1.removeAll()
  }

  func testUnique() {
    var listX = List<Int>()
    for i in 1...5 {
      listX.append(1...i)
    }

    var listY = listX.unique()

    XCTAssertEqual(Array(listX), [1, 1, 2, 1, 2, 3, 1, 2, 3, 4, 1, 2, 3, 4, 5])
    XCTAssertEqual(listX.count, Array(1...5).reduce(0, +))
    XCTAssertEqual(Array(listY), Array(1...5))
    XCTAssertEqual(listY.count, 5)

    listX.removeAll()
    listY.removeAll()
  }

  static var allTests = [
    ("testDelete", testDelete),
    ("testDrop", testDrop),
    ("testRemove", testRemove),
    ("testUnique", testUnique),
  ]
}
