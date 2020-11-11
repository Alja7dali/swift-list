extension List {
  // Replaces elements at the given range with the given element in the specified list.
  public mutating func replace(_ minIndex: Int, _ maxIndex: Int, with element: Element) {
    let (minIndex, maxIndex) = fixRange(minIndex, maxIndex, count)

    precondition(minIndex > -1 && maxIndex > -1, "List: Negative index is out of range")
    precondition(minIndex < count && maxIndex < count, "List: Index is out of range")

    switch true {
    case maxIndex - minIndex == 0 || maxIndex == minIndex:
      // replace an element at specific index

      // subscript set will clone element (no need to call clone here)
      self[minIndex] = element

    case minIndex == 0 && maxIndex == count-1:
      return fill(element)

    case maxIndex == count-1:
      return replaceLast(count: maxIndex-minIndex+1, with: element)

    case minIndex == 0:
      return replaceFirst(count: maxIndex+1, with: element)

    case maxIndex < minIndex:
      // replace elements where start index is higher than end index
      // e.g. 
      //  var list = [1, 2, 3, 4, 5, 6]
      //  list.replace(-2, 2, with: 10) // same as list.replace(list.count-2, 2, with: 10)
      //  print(list) // [10, 10, 10, 4, 10, 10]

      var i = count-1
      var curr = lastNode
      var 
        prev: UnsafeMutablePointer<ListNode<Element>>?,
        next: UnsafeMutablePointer<ListNode<Element>>?
  
      while i > minIndex-1 {
        deallocate(curr?.pointee.element)
        curr?.pointee.element = clone(element)
        prev = xor(next, curr?.pointee.npxAddr)
        next = curr
        curr = prev

        i -= 1
      }

      i = 0
      curr = firstNode
      prev = nil
      next = nil

      while i < maxIndex+1 {
        deallocate(curr?.pointee.element)
        curr?.pointee.element = clone(element)
        next = xor(prev, curr?.pointee.npxAddr)
        prev = curr
        curr = next

        i += 1
      }

    case minIndex < (count-1)/2:
      // replace elements near first half
      
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
        deallocate(curr?.pointee.element)
        curr?.pointee.element = clone(element)
        next = xor(prev, curr?.pointee.npxAddr)
        prev = curr
        curr = next

        i += 1
      } while i < maxIndex+1

    default:
      // replace elements near last half

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
        deallocate(curr?.pointee.element)
        curr?.pointee.element = clone(element)
        prev = xor(next, curr?.pointee.npxAddr)
        next = curr
        curr = prev

        i -= 1
      } while i > minIndex-1
    }
  }

  // Replaces the specified subrange of elements with the given collection.
  public mutating func replace(_ range: Range<Int>, with element: Element) {
    return replace(range.lowerBound, range.upperBound, with: element)
  }

  public mutating func replace(_ range: ClosedRange<Int>, with element: Element) {
    return replace(range.lowerBound, range.upperBound, with: element)
  }

  public mutating func replace(_ range: PartialRangeFrom<Int>, with element: Element) {
    return replace(range.lowerBound, count, with: element)
  }

  public mutating func replace(_ range: PartialRangeUpTo<Int>, with element: Element) {
    return replace(0, range.upperBound, with: element)
  }

  public mutating func replaceSubrange(_ range: Range<Int>, with element: Element) {
    return replace(range.lowerBound, range.upperBound, with: element)
  }

  public mutating func replaceSubrange(_ range: ClosedRange<Int>, with element: Element) {
    return replace(range.lowerBound, range.upperBound, with: element)
  }

  public mutating func replaceSubrange(_ range: PartialRangeFrom<Int>, with element: Element) {
    return replace(range.lowerBound, count, with: element)
  }

  public mutating func replaceSubrange(_ range: PartialRangeUpTo<Int>, with element: Element) {
    return replace(0, range.upperBound, with: element)
  }

  // Replaces elements at the given range with the given element in a new list.
  public func replaced(_ minIndex: Int, _ maxIndex: Int, with element: Element) -> List {
    let (minIndex, maxIndex) = fixRange(minIndex, maxIndex, count)

    precondition(minIndex > -1 && maxIndex > -1, "List: Negative index is out of range")
    precondition(minIndex < count && maxIndex < count, "List: Index is out of range")

    var newList = List()
    var i = 0
    var itr = ListIterator(self)

    if maxIndex < minIndex {
      while let e = itr.next() {
        if (i >= 0 && i <= maxIndex) || i >= minIndex && i <= count-1 {
          newList.append(element)
        } else {
          newList.append(e)
        }
        i+=1
      }
    } else {
      while let e = itr.next() {
        if i >= minIndex && i <= maxIndex {
          newList.append(element)
        } else {
          newList.append(e)
        }
        i+=1
      }
    }

    return newList
  }

  public mutating func replaceFirst(count n: Int, with element: Element) {
    precondition(count > 0, "List: Can't replace first (\(n)) element with \'\(element)\' from an empty list")

    var i = 0

    var curr = firstNode
    var 
      prev: UnsafeMutablePointer<ListNode<Element>>?,
      next: UnsafeMutablePointer<ListNode<Element>>?

    while i < n {
      deallocate(curr?.pointee.element)
      curr?.pointee.element = clone(element)

      next = xor(prev, curr?.pointee.npxAddr)
      prev = curr
      curr = next

      i += 1
    }
  }

  public func replacedFirst(count n: Int, with element: Element) -> List {
    precondition(count > 0, "List: Can't replaced first (\(n)) element with \'\(element)\' from an empty list")

    var i = 0
    var newList = List()
    newList.count = count

    var newSlice: UnsafeMutablePointer<ListNode<Element>>!

    newSlice = allocate(i < n ? element : firstNode.pointee.element)
    newList.firstNode = newSlice
    newList.lastNode = newSlice
    i += 1

    var curr = firstNode
    var 
      prev: UnsafeMutablePointer<ListNode<Element>>?,
      next: UnsafeMutablePointer<ListNode<Element>>?

    next = xor(prev, curr?.pointee.npxAddr)
    prev = curr
    curr = next

    while curr != nil {
      newSlice = allocate(i < n ? element : curr!.pointee.element)

      newSlice.pointee.npxAddr = xor(newList.lastNode, nil)
      newList.lastNode.pointee.npxAddr = xor(newSlice, xor(newList.lastNode.pointee.npxAddr, nil))
      newList.lastNode = newSlice

      next = xor(prev, curr?.pointee.npxAddr)
      prev = curr
      curr = next

      i += 1
    }

    return newList
  }

  public mutating func replaceLast(count n: Int, with element: Element) {
    precondition(count > 0, "List: Can't replace last (\(n)) element with \'\(element)\' from an empty list")

    var i = 0

    var curr = lastNode
    var 
      prev: UnsafeMutablePointer<ListNode<Element>>?,
      next: UnsafeMutablePointer<ListNode<Element>>?

    while i < n {
      deallocate(curr?.pointee.element)
      curr?.pointee.element = clone(element)

      prev = xor(next, curr?.pointee.npxAddr)
      next = curr
      curr = prev

      i += 1
    }
  }

  public func replacedLast(count n: Int, with element: Element) -> List {
    precondition(count > 0, "List: Can't replaced last (\(n)) element with \'\(element)\' from an empty list")

    var i = 0
    var newList = List()
    newList.count = count

    var newSlice: UnsafeMutablePointer<ListNode<Element>>!

    newSlice = allocate(i < n ? element : firstNode.pointee.element)
    newList.firstNode = newSlice
    newList.lastNode = newSlice
    i += 1

    var curr = firstNode
    var 
      prev: UnsafeMutablePointer<ListNode<Element>>?,
      next: UnsafeMutablePointer<ListNode<Element>>?

    prev = xor(next, curr?.pointee.npxAddr)
    next = curr
    curr = prev

    while curr != nil {
      newSlice = allocate(i < n ? element : curr!.pointee.element)

      newSlice.pointee.npxAddr = xor(newList.firstNode, nil)
      newList.firstNode.pointee.npxAddr = xor(newSlice, xor(newList.firstNode.pointee.npxAddr, nil))
      newList.firstNode = newSlice

      prev = xor(next, curr?.pointee.npxAddr)
      next = curr
      curr = prev

      i += 1
    }

    return newList
  }
}

extension List where Element: Equatable {
  @discardableResult
  public mutating func replace(all oldElement: Element, with newElement: Element) -> Int {
    precondition(count > 0, "List: Can't replace all \'\(oldElement)\' element with \'\(newElement)\' from an empty list")

    var totalReplaced = 0

    var curr = firstNode
    var 
      prev: UnsafeMutablePointer<ListNode<Element>>?,
      next: UnsafeMutablePointer<ListNode<Element>>?

    while curr != nil {
      if curr?.pointee.element == oldElement {
        deallocate(curr?.pointee.element)
        curr?.pointee.element = clone(newElement)
        totalReplaced += 1
      }

      next = xor(prev, curr?.pointee.npxAddr)
      prev = curr
      curr = next
    }

    return totalReplaced
  }

  public mutating func replaced(all oldElement: Element, with newElement: Element) -> List {
    precondition(count > 0, "List: Can't replaced all \'\(oldElement)\' element with \'\(newElement)\' from an empty list")

    var newList = List()
    newList.count = count

    var newSlice: UnsafeMutablePointer<ListNode<Element>>!

    newSlice = allocate(firstNode?.pointee.element == oldElement ? newElement : firstNode.pointee.element)
    newList.firstNode = newSlice
    newList.lastNode = newSlice

    var curr = firstNode
    var 
      prev: UnsafeMutablePointer<ListNode<Element>>?,
      next: UnsafeMutablePointer<ListNode<Element>>?

    next = xor(prev, curr?.pointee.npxAddr)
    prev = curr
    curr = next

    while curr != nil {
      newSlice = allocate(curr?.pointee.element == oldElement ? newElement : curr!.pointee.element)

      newSlice.pointee.npxAddr = xor(newList.lastNode, nil)
      newList.lastNode.pointee.npxAddr = xor(newSlice, xor(newList.lastNode.pointee.npxAddr, nil))
      newList.lastNode = newSlice

      next = xor(prev, curr?.pointee.npxAddr)
      prev = curr
      curr = next
    }

    return newList
  }

  @discardableResult
  public mutating func replaceFirst(_ oldElement: Element, with newElement: Element) -> Bool {
    precondition(count > 0, "List: Can't replace first \'\(oldElement)\' element with \'\(newElement)\' from an empty list")

    var curr = firstNode
    var 
      prev: UnsafeMutablePointer<ListNode<Element>>?,
      next: UnsafeMutablePointer<ListNode<Element>>?

    while curr != nil {
      if curr?.pointee.element == oldElement {
        deallocate(curr?.pointee.element)
        curr?.pointee.element = clone(newElement)
        return true
      }

      next = xor(prev, curr?.pointee.npxAddr)
      prev = curr
      curr = next
    }

    return false
  }

  public func replacedFirst(_ oldElement: Element, with newElement: Element) -> List {
    precondition(count > 0, "List: Can't replaced first \'\(oldElement)\' element with \'\(newElement)\' from an empty list")

    var didFindAndReplace = false

    var newList = List()
    newList.count = count

    var newSlice: UnsafeMutablePointer<ListNode<Element>>!

    if firstNode.pointee.element == oldElement {
      newSlice = allocate(newElement)
      didFindAndReplace = true
    } else {
      newSlice = allocate(firstNode.pointee.element)
    }

    newList.firstNode = newSlice
    newList.lastNode = newSlice

    var curr = firstNode
    var 
      prev: UnsafeMutablePointer<ListNode<Element>>?,
      next: UnsafeMutablePointer<ListNode<Element>>?

    next = xor(prev, curr?.pointee.npxAddr)
    prev = curr
    curr = next

    while curr != nil {
      if !didFindAndReplace && curr?.pointee.element == oldElement {
        newSlice = allocate(newElement)
        didFindAndReplace = true
      } else {
        newSlice = allocate(curr!.pointee.element)
      }

      newSlice.pointee.npxAddr = xor(newList.lastNode, nil)
      newList.lastNode.pointee.npxAddr = xor(newSlice, xor(newList.lastNode.pointee.npxAddr, nil))
      newList.lastNode = newSlice

      next = xor(prev, curr?.pointee.npxAddr)
      prev = curr
      curr = next
    }

    return newList
  }

  @discardableResult
  public mutating func replaceLast(_ oldElement: Element, with newElement: Element) -> Bool {
    precondition(count > 0, "List: Can't replace last \'\(oldElement)\' element with \'\(newElement)\' from an empty list")

    var curr = lastNode
    var 
      prev: UnsafeMutablePointer<ListNode<Element>>?,
      next: UnsafeMutablePointer<ListNode<Element>>?

    while curr != nil {
      if curr?.pointee.element == oldElement {
        deallocate(curr?.pointee.element)
        curr?.pointee.element = clone(newElement)
        return true
      }

      prev = xor(next, curr?.pointee.npxAddr)
      next = curr
      curr = prev
    }

    return false
  }

  public func replacedLast(_ oldElement: Element, with newElement: Element) -> List {
    precondition(count > 0, "List: Can't replaced last \'\(oldElement)\' element with \'\(newElement)\' from an empty list")

    var didFindAndReplace = false

    var newList = List()
    newList.count = count

    var newSlice: UnsafeMutablePointer<ListNode<Element>>!

    if firstNode.pointee.element == oldElement {
      newSlice = allocate(newElement)
      didFindAndReplace = true
    } else {
      newSlice = allocate(firstNode.pointee.element)
    }

    newList.firstNode = newSlice
    newList.lastNode = newSlice

    var curr = firstNode
    var 
      prev: UnsafeMutablePointer<ListNode<Element>>?,
      next: UnsafeMutablePointer<ListNode<Element>>?

    prev = xor(next, curr?.pointee.npxAddr)
    next = curr
    curr = prev

    while curr != nil {
      if !didFindAndReplace && curr?.pointee.element == oldElement {
        newSlice = allocate(newElement)
        didFindAndReplace = true
      } else {
        newSlice = allocate(curr!.pointee.element)
      }

      newSlice.pointee.npxAddr = xor(newList.firstNode, nil)
      newList.firstNode.pointee.npxAddr = xor(newSlice, xor(newList.firstNode.pointee.npxAddr, nil))
      newList.firstNode = newSlice

      prev = xor(next, curr?.pointee.npxAddr)
      next = curr
      curr = prev
    }

    return newList
  }
}