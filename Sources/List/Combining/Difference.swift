extension List where Element: Equatable {
  // Returns a new list containing the unique elements of this list that do not occur in the given list.
  public func difference<C: Collection>(_ collection: C) -> List where C.Element == Element {
    var newList = List()

    var itr = ListIterator(self)

    while let e = itr.next() {
      if !collection.contains(e) {
        newList.append(e)
      }
    }

    return newList
  }
}