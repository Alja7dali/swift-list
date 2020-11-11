extension List where Element: Equatable {
  // Returns a Boolean value that indicates whether this list equivalent to the given list.
  public func equals<C: Collection>(_ collection: C) -> Bool where C.Element == Element {
    guard count == collection.count else { return false }

    var x = ListIterator(self)
    var y = collection.makeIterator()

    while let e1 = x.next(), let e2 = y.next() {
      if e1 != e2 {
        return false
      }
    }

    return true
  }
}