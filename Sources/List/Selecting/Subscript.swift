extension List {
  public subscript(_ index: Int) -> Element {
    get {
      let atIndex = fixIndex(index, count)

      precondition(atIndex > -1, "List: Negative index is out of range")
      precondition(atIndex < count, "List: Index is out of range")

      switch true {
      case atIndex == 0:
        // getting first element
        return clone(firstNode.pointee.element)

      case atIndex == count-1:
        // getting last element
        return clone(lastNode.pointee.element)

      case atIndex < (count-1)/2:
        // getting element within first half
        var itr = ListIterator(self)
        var i = 0        
        while i < atIndex {
          itr.next()
          i += 1
        }
        return clone(itr.next()!)

      default:
        // getting element within last half
        var itr = makeReversedIterator()
        var i = count-1        
        while i > atIndex {
          itr.next()
          i -= 1
        }
        return clone(itr.next()!)
      }
    }

    set {
      let atIndex = fixIndex(index, count)

      precondition(atIndex > -1, "List: Negative index is out of range")
      precondition(atIndex < count, "List: Index is out of range")

      switch true {
      case atIndex == 0:
        // setting first element
        deallocate(firstNode.pointee.element)
        firstNode.pointee.element = clone(newValue)

      case atIndex == count-1:
        // setting last element
        deallocate(lastNode.pointee.element)
        lastNode.pointee.element = clone(newValue)
        
      case atIndex < (count-1)/2:
        // setting element within first half
        var i = 0
        var curr = firstNode
        var 
          prev: UnsafeMutablePointer<ListNode<Element>>?,
          next: UnsafeMutablePointer<ListNode<Element>>?
      

        while i < atIndex {
          successor(&prev, &curr, &next)
          i += 1
        }

        deallocate(curr?.pointee.element)
        curr?.pointee.element = clone(newValue)

      default:
        // setting element within last half
        var i = count-1
        var curr = lastNode
        var 
          prev: UnsafeMutablePointer<ListNode<Element>>?,
          next: UnsafeMutablePointer<ListNode<Element>>?
      

        while i > atIndex {
          predecessor(&prev, &curr, &next)
          i -= 1
        }

        deallocate(curr?.pointee.element)
        curr?.pointee.element = clone(newValue)
      }
    }
  }

  public subscript(_ r: Range<Int>) -> List<Element> {
    get {
      return slice(r.lowerBound, r.upperBound)
    }

    // set {
    //   replace(r.lowerBound, r.upperBound, with: newValue)
    // }
  }

  public subscript(_ r: ClosedRange<Int>) -> List<Element> {
    get {
      return slice(r.lowerBound, r.upperBound)
    }

    // set {
    //   replace(r.lowerBound, r.upperBound, with: newValue)
    // }
  }

  public subscript(_ r: PartialRangeFrom<Int>) -> List<Element> {
    get {
      return slice(r.lowerBound, count)
    }

    // set {
    //   replace(r.lowerBound, r.upperBound, with: newValue)
    // }
  }

  public subscript(_ r: PartialRangeUpTo<Int>) -> List<Element> {
    get {
      return slice(0, r.upperBound)
    }

    // set {
    //   replace(r.lowerBound, r.upperBound, with: newValue)
    // }
  }
}