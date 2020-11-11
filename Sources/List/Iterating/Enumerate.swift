extension List {
  // Traverse a list of pairs (n, x), where n represents a consecutive integer starting at zero and x represents an element of the list.
  public func enumerate(_ closure: (Int, Element) throws -> Void) rethrows {
    guard count > 0 else { return }

    var i = 0
    var itr = ListIterator(self)

    while let e = itr.next() {
      try closure(i, e)
      i += 1
    }
  }
}