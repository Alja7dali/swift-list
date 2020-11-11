extension List {
  public func compactMap<T>(_ transform: @escaping (Element) throws -> T?) rethrows -> List<T> {
    if count == 0 { return List<T>() }
    var mappedListPointer = List<T>()

    var itr = ListIterator(self)

    while let element = itr.next() {
      if let newElement = try transform(element) {
        mappedListPointer.append(newElement)
      }
    }

    return mappedListPointer
  }
}
