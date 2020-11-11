extension List where Element: Equatable {
  // Returns the first element of the list that satisfies the given predicate, will return nil otherwise.
  public func first(where predicate: (Element) throws -> Bool) rethrows -> Element? {
    guard count > 0 else { return nil }

    var itr = ListIterator(self)

    while let e = itr.next() {
      if try predicate(e) {
        return e
      }
    }

    return nil
  }

  // Returns the first index where the specified value appears in the list.
  public func firstIndex(of element: Element) -> Int? {
    guard count > 0 else { return nil }

    var i = 0
    var itr = ListIterator(self)

    while let e = itr.next() {
      if e == element {
        return i
      }
      i += 1
    }

    return nil
  }

  // Returns the first index where the specified value appears in the list.
  public func firstIndex(where predicate: (Element) throws -> Bool) rethrows -> Int? {
    guard count > 0 else { return nil }

    var i = 0
    var itr = ListIterator(self)

    while let e = itr.next() {
      if try predicate(e) {
        return i
      }
      i += 1
    }

    return nil
  }
}