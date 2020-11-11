extension List {
  // Returns a sublist, up to the specified maximum length, containing the initial elements of the list.
  public func prefix(_ n:  Int) -> List {
    guard count > 0 else { return List() }

    var newList = List()

    var i = 0
    var itr = ListIterator(self)

    while i < n, let e = itr.next() {
      newList.append(e)
      i += 1
    }

    return newList
  }

  // Returns a sublist from the start of the list through the specified position.
  public func prefix(through n:  Int) -> List {
    guard count > 0 else { return List() }

    var newList = List()

    var i = 0
    var itr = ListIterator(self)

    while i < n+1, let e = itr.next() {
      newList.append(e)
      i += 1
    }

    return newList
  }

  // Returns a sublist, up to the specified maximum length, containing the initial elements of the list.
  public func prefix(upto n:  Int) -> List {
    guard count > 0 else { return List() }

    var newList = List()

    var i = 0
    var itr = ListIterator(self)

    while i < n, let e = itr.next() {
      newList.append(e)
      i += 1
    }

    return newList
  }

  // Returns a sublist containing the initial elements until predicate returns false and skip the remaining elements.
  public func prefix(while predicate: (Element) throws -> Bool) rethrows -> List {
    guard count > 0 else { return List() }

    var newList = List()

    var itr = ListIterator(self)

    while let e = itr.next(), try predicate(e) {
      newList.append(e)
    }

    return newList
  }
}