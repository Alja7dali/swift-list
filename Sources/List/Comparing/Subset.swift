extension List where Element: Equatable {
  // Returns a Boolean value that indicates whether this list is a subset of the given list.
  public func subset<C: Collection>(_ collection: C) -> Bool where C.Element == Element {
    guard count > 0 else { return true } // empty set is subset of any set

    var itr = ListIterator(self)

    while let e = itr.next() {
      if !collection.contains(e) {
        return false
      }
    }
    
    return true
  }
}