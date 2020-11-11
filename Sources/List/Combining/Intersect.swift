extension List where Element: Equatable {
  // Returns a new list with the unique elements that are common to both this list and the given list.
  public func intersect<C: Collection>(_ collection: C) -> List where C.Element == Element {
    var newList = List()

    var itr = ListIterator(self)

    while let e = itr.next() {
      if collection.contains(e) {
        newList.append(e)
      }
    }

    return newList
  }
}