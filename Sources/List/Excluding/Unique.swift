extension List where Element: Equatable {
  // Returns a new list containing the unique elements of this list.
  public func unique() -> List {
    guard count > 0 else { return List() }

    var newList = List()

    var itr = ListIterator(self)

    while let e = itr.next() {
      if !newList.contains(e) {
        newList.append(e)
      }
    }

    return newList
  }
}