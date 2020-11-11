extension List {
  // Returns a sublist containing all but the given number of initial elements.
  public func dropFirst(_ n: Int) -> List {
    guard count > 0 else { return List() }

    let index = fixIndex(n, count)

    var newList = List()

    var i = 0
    var itr = ListIterator(self)

    while i < index, itr.next() != nil {
      i += 1
    }

    while let e = itr.next() {
      newList.append(e)
    }

    return newList
  }

  // Returns a sublist containing all but the specified number of final elements.
  public func dropLast(_ n: Int) -> List {
    guard count > 0 else { return List() }

    let index = fixIndex(n, count)

    var newList = List()

    var i = 0
    var itr = ListReversedIterator(self)

    while i < index, itr.next() != nil {
      i += 1
    }

    while let e = itr.next() {
      newList.prepend(e)
    }

    return newList
  }

  // Returns a sublist by skipping elements while predicate returns true and returning the remaining items.
  public func drop(while predicate: (Element) -> Bool) -> List {
    guard count > 0 else { return List() }

    var newList = List()

    var itr = ListIterator(self)

    var rescued: Element! = nil

    while let e = itr.next() {
      if !predicate(e) {
        rescued = e // rescue this element to be added since it did not meet the predicate
        break
      }
    }

    if rescued != nil {
      newList.append(rescued)
    }

    while let e = itr.next() {
      newList.append(e)
    }

    return newList
  }

  // Returns a new list containing the elements of the list that satisfy the given predicate.
  public func filter(_ predicate: (Element) throws -> Bool) rethrows -> List {
    guard count > 0 else { return List() }

    var newList = List()

    var itr = ListIterator(self)

    while let e = itr.next() {
      if try predicate(e) {
        newList.append(e)
      }
    }

    return newList
  }
}