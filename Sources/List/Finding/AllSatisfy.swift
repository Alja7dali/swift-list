extension List where Element: Equatable {
  // Returns a Boolean value indicating whether every element of a list satisfies the given predicate.
  public func allSatisfy(_ predicate: (Element) throws -> Bool) rethrows -> Bool {
    guard count > 0 else { return false }

    var itr = ListIterator(self)

    while let e = itr.next() {
      if try !predicate(e) {
        return false
      }
    }

    return true
  }
}