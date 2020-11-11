extension List {
  public func reduce<Result>(_ initialResult: Result, _ nextPartialResult: @escaping (Result, Element) throws -> Result) rethrows -> Result {
    if count == 0 { return initialResult }
    var initialResult = initialResult

    var itr = ListIterator(self)

    while let element = itr.next() {
      initialResult = try nextPartialResult(initialResult, element)
    }

    return initialResult
  }
}
