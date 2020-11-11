extension List where Element: Equatable {
  public func split(separator: Element, maxSplits: Int = Int.max, omittingEmptySubsequences: Bool = true) -> List<List> {
    var nestedList = List<List>()

    nestedList.append(List())

    var itr = ListIterator(self)
    
    while nestedList.count < maxSplits, let element = itr.next() {
      if element == separator {
        if nestedList.lastNode.pointee.element.count > 0 {
          nestedList.append(List())
        } else if !omittingEmptySubsequences {
          nestedList.append(List())
        }
      } else {
        nestedList.lastNode.pointee.element.append(element)
      }
    }

    nestedList.deleteLast()

    return nestedList
  }

  public func split(separator: Element ..., maxSplits: Int = Int.max, omittingEmptySubsequences: Bool = true) -> List<List> {
    var nestedList = List<List>()

    nestedList.append(List())

    var itr = ListIterator(self)
    
    while nestedList.count < maxSplits, let element = itr.next() {
      if separator.contains(element) {
        if nestedList.lastNode.pointee.element.count > 0 {
          nestedList.append(List())
        } else if !omittingEmptySubsequences {
          nestedList.append(List())
        }
      } else {
        nestedList.lastNode.pointee.element.append(element)
      }
    }

    nestedList.deleteLast()

    return nestedList
  }

  public func split(separator: Array<Element>, maxSplits: Int = Int.max, omittingEmptySubsequences: Bool = true) -> List<List> {
    var nestedList = List<List>()

    nestedList.append(List())

    var itr = ListIterator(self)
    
    while nestedList.count < maxSplits, let element = itr.next() {
      if separator.contains(element) {
        if nestedList.lastNode.pointee.element.count > 0 {
          nestedList.append(List())
        } else if !omittingEmptySubsequences {
          nestedList.append(List())
        }
      } else {
        nestedList.lastNode.pointee.element.append(element)
      }
    }

    nestedList.deleteLast()

    return nestedList
  }

  public func split(separator: List<Element>, maxSplits: Int = Int.max, omittingEmptySubsequences: Bool = true) -> List<List> {
    var nestedList = List<List>()

    nestedList.append(List())

    var itr = ListIterator(self)
    
    while nestedList.count < maxSplits, let element = itr.next() {
      if separator.contains(element) {
        if nestedList.lastNode.pointee.element.count > 0 {
          nestedList.append(List())
        } else if !omittingEmptySubsequences {
          nestedList.append(List())
        }
      } else {
        nestedList.lastNode.pointee.element.append(element)
      }
    }

    nestedList.deleteLast()

    return nestedList
  }

  public func split(pattern: Element ..., maxSplits: Int = Int.max, omittingEmptySubsequences: Bool = true) -> List<List> {
    var nestedList = List<List>()

    nestedList.append(List())

    var curr = firstNode
    var 
      prev    : UnsafeMutablePointer<ListNode<Element>>?,
      next    : UnsafeMutablePointer<ListNode<Element>>?
    
    while curr != nil && nestedList.count < maxSplits {
      var tempArr = Array<Element>()

      var itr = pattern.makeIterator()
      
      while let e = curr?.pointee.element, let p = itr.next() {
        guard e == p else { break }
        tempArr.append(e)
        successor(&prev, &curr, &next)
      }

      if itr.next() == nil {
        if nestedList.lastNode.pointee.element.count > 0 {
          nestedList.append(List())
        } else if !omittingEmptySubsequences {
          nestedList.append(List())
        }
      } else {
        if tempArr.count > 0 {
          nestedList.lastNode.pointee.element.append(tempArr)
        }
        nestedList.lastNode.pointee.element.append(curr!.pointee.element)
        successor(&prev, &curr, &next)
      }
    }

    nestedList.deleteLast()

    return nestedList
  }

  public func split(pattern: Array<Element>, maxSplits: Int = Int.max, omittingEmptySubsequences: Bool = true) -> List<List> {
    var nestedList = List<List>()

    nestedList.append(List())

    var curr = firstNode
    var 
      prev    : UnsafeMutablePointer<ListNode<Element>>?,
      next    : UnsafeMutablePointer<ListNode<Element>>?
    
    while curr != nil && nestedList.count < maxSplits {
      var tempArr = Array<Element>()

      var itr = pattern.makeIterator()
      
      while let e = curr?.pointee.element, let p = itr.next() {
        guard e == p else { break }
        tempArr.append(e)
        successor(&prev, &curr, &next)
      }

      if itr.next() == nil {
        if nestedList.lastNode.pointee.element.count > 0 {
          nestedList.append(List())
        } else if !omittingEmptySubsequences {
          nestedList.append(List())
        }
      } else {
        if tempArr.count > 0 {
          nestedList.lastNode.pointee.element.append(tempArr)
        }
        nestedList.lastNode.pointee.element.append(curr!.pointee.element)
        successor(&prev, &curr, &next)
      }
    }

    nestedList.deleteLast()

    return nestedList
  }

  public func split(pattern: List<Element>, maxSplits: Int = Int.max, omittingEmptySubsequences: Bool = true) -> List<List> {
    var nestedList = List<List>()

    nestedList.append(List())

    var curr = firstNode
    var 
      prev    : UnsafeMutablePointer<ListNode<Element>>?,
      next    : UnsafeMutablePointer<ListNode<Element>>?
    
    while curr != nil && nestedList.count < maxSplits {
      var tempArr = Array<Element>()

      var itr = pattern.makeIterator()
      
      while let e = curr?.pointee.element, let p = itr.next() {
        guard e == p else { break }
        tempArr.append(e)
        successor(&prev, &curr, &next)
      }

      if itr.next() == nil {
        if nestedList.lastNode.pointee.element.count > 0 {
          nestedList.append(List())
        } else if !omittingEmptySubsequences {
          nestedList.append(List())
        }
      } else {
        if tempArr.count > 0 {
          nestedList.lastNode.pointee.element.append(tempArr)
        }
        nestedList.lastNode.pointee.element.append(curr!.pointee.element)
        successor(&prev, &curr, &next)
      }
    }

    nestedList.deleteLast()

    return nestedList
  }

  public func split(maxSplits: Int = Int.max, omittingEmptySubsequences: Bool = true, whereSeparator: (Element) throws -> Bool) rethrows -> List<List> {
    var nestedList = List<List>()

    nestedList.append(List())

    var itr = ListIterator(self)
    
    while nestedList.count < maxSplits, let element = itr.next() {
      if try whereSeparator(element) {
        if nestedList.lastNode.pointee.element.count > 0 {
          nestedList.append(List())
        } else if !omittingEmptySubsequences {
          nestedList.append(List())
        }
      } else {
        nestedList.lastNode.pointee.element.append(element)
      }
    }

    nestedList.deleteLast()

    return nestedList
  }

  // Returns nested list where each list has max count of elements.
  public func split(maxSublistElementsCount n: Int) -> List<List> {
    var nestedList = List<List>()

    nestedList.append(List())

    var itr = ListIterator(self)
    
    while let element = itr.next() {
      if nestedList.lastNode.pointee.element.count < n {
        nestedList.lastNode.pointee.element.append(element)
      } else {
        nestedList.append(List())
        nestedList.lastNode.pointee.element.append(element)
      }
    }

    return nestedList
  }

  // Returns nested list where has max count of lists.
  public func split(maxSublists n: Int) -> List<List> {
    var nestedList = List<List>()

    nestedList.append(List())

    var itr = ListIterator(self)
    
    var x = (Double(count)/Double(n))
    x.round(.up)
    let n = Int(x)

    while let element = itr.next() {
      if nestedList.lastNode.pointee.element.count < n {
        nestedList.lastNode.pointee.element.append(element)
      } else {
        nestedList.append(List())
        nestedList.lastNode.pointee.element.append(element)
      }
    }

    return nestedList
  }
}