extension List {
  public func flatMap<S: Sequence>(_ transform: (Element) throws -> S) rethrows -> List<S.Element> {
    if count == 0 { return List<S.Element>() }
    var mappedListPointer = List<S.Element>()

    var itr = ListIterator(self)

    while let element = itr.next() {
      var subItr = try transform(element).makeIterator()
      while let newElement = subItr.next() {
        mappedListPointer.append(newElement)
      }
    }

    return mappedListPointer
  }
}
