extension List {
  // Return a new list with the elements in both lists in order.
  public func concat<C: Collection>(_ collection: C) -> List where C.Element == Element {
    guard count > 0 && collection.count > 0 else { return List() }

    var concatenatedList = clone(self)

    var itr = collection.makeIterator()

    while let element = itr.next() {
      concatenatedList.append(element)
    }

    return concatenatedList
  }
}