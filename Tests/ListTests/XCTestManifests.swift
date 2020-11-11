import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
  return [
    testCase(AddingTests.allTests),
    testCase(CombiningTests.allTests),
    testCase(ComparingTests.allTests),
    testCase(CopyingTests.allTests),
    testCase(ExcludingTests.allTests),
    testCase(FindingTests.allTests),
    testCase(ModifyingTests.allTests),
    testCase(ReorderingTests.allTests),
  ]
}
#endif
