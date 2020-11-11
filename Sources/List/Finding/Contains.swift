extension List where Element: Equatable {
  // Returns a Boolean value indicating whether the list contains the given element.
  public func contains(_ element: Element) -> Bool {
    guard count > 0 else { return false }

    var itr = ListIterator(self)

    while let e = itr.next() {
      if e == element {
        return true
      }
    }

    return false
  }

  // Returns a Boolean value indicating whether the list contains an element that satisfies the given predicate.
  public func contains(where predicate: (Element) throws -> Bool) rethrows -> Bool {
    guard count > 0 else { return false }

    var itr = ListIterator(self)

    while let e = itr.next() {
      if try predicate(e) {
        return true
      }
    }

    return false
  }
}