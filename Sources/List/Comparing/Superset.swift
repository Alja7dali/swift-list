extension List where Element: Equatable {
  // Returns a Boolean value that indicates whether this list is a superset of the given list.
  public func superset<C: Collection>(_ collection: C) -> Bool where C.Element == Element {
    guard count > 0 else { return false } // empty set is not superset of any set

    var itr = collection.makeIterator()

    while let e = itr.next() {
      if !contains(e) {
        return false
      }
    }
    
    return true
  }
}