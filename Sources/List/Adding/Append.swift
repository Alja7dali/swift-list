extension List {
  // Adds a new element at the end of the list.
  public mutating func append(_ element: Element) {
    let newSlice = allocate(element)
    
    if first != nil {
      newSlice.pointee.npxAddr = xor(lastNode, nil)
      lastNode.pointee.npxAddr = xor(newSlice, xor(lastNode?.pointee.npxAddr, nil))
      lastNode = newSlice
    } else {
      lastNode = newSlice
      firstNode = newSlice
    }

    count = count + 1
  }
  
  // Adds a new elements at the end of the list.  
  public mutating func append(_ sequence: Element ...) {
    return append(sequence)
  }

  public mutating func append<S: Sequence>(_ sequence: S) where S.Element == Element {
    var itr = sequence.makeIterator()

    if let element = itr.next() {
      var newSlice = allocate(element)
      
      if first != nil {
        newSlice.pointee.npxAddr = xor(lastNode, nil)
        lastNode.pointee.npxAddr = xor(newSlice, xor(lastNode?.pointee.npxAddr, nil))
        lastNode = newSlice
      } else {
        lastNode = newSlice
        firstNode = newSlice
      }

      count = count + 1

      while let element = itr.next() {
        newSlice = allocate(element)
        newSlice.pointee.npxAddr = xor(lastNode, nil)
        lastNode.pointee.npxAddr = xor(newSlice, xor(lastNode?.pointee.npxAddr, nil))
        lastNode = newSlice
        count = count + 1
      }
    }
  }
}
