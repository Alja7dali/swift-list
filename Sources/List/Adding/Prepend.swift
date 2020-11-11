extension List {  
  // Adds a new element at the start of the list.
  public mutating func prepend(_ element: Element) {
    let newSlice = allocate(element)
    
    if last != nil {
      newSlice.pointee.npxAddr = xor(firstNode, nil)
      firstNode.pointee.npxAddr = xor(newSlice, xor(firstNode?.pointee.npxAddr, nil))
      firstNode = newSlice
    } else {
      lastNode = newSlice
      firstNode = newSlice
    }

    count = count + 1
  }

  // Adds a new elements at the start of the list.
  public mutating func prepend(_ sequence: Element ...) {
    return prepend(sequence)
  }

  public mutating func prepend<S: Sequence>(_ sequence: S) where S.Element == Element {
    var itr = sequence.makeIterator()

    if let element = itr.next() {
      var newSlice = allocate(element)
      
      if last != nil {
        newSlice.pointee.npxAddr = xor(firstNode, nil)
        firstNode.pointee.npxAddr = xor(newSlice, xor(firstNode?.pointee.npxAddr, nil))
        firstNode = newSlice
      } else {
        lastNode = newSlice
        firstNode = newSlice
      }

      count = count + 1

      while let element = itr.next() {
        newSlice = allocate(element)
        newSlice.pointee.npxAddr = xor(firstNode, nil)
        firstNode.pointee.npxAddr = xor(newSlice, xor(firstNode?.pointee.npxAddr, nil))
        firstNode = newSlice
        count = count + 1
      }
    }
  }
}
