public protocol NestedList: Sequence {}
extension List: NestedList {}

extension List where Element: NestedList {
  //// MARK: Splitting and Joining Elements II

  // Returns the concatenated list of this nestedlist.
  public func joined() -> List<Element.Element> {
    var joinedList = List<Element.Element>()

    var mainItr = ListIterator(self)
    
    while let list = mainItr.next() {
      var subItr = list.makeIterator()
      while let element = subItr.next() {
        joinedList.append(element)
      }
    }

    return joinedList
  }

  // Returns the concatenated list of this nestedlist, inserting the given separator between each element.
  public func joined(separator: Element.Element) -> List<Element.Element> {
    var joinedList = List<Element.Element>()

    var mainItr = ListIterator(self)
    
    while let list = mainItr.next() {
      var subItr = list.makeIterator()
      while let element = subItr.next() {
        joinedList.append(element)
      }

      joinedList.append(separator)
    }

    joinedList.deleteLast()
    return joinedList
  }

  public func joined(pattern: Element.Element ...) -> List<Element.Element> {
    var joinedList = List<Element.Element>()

    var mainItr = ListIterator(self)
    
    while let list = mainItr.next() {
      var subItr = list.makeIterator()
      while let element = subItr.next() {
        joinedList.append(element)
      }

      joinedList.append(pattern)
    }

    joinedList.deleteLast()
    return joinedList
  }

  public func joined(pattern: Array<Element.Element>) -> List<Element.Element> {
    var joinedList = List<Element.Element>()

    var mainItr = ListIterator(self)
    
    while let list = mainItr.next() {
      var subItr = list.makeIterator()
      while let element = subItr.next() {
        joinedList.append(element)
      }

      joinedList.append(pattern)
    }

    joinedList.deleteLast()
    return joinedList
  }

  public func joined(pattern: List<Element.Element>) -> List<Element.Element> {
    var joinedList = List<Element.Element>()

    var mainItr = ListIterator(self)
    
    while let list = mainItr.next() {
      var subItr = list.makeIterator()
      while let element = subItr.next() {
        joinedList.append(element)
      }

      joinedList.append(pattern)
    }

    joinedList.deleteLast()
    return joinedList
  }

  public func joined(whereSeparator: () throws -> (Element.Element)) rethrows -> List<Element.Element> {
    var joinedList = List<Element.Element>()

    var mainItr = ListIterator(self)
    
    while let list = mainItr.next() {
      var subItr = list.makeIterator()
      while let element = subItr.next() {
        joinedList.append(element)
      }

      try joinedList.append(whereSeparator())
    }

    joinedList.deleteLast()
    return joinedList
  }

  public func joined(wherePattern: () throws -> (Array<Element.Element>)) rethrows -> List<Element.Element> {
    var joinedList = List<Element.Element>()

    var mainItr = ListIterator(self)
    
    while let list = mainItr.next() {
      var subItr = list.makeIterator()
      while let element = subItr.next() {
        joinedList.append(element)
      }

      try joinedList.append(wherePattern())
    }

    joinedList.deleteLast()
    return joinedList
  }

  public func joined(wherePattern: () throws -> (List<Element.Element>)) rethrows -> List<Element.Element> {
    var joinedList = List<Element.Element>()

    var mainItr = ListIterator(self)
    
    while let list = mainItr.next() {
      var subItr = list.makeIterator()
      while let element = subItr.next() {
        joinedList.append(element)
      }

      try joinedList.append(wherePattern())
    }

    joinedList.deleteLast()
    return joinedList
  }
}