extension List {  
  // Inserts a new element at the specified position.
  public mutating func insert(_ element: Element, at index: Int) {
    let atIndex = fixIndex(index, count)

    precondition(atIndex > -1, "List: Negative index is out of range")
    precondition(atIndex <= count, "List: Index is out of range")

    switch true {
    case atIndex == 0:
      // insert at first index (prepending)
      return prepend(element)
    
    case atIndex == count:
      // insert at last index (appending)
      return append(element)

    case atIndex < (count-1)/2:
      // insert at first half
      let newSlice = allocate(element)

      var i = 0
      var curr = firstNode
      var 
        prev    : UnsafeMutablePointer<ListNode<Element>>?,
        next    : UnsafeMutablePointer<ListNode<Element>>?,
        prevPrev: UnsafeMutablePointer<ListNode<Element>>?,
        nextNext: UnsafeMutablePointer<ListNode<Element>>?

      while i < atIndex {
        next     = xor(prev, curr?.pointee.npxAddr)
        prevPrev = prev
        prev     = curr
        curr     = next

        i += 1
      }

      nextNext = xor(prev, curr?.pointee.npxAddr)

      newSlice.pointee.npxAddr = xor(prev, next)
      prev?.pointee.npxAddr = xor(prevPrev, newSlice)
      next?.pointee.npxAddr = xor(newSlice, nextNext)
      count = count + 1

    default:
      // insert at last half
      let newSlice = allocate(element)

      var i = count
      var curr = lastNode
      var 
        prev    : UnsafeMutablePointer<ListNode<Element>>?,
        next    : UnsafeMutablePointer<ListNode<Element>>?,
        prevPrev: UnsafeMutablePointer<ListNode<Element>>?,
        nextNext: UnsafeMutablePointer<ListNode<Element>>?

      while i > atIndex {
        prev     = xor(curr?.pointee.npxAddr, next)
        nextNext = next
        next     = curr
        curr     = prev

        i -= 1
      }

      prevPrev = xor(curr?.pointee.npxAddr, next)

      newSlice.pointee.npxAddr = xor(prev, next)
      prev?.pointee.npxAddr = xor(prevPrev, newSlice)
      next?.pointee.npxAddr = xor(newSlice, nextNext)
      count = count + 1
    }

  }

  // Inserts a new elements at the specified position.
  public mutating func insert(_ sequence: Element ..., at index: Int) {  
    return insert(sequence, at: index)
  }

  public mutating func insert<S: Sequence>(_ sequence: S, at index: Int) where S.Element == Element {  
    let atIndex = fixIndex(index, count)

    precondition(atIndex > -1, "List: Negative index is out of range")
    precondition(atIndex <= count, "List: Index is out of range")
    
    switch true {
    case atIndex == 0:
      // insert at first index (prepending)
      return prepend(sequence)
    
    case atIndex == count:
      // insert at last index (appending)
      return append(sequence)

    case atIndex < (count-1)/2:
      // insert at first half
      var itr = sequence.reversed().makeIterator()

      return insertAtFirstHalf(
        &itr,
        &self,
        atIndex
      )

    default:
      // insert at last half
      var itr = sequence.reversed().makeIterator()

      return insertAtLastHalf(
        &itr,
        &self,
        atIndex
      )
    }
  }

  public mutating func insert(_ sequence: List<Element>, at index: Int) {  
    let atIndex = fixIndex(index, count)

    precondition(atIndex > -1, "List: Negative index is out of range")
    precondition(atIndex <= count, "List: Index is out of range")

    switch true {
    case atIndex == 0:
      // insert at first index (prepending)
      return prepend(sequence)
    
    case atIndex == count:
      // insert at last index (appending)
      return append(sequence)

    case atIndex < (count-1)/2:
      // insert at first half
      var itr = ListReversedIterator(sequence)

      return insertAtFirstHalf(
        &itr,
        &self,
        atIndex
      )

    default:
      // insert at last half
      var itr = ListReversedIterator(sequence)

      return insertAtLastHalf(
        &itr,
        &self,
        atIndex
      )
    }
  }
}

private func insertAtFirstHalf<I: IteratorProtocol>(
  _ itr: inout I,
  _ list: inout List<I.Element>,
  _ atIndex: Int
) {
  if let element = itr.next() {
    var newSlice = allocate(element)

    var i = 0
    var curr = list.firstNode
    var 
      prev    : UnsafeMutablePointer<ListNode<I.Element>>?,
      next    : UnsafeMutablePointer<ListNode<I.Element>>?,
      prevPrev: UnsafeMutablePointer<ListNode<I.Element>>?,
      nextNext: UnsafeMutablePointer<ListNode<I.Element>>?

    while i < atIndex {
      next     = xor(prev, curr?.pointee.npxAddr)
      prevPrev = prev
      prev     = curr
      curr     = next

      i += 1
    }

    nextNext = xor(prev, curr?.pointee.npxAddr)

    newSlice.pointee.npxAddr = xor(prev, next)
    prev?.pointee.npxAddr = xor(prevPrev, newSlice)
    next?.pointee.npxAddr = xor(newSlice, nextNext)
    
    list.count = list.count + 1

    while let element = itr.next() {
      curr = newSlice

      next     = xor(prev, curr?.pointee.npxAddr)
      prevPrev = prev
      prev     = curr
      curr     = next

      nextNext = xor(prev, curr?.pointee.npxAddr)

      newSlice = allocate(element)

      newSlice.pointee.npxAddr = xor(prev, next)
      prev?.pointee.npxAddr = xor(prevPrev, newSlice)
      next?.pointee.npxAddr = xor(newSlice, nextNext)

      list.count = list.count + 1
    }
  }
}

private func insertAtLastHalf<I: IteratorProtocol>(
  _ itr: inout I,
  _ list: inout List<I.Element>,
  _ atIndex: Int
) {
  if let element = itr.next() {
    var newSlice = allocate(element)

    var i = list.count
    var curr = list.lastNode
    var 
      prev    : UnsafeMutablePointer<ListNode<I.Element>>?,
      next    : UnsafeMutablePointer<ListNode<I.Element>>?,
      prevPrev: UnsafeMutablePointer<ListNode<I.Element>>?,
      nextNext: UnsafeMutablePointer<ListNode<I.Element>>?

    while i > atIndex {
      prev     = xor(curr?.pointee.npxAddr, next)
      nextNext = next
      next     = curr
      curr     = prev

      i -= 1
    }

    prevPrev = xor(curr?.pointee.npxAddr, next)

    newSlice.pointee.npxAddr = xor(prev, next)
    prev?.pointee.npxAddr = xor(prevPrev, newSlice)
    next?.pointee.npxAddr = xor(newSlice, nextNext)
    
    list.count = list.count + 1

    while let element = itr.next() {
      curr = newSlice

      prev     = xor(curr?.pointee.npxAddr, next)
      nextNext = next
      next     = curr
      curr     = prev

      prevPrev = xor(curr?.pointee.npxAddr, next)

      newSlice = allocate(element)

      newSlice.pointee.npxAddr = xor(prev, next)
      prev?.pointee.npxAddr = xor(prevPrev, newSlice)
      next?.pointee.npxAddr = xor(newSlice, nextNext)

      list.count = list.count + 1
    }
  }
}