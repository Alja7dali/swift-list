extension List {
  // Calls the given closure on each element in the list in the same order as a for-in loop.
  public func forEach(_ closure: (Element) throws -> Void) rethrows {
    guard count > 0 else { return }

    var itr = ListIterator(self)

    while let e = itr.next() {
      try closure(e)
    }
  }
}