extension List where Element: Equatable {
  // Returns a new list with the unique elements of both this list and the given list.
  public func union<C: Collection>(_ collection: C) -> List where C.Element == Element {
    var newList = unique()

    var itr = collection.makeIterator()

    while let e = itr.next() {
      if !newList.contains(e) {
        newList.append(e)
      }
    }

    return newList
  }
}