extension List where Element: Equatable {
  // Returns the last element of the list that satisfies the given predicate, will return nil otherwise.
  public func last(where predicate: (Element) throws -> Bool) rethrows -> Element? {
    guard count > 0 else { return nil }

    var itr = ListReversedIterator(self)

    while let e = itr.next() {
      if try predicate(e) {
        return e
      }
    }

    return nil
  }

  // Returns the last index where the specified value appears in the list.
  public func lastIndex(of element: Element) -> Int? {
    guard count > 0 else { return nil }

    var i = count-1
    var itr = ListReversedIterator(self)

    while let e = itr.next() {
      if e == element {
        return i
      }
      i -= 1
    }

    return nil
  }

  // Returns the last index where the specified value appears in the list.
  public func lastIndex(where predicate: (Element) throws -> Bool) rethrows -> Int? {
    guard count > 0 else { return nil }

    var i = count-1
    var itr = ListReversedIterator(self)

    while let e = itr.next() {
      if try predicate(e) {
        return i
      }
      i -= 1
    }

    return nil
  }
}