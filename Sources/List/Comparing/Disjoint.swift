extension List where Element: Equatable {
  // Returns a Boolean value that indicates whether this list has no members in common with the given list.
  public func disjoint<C: Collection>(_ collection: C) -> Bool where C.Element == Element {
    guard count > 0 else { return true } // empty set is disjoint of any set

    var itr = collection.makeIterator()

    while let e = itr.next() {
      if contains(e) {
        return false
      }
    }

    return true
  }
}