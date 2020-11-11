extension List {
  // Fills the given element in the specified list.
  public mutating func fill(_ element: Element) {
    guard count > 0 else { return }

    var curr = firstNode
    var 
      prev: UnsafeMutablePointer<ListNode<Element>>?,
      next: UnsafeMutablePointer<ListNode<Element>>?

    repeat {
      deallocate(curr?.pointee.element)
      curr?.pointee.element = clone(element)
      next = xor(prev, curr?.pointee.npxAddr)
      prev = curr
      curr = next
    } while curr != nil
  }

  // Fills the given element in a new list.
  public func filled(_ element: Element) -> List {
    guard count > 0 else { return List() }

    var i = count

    var newSlice = allocate(element)
    
    var filledList = List()
    filledList.firstNode = newSlice
    filledList.lastNode = newSlice
    filledList.count = count

    while i > 1 {
      newSlice = allocate(element)

      newSlice.pointee.npxAddr = xor(filledList.lastNode, nil)
      filledList.lastNode.pointee.npxAddr = xor(newSlice, xor(filledList.lastNode?.pointee.npxAddr, nil))
      filledList.lastNode = newSlice

      i -= 1
    }

    return filledList
  }
}