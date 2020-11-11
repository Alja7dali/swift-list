extension List where Element: Equatable {
  public func indices(of sequence: Element ...) -> Array<Int> {
    return indices(of: sequence)
  }

  public func indices<C: Collection>(of collection: C) -> Array<Int> where C.Element == Element {
    var indices = Array<Int>()
    
    var itr = collection.makeIterator()
  
    while let e = itr.next() {
      if let i = firstIndex(of: e) {
        indices.append(i)
      }
    }

    return indices
  }
}