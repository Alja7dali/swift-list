extension List {
  // Deletes elements at the given range in the specified list.
  public mutating func delete(_ minIndex: Int, _ maxIndex: Int) {
    let (minIndex, maxIndex) = fixRange(minIndex, maxIndex, count)

    precondition(minIndex > -1 && maxIndex > -1, "List: Negative index is out of range")
    precondition(minIndex < count && maxIndex < count, "List: Index is out of range")

    switch true {
    case maxIndex - minIndex == 0 || maxIndex == minIndex:
      // delete an element at specific index
      return delete(at: minIndex)

    case minIndex == 0 && maxIndex == count-1:
      return removeAll()

    case maxIndex == count-1:
      return deleteLast(count: maxIndex-minIndex+1)

    case minIndex == 0:
      return deleteFirst(count: maxIndex+1)

    case maxIndex < minIndex:
      // delete elements where start index is higher than end index
      // e.g. 
      //  var list = [1, 2, 3, 4, 5, 6]
      //  list.delete(-2, 2)
      //  print(list) // [4]

      var i = count-1
    
      while i > minIndex-1 {
        deallocate(lastNode.pointee.element)

        let prev = xor(nil, lastNode.pointee.npxAddr)
        prev?.pointee.npxAddr = xor(lastNode, xor(nil, prev?.pointee.npxAddr))

        lastNode = prev
        count -= 1

        i -= 1
      }

      i = 0
      while i < maxIndex+1 {
        deallocate(firstNode.pointee.element)

        let next = xor(nil, firstNode.pointee.npxAddr)
        next?.pointee.npxAddr = xor(firstNode, xor(nil, next?.pointee.npxAddr))

        firstNode = next
        count -= 1

        i += 1
      }

    case minIndex < (count-1)/2:
      // delete elements near first half
      var i = 0
      var curr = firstNode
      var 
        prev: UnsafeMutablePointer<ListNode<Element>>?,
        next: UnsafeMutablePointer<ListNode<Element>>?
    

      while i < minIndex {
        next = xor(prev, curr?.pointee.npxAddr)
        prev = curr
        curr = next

        i += 1
      }

      repeat {
        next = xor(curr?.pointee.npxAddr,prev)
                
        print("here1", self, count, i)
        next?.pointee.npxAddr = xor(xor(curr ,next?.pointee.npxAddr), prev)
        print("here2", self, count, i)
        prev?.pointee.npxAddr = xor(xor(prev?.pointee.npxAddr, curr), next)
        print("here3", self, count, i)

        deallocate(curr!.pointee.element)
        curr!.deallocate()
        curr = next

        count -= 1

        i += 1
      } while i < maxIndex+1
        print("here4", self, count)

    default:
      // delete elements near last half

      var i = count-1
      var curr = lastNode
      var 
        prev: UnsafeMutablePointer<ListNode<Element>>?,
        next: UnsafeMutablePointer<ListNode<Element>>?
    

      while i > maxIndex {
        prev = xor(next, curr?.pointee.npxAddr)
        next = curr
        curr = prev

        i -= 1
      }

      repeat {
        prev = xor(curr?.pointee.npxAddr, next);
                
        prev?.pointee.npxAddr = xor(xor(curr, prev?.pointee.npxAddr), next)
        next?.pointee.npxAddr = xor(xor(next?.pointee.npxAddr, curr), prev)

        deallocate(curr!.pointee.element)
        curr!.deallocate()
        curr = prev

        count -= 1

        i -= 1
      } while i > minIndex-1
    }
  }

  // Deletes the specified subrange of elements from the list.
  public mutating func delete(_ range: Range<Int>) {
    return delete(range.lowerBound, range.upperBound)
  }

  public mutating func delete(_ range: ClosedRange<Int>) {
    return delete(range.lowerBound, range.upperBound)
  }

  public mutating func delete(_ range: PartialRangeFrom<Int>) {
    return delete(range.lowerBound, count)
  }

  public mutating func delete(_ range: PartialRangeUpTo<Int>) {
    return delete(0, range.upperBound)
  }

  public mutating func deleteSubrange(_ range: Range<Int>) {
    return delete(range.lowerBound, range.upperBound)
  }

  public mutating func deleteSubrange(_ range: ClosedRange<Int>) {
    return delete(range.lowerBound, range.upperBound)
  }

  public mutating func deleteSubrange(_ range: PartialRangeFrom<Int>) {
    return delete(range.lowerBound, count)
  }

  public mutating func deleteSubrange(_ range: PartialRangeUpTo<Int>) {
    return delete(0, range.upperBound)
  }

  // Deletes and returns the first element of the list.
  public mutating func deleteFirst() {
    precondition(count > 0, "List: Can't delete first element from an empty list")

    deallocate(firstNode.pointee.element)

    let next = xor(nil, firstNode.pointee.npxAddr)

    if next == nil {
      lastNode = nil
    } else {
      next?.pointee.npxAddr = xor(firstNode, xor(nil, next?.pointee.npxAddr))
    }

    firstNode = next

    count -= 1
  }

  // Deletes and returns the last element of the list.
  public mutating func deleteLast() {
    precondition(count > 0, "List: Can't delete last element from an empty list")

    deallocate(lastNode.pointee.element)

    let prev = xor(nil, lastNode.pointee.npxAddr)

    if prev == nil {
      firstNode = nil
    } else {
      prev?.pointee.npxAddr = xor(lastNode, xor(nil, prev?.pointee.npxAddr))
    }

    lastNode = prev
    count -= 1
  }

  // Deletes the specified number of elements from the front of the list.
  public mutating func deleteFirst(count n: Int) {
    precondition(count > 0, "List: Can't delete first (\(n)) element from an empty list")

    var i = 0
    
    while i < n {
      deleteFirst()
      i += 1
    }
  }

  // Deletes the specified number of element from the back of the list.
  public mutating func deleteLast(count n: Int) {
    precondition(count > 0, "List: Can't delete last (\(n)) element from an empty list")

    var i = 0
    
    while i < n {
      deleteLast()
      i += 1
    }
  }

  // Deletes and returns the element at the specified position.
  public mutating func delete(at index: Int) {
    let atIndex = fixIndex(index, count)
    
    precondition(index > -1, "List: Negative index is out of range")
    precondition(index < count, "List: Index is out of range")

    switch true {
    case atIndex == 0:
      return deleteFirst()
    
    case atIndex == count-1:
      return deleteLast()

    case atIndex < (count-1)/2:
      var i = 0
      var curr = firstNode
      var 
        prev: UnsafeMutablePointer<ListNode<Element>>?,
        next: UnsafeMutablePointer<ListNode<Element>>?
    

      while i < atIndex {
        next = xor(prev, curr?.pointee.npxAddr)
        prev = curr
        curr = next

        i += 1
      }

      next = xor(curr?.pointee.npxAddr,prev)
              
      next?.pointee.npxAddr = xor(xor(curr ,next?.pointee.npxAddr), prev)
      prev?.pointee.npxAddr = xor(xor(prev?.pointee.npxAddr, curr), next)

      deallocate(curr!.pointee.element)
      curr!.deallocate()

      count -= 1

    default:
      var i = count-1
      var curr = lastNode
      var 
        prev: UnsafeMutablePointer<ListNode<Element>>?,
        next: UnsafeMutablePointer<ListNode<Element>>?
    

      while i > atIndex {
        prev = xor(curr?.pointee.npxAddr, next)
        next = curr
        curr = prev

        i -= 1
      }

      prev = xor(curr?.pointee.npxAddr, next);
              
      prev?.pointee.npxAddr = xor(xor(curr, prev?.pointee.npxAddr), next)
      next?.pointee.npxAddr = xor(xor(next?.pointee.npxAddr, curr), prev)

      deallocate(curr!.pointee.element)
      curr!.deallocate()

      count -= 1
    }
  }
}

extension List where Element: Equatable {
  // Deletes all elements of the list that equals the specified element.
  public mutating func delete(all element: Element) {
    precondition(count > 0, "List: Can't delete all \'\(element)\' element from an empty list")

    while firstNode?.pointee.element == element {
      deleteFirst()
    }

    while lastNode?.pointee.element == element {
      deleteLast()
    }

    var 
    prev: UnsafeMutablePointer<ListNode<Element>>?,
    next: UnsafeMutablePointer<ListNode<Element>>?


    let totalNextRemoved = removeNextFoundElements(prev: &prev, curr: &firstNode, next: &next, element: element)
    count -= totalNextRemoved
  }

  // Deletes the first index where the specified element appears in the list, will return false otherwise.
  public mutating func deleteFirst(_ element: Element) {
    precondition(count > 0, "List: Can't delete first \'\(element)\' element from an empty list")

    var i = 0
    var curr = firstNode
    var 
      prev: UnsafeMutablePointer<ListNode<Element>>?,
      next: UnsafeMutablePointer<ListNode<Element>>?
  

    while curr != nil && curr?.pointee.element != element {
      next = xor(prev, curr?.pointee.npxAddr)
      prev = curr
      curr = next

      i += 1
    }

    if curr != nil {
      switch true {
      case i == 0:
      // deleting first element
      
      curr = firstNode

      next = xor(curr?.pointee.npxAddr, nil)

      if next == nil {
        lastNode = nil
      } else {
        next?.pointee.npxAddr = xor(curr, xor(nil, next?.pointee.npxAddr))
      }

      firstNode = next

      case i == count-1:
      // deleting last element
      
      curr = lastNode

      prev = xor(curr?.pointee.npxAddr, nil)

      if prev == nil {
        firstNode = nil
      } else {
        prev?.pointee.npxAddr = xor(curr, xor(nil, prev?.pointee.npxAddr))
      }

      lastNode = prev

      default:
      // deleting middle element
     
        next = xor(curr?.pointee.npxAddr, prev)

        next?.pointee.npxAddr = xor(xor(curr, next?.pointee.npxAddr), prev)
        prev?.pointee.npxAddr = xor(xor(prev?.pointee.npxAddr, curr), next)
      }

      deallocate(curr!.pointee.element)
      curr!.deallocate()

      count -= 1
    }
  }


  // Deletes the last index where the specified element appears in the list, will return false otherwise.
  public mutating func deleteLast(_ element: Element) {
    precondition(count > 0, "List: Can't delete last \'\(element)\' element from an empty list")

    var i = count-1
    var curr = lastNode
    var 
      prev: UnsafeMutablePointer<ListNode<Element>>?,
      next: UnsafeMutablePointer<ListNode<Element>>?
  

    while curr != nil && curr?.pointee.element != element {
      prev = xor(curr?.pointee.npxAddr, next)
      next = curr
      curr = prev

      i += 1
    }

    if curr != nil {
      switch true {
      case i == 0:
      // deleting first element
      
      curr = firstNode

      next = xor(curr?.pointee.npxAddr, nil)

      if next == nil {
        lastNode = nil
      } else {
        next?.pointee.npxAddr = xor(curr, xor(nil, next?.pointee.npxAddr))
      }

      firstNode = next

      case i == count-1:
      // deleting last element
      
      curr = lastNode

      prev = xor(curr?.pointee.npxAddr, nil)

      if prev == nil {
        firstNode = nil
      } else {
        prev?.pointee.npxAddr = xor(curr, xor(nil, prev?.pointee.npxAddr))
      }

      lastNode = prev

      default:
      // deleting middle element
     
        prev = xor(curr?.pointee.npxAddr, next);
                
        prev?.pointee.npxAddr = xor(xor(curr, prev?.pointee.npxAddr), next)
        next?.pointee.npxAddr = xor(xor(next?.pointee.npxAddr, curr), prev)
      }

      deallocate(curr!.pointee.element)
      curr!.deallocate()

      count -= 1
    }
  }
}