extension List {
  // Returns a sublist, up to the given maximum length, containing the final elements of the list.
  public func suffix(_ n:  Int) -> List {
    guard count > 0 else { return List() }

    var newList = List()

    var i = 0
    var itr = ListReversedIterator(self)

    while i < n, let e = itr.next() {
      newList.prepend(e)
      i += 1
    }

    return newList
  }

  // Returns a sublist from the specified position to the end of the list.
  public func suffix(from n:  Int) -> List {
    guard count > 0 else { return List() }

    var newList = List()

    var i = 0
    var itr = ListIterator(self)

    while i < n, itr.next() != nil {
      i += 1
    }

    while let e = itr.next() {
      newList.append(e)
    }

    return newList
  }

  // Returns a sublist containing the final elements until predicate returns false and skip the initial elements.
  public func suffix(while predicate: (Element) throws -> Bool) rethrows -> List {
    guard count > 0 else { return List() }

    var newList = List()

    var itr = ListReversedIterator(self)

    while let e = itr.next(), try predicate(e) {
      newList.prepend(e)
    }

    return newList
  }
}