extension List {
  // Removes all elements in the list.
  public mutating func removeAll() {
    while count > 0 {
      deleteFirst()
    }
  }

  // Removes elements at the given range in the specified list.
  public mutating func remove(_ minIndex: Int, _ maxIndex: Int) -> List {
    let (minIndex, maxIndex) = fixRange(minIndex, maxIndex, count)

    precondition(minIndex > -1 && maxIndex > -1, "List: Negative index is out of range")
    precondition(minIndex < count && maxIndex < count, "List: Index is out of range")

    var list = List()

    switch true {
    case maxIndex - minIndex == 0 || maxIndex == minIndex:
      // remove an element at specific index
      let element = remove(at: minIndex)
      list.append(element)
      deallocate(element)
      return list

    case minIndex == 0 && maxIndex == count-1:
      let list = self
      self = List()
      return list

    case maxIndex == count-1:
      return removeLast(count: maxIndex-minIndex+1)

    case minIndex == 0:
      return removeFirst(count: maxIndex+1)

    case maxIndex < minIndex:
      // remove elements where start index is higher than end index
      // e.g. 
      //  var list = [1, 2, 3, 4, 5, 6]
      //  list.remove(-2, 2)
      //  print(list) // [4]

      var i = count-1

      while i > minIndex-1 {
        list.prepend(lastNode.pointee.element)
        deallocate(lastNode.pointee.element)

        let prev = xor(nil, lastNode.pointee.npxAddr)
        prev?.pointee.npxAddr = xor(lastNode, xor(nil, prev?.pointee.npxAddr))

        lastNode = prev
        count -= 1

        i -= 1
      }

      i = 0

      while i < maxIndex+1 {
        list.append(firstNode.pointee.element)
        deallocate(firstNode.pointee.element)

        let next = xor(nil, firstNode.pointee.npxAddr)
        next?.pointee.npxAddr = xor(firstNode, xor(nil, next?.pointee.npxAddr))

        firstNode = next
        count -= 1

        i += 1
      }

    case minIndex < (count-1)/2:
      // remove elements near first half
      
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
                
        next?.pointee.npxAddr = xor(xor(curr ,next?.pointee.npxAddr), prev)
        prev?.pointee.npxAddr = xor(xor(prev?.pointee.npxAddr, curr), next)

        list.append(curr!.pointee.element)
        deallocate(curr!.pointee.element)

        curr!.deallocate()
        curr = next

        count -= 1

        i += 1
      } while i < maxIndex+1

    default:
      // remove elements near last half

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
        prev = xor(curr?.pointee.npxAddr, next)
                
        prev?.pointee.npxAddr = xor(xor(curr, prev?.pointee.npxAddr), next)
        next?.pointee.npxAddr = xor(xor(next?.pointee.npxAddr, curr), prev)

        list.prepend(curr!.pointee.element)
        deallocate(curr!.pointee.element)

        curr!.deallocate()
        curr = prev

        count -= 1

        i -= 1
      } while i > minIndex-1
    }

    return list
  }

  // Removes the specified subrange of elements from the list.
  @discardableResult
  public mutating func remove(_ range: Range<Int>) -> List {
    return remove(range.lowerBound, range.upperBound)
  }

  @discardableResult
  public mutating func remove(_ range: ClosedRange<Int>) -> List {
    return remove(range.lowerBound, range.upperBound)
  }

  @discardableResult
  public mutating func remove(_ range: PartialRangeFrom<Int>) -> List {
    return remove(range.lowerBound, count)
  }

  @discardableResult
  public mutating func remove(_ range: PartialRangeUpTo<Int>) -> List {
    return remove(0, range.upperBound)
  }

  @discardableResult
  public mutating func removeSubrange(_ range: Range<Int>) -> List {
    return remove(range.lowerBound, range.upperBound)
  }

  @discardableResult
  public mutating func removeSubrange(_ range: ClosedRange<Int>) -> List {
    return remove(range.lowerBound, range.upperBound)
  }

  @discardableResult
  public mutating func removeSubrange(_ range: PartialRangeFrom<Int>) -> List {
    return remove(range.lowerBound, count)
  }

  @discardableResult
  public mutating func removeSubrange(_ range: PartialRangeUpTo<Int>) -> List {
    return remove(0, range.upperBound)
  }

  // Removes and returns the first element of the list.
  public mutating func removeFirst() -> Element {
    precondition(count > 0, "List: Can't remove first element from an empty list")

    let element = clone(firstNode.pointee.element)
    deallocate(firstNode.pointee.element)

    let next = xor(nil, firstNode.pointee.npxAddr)

    if next == nil {
      lastNode = nil
    } else {
      next?.pointee.npxAddr = xor(firstNode, xor(nil, next?.pointee.npxAddr))
    }

    firstNode = next

    count -= 1
    return element
  }

  // Removes and returns the last element of the list.
  public mutating func removeLast() -> Element {
    precondition(count > 0, "List: Can't remove last element from an empty list")

    let element = clone(lastNode.pointee.element)
    deallocate(lastNode.pointee.element)

    let prev = xor(nil, lastNode.pointee.npxAddr)

    if prev == nil {
      firstNode = nil
    } else {
      prev?.pointee.npxAddr = xor(lastNode, xor(nil, prev?.pointee.npxAddr))
    }

    lastNode = prev
    count -= 1
    return element
  }

  // Removes the specified number of elements from the front of the list.
  public mutating func removeFirst(count n: Int) -> List {
    precondition(count > 0, "List: Can't remove first (\(n)) element from an empty list")

    var i = 0
    var newList = List()
    
    while i < n {
      let element = removeFirst()
      newList.append(element)
      deallocate(element)
      i += 1
    }

    return newList
  }

  // Removes the specified number of element from the back of the list.
  public mutating func removeLast(count n: Int) -> List {
    precondition(count > 0, "List: Can't remove last (\(n)) element from an empty list")

    var i = 0
    var newList = List()
    
    while i < n {
      let element = removeLast()
      newList.prepend(element)
      deallocate(element)
      i += 1
    }

    return newList
  }

  // Removes and returns the element at the specified position.
  public mutating func remove(at index: Int) -> Element {
    let atIndex = fixIndex(index, count)
    
    precondition(index > -1, "List: Negative index is out of range")
    precondition(index < count, "List: Index is out of range")

    switch true {
    case atIndex == 0:
      return removeFirst()
    
    case atIndex == count-1:
      return removeLast()

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

      let element = clone(curr!.pointee.element)

      next = xor(curr?.pointee.npxAddr,prev)
              
      next?.pointee.npxAddr = xor(xor(curr ,next?.pointee.npxAddr), prev)
      prev?.pointee.npxAddr = xor(xor(prev?.pointee.npxAddr, curr), next)

      deallocate(curr!.pointee.element)
      curr!.deallocate()

      count -= 1
      return element

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

      let element = clone(curr!.pointee.element)

      prev = xor(curr?.pointee.npxAddr, next);
              
      prev?.pointee.npxAddr = xor(xor(curr, prev?.pointee.npxAddr), next)
      next?.pointee.npxAddr = xor(xor(next?.pointee.npxAddr, curr), prev)

      deallocate(curr!.pointee.element)
      curr!.deallocate()

      count -= 1
      return element
    }
  }
}

extension List where Element: Equatable {
  // Removes all elements of the list that equals the specified element.
  @discardableResult
  public mutating func remove(all element: Element) -> Int {
    precondition(count > 0, "List: Can't remove all \'\(element)\' element from an empty list")

    var totalRemoved = 0

    while firstNode?.pointee.element == element {
      deleteFirst()
      totalRemoved += 1
    }

    while lastNode?.pointee.element == element {
      deleteLast()
      totalRemoved += 1
    }

    var 
    prev: UnsafeMutablePointer<ListNode<Element>>?,
    next: UnsafeMutablePointer<ListNode<Element>>?


    let totalNextRemoved = removeNextFoundElements(prev: &prev, curr: &firstNode, next: &next, element: element)
    count -= totalNextRemoved

    return totalNextRemoved + totalRemoved
  }

  // Removes the first index where the specified element appears in the list, will return false otherwise.
  @discardableResult
  public mutating func removeFirst(_ element: Element) -> Bool {
    precondition(count > 0, "List: Can't remove first \'\(element)\' element from an empty list")

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
      // removing first element
      
      curr = firstNode

      next = xor(curr?.pointee.npxAddr, nil)

      if next == nil {
        lastNode = nil
      } else {
        next?.pointee.npxAddr = xor(curr, xor(nil, next?.pointee.npxAddr))
      }

      firstNode = next

      case i == count-1:
      // removing last element
      
      curr = lastNode

      prev = xor(curr?.pointee.npxAddr, nil)

      if prev == nil {
        firstNode = nil
      } else {
        prev?.pointee.npxAddr = xor(curr, xor(nil, prev?.pointee.npxAddr))
      }

      lastNode = prev

      default:
      // removing middle element
     
        next = xor(curr?.pointee.npxAddr, prev)

        next?.pointee.npxAddr = xor(xor(curr, next?.pointee.npxAddr), prev)
        prev?.pointee.npxAddr = xor(xor(prev?.pointee.npxAddr, curr), next)
      }

      deallocate(curr!.pointee.element)
      curr!.deallocate()

      count -= 1

      return true // did find and remove element
    } else {
      return false // did not find and remove element
    }
  }

  // Removes the last index where the specified element appears in the list, will return false otherwise.
  @discardableResult
  public mutating func removeLast(_ element: Element) -> Bool {
    precondition(count > 0, "List: Can't remove last \'\(element)\' element from an empty list")

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
      // removing first element
      
      curr = firstNode

      next = xor(curr?.pointee.npxAddr, nil)

      if next == nil {
        lastNode = nil
      } else {
        next?.pointee.npxAddr = xor(curr, xor(nil, next?.pointee.npxAddr))
      }

      firstNode = next

      case i == count-1:
      // removing last element
      
      curr = lastNode

      prev = xor(curr?.pointee.npxAddr, nil)

      if prev == nil {
        firstNode = nil
      } else {
        prev?.pointee.npxAddr = xor(curr, xor(nil, prev?.pointee.npxAddr))
      }

      lastNode = prev

      default:
      // removing middle element
     
        prev = xor(curr?.pointee.npxAddr, next);
                
        prev?.pointee.npxAddr = xor(xor(curr, prev?.pointee.npxAddr), next)
        next?.pointee.npxAddr = xor(xor(next?.pointee.npxAddr, curr), prev)
      }

      deallocate(curr!.pointee.element)
      curr!.deallocate()

      count -= 1

      return true // did find and remove element
    } else {
      return false // did not find and remove element
    }
  }
}

