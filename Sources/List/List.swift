// internal typealias ListNodePointee<Element> = UnsafeMutablePointer<Node<Element>>

internal struct ListNode<Element> {
  internal var npxAddr: UnsafeMutablePointer<ListNode<Element>>?
  internal var element: Element

  internal init(_ e: Element) {
    element = clone(e)
    npxAddr = nil
  }
}

public struct List<Element> {
  internal var firstNode: UnsafeMutablePointer<ListNode<Element>>!
  internal var lastNode: UnsafeMutablePointer<ListNode<Element>>!
  public internal(set) var count: Int = 0

  public init() { }
}

extension List: ExpressibleByArrayLiteral {
  public typealias ArrayLiteralElement = Element
  
  public init(arrayLiteral elements: Element ...) {
    append(elements)
  }

  // public init(_ elements: Element ...) {
  //   append(elements)
  // }

  public init<S: Sequence>(_ sequence: S) where S.Element == Element {
    append(sequence)
  }

  public init(repeating element: Element, count: Int) {
    var i = 0
    while i < count {
      append(element)
      i += 1
    }
  }

  public init(repeating sequence: Element ..., count: Int) {
    var i = 0
    while i < count {
      append(sequence)
      i += 1
    }
  }

  public init<S: Sequence>(repeating sequence: S, count: Int) where S.Element == Element {
    var i = 0
    while i < count {
      append(sequence)
      i += 1
    }
  }
}

extension List: Collection {
  public typealias Element = Element
  public typealias Index = Int

  public var first: Element? {
    return firstNode?.pointee.element
  }

  public var last: Element? {
    return lastNode?.pointee.element
  }
  
  public var startIndex: Index { return 0 }

  public var endIndex: Index { return count }
  
  public func index(after i: Index) -> Index {
    return i + 1
  }
}

extension List: BidirectionalCollection {
  public func index(before i: Index) -> Index {
    return i - 1
  }
}

extension List: CustomStringConvertible {
  public var description: String {
    return describe(self)
  }
}

extension List: CustomDebugStringConvertible {
  public var debugDescription: String {
    return "List<\(Element.self)>(\(describe(self)))"
  }
}

extension List: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(reflecting: List<Element>.self)
  }
}

extension List: Equatable where Element: Equatable {
  public static func == (lhs: List, rhs: List) -> Bool {
    return lhs.equals(rhs)
  }
}

extension List: Comparable where Element: Comparable {
  public static func < (lhs: List, rhs: List) -> Bool {
    return lhs.compare(rhs) < 0
  }

  public static func > (lhs: List, rhs: List) -> Bool {
    return lhs.compare(rhs) > 0
  }

  public static func <= (lhs: List, rhs: List) -> Bool {
    return lhs.compare(rhs) <= 0
  }

  public static func >= (lhs: List, rhs: List) -> Bool {
    return lhs.compare(rhs) >= 0
  }
}

extension List: MutableCollection {}

extension List: RandomAccessCollection {}

extension List: RangeReplaceableCollection {}

public struct ListIterator<Element>: IteratorProtocol {
  private var firstNode: UnsafeMutablePointer<ListNode<Element>>!
  private var lastNode: UnsafeMutablePointer<ListNode<Element>>!

  public init(_ l: List<Element>) {
    firstNode = l.firstNode
    lastNode = nil
  }

  @discardableResult
  public mutating func next() -> Element? {
    guard firstNode != nil else {
      return nil
    }

    let temp = firstNode
    firstNode = xor(lastNode, firstNode?.pointee.npxAddr)
    lastNode = temp

    return temp?.pointee.element
  }
}

public struct ListReversedIterator<Element>: IteratorProtocol {
  private var firstNode: UnsafeMutablePointer<ListNode<Element>>!
  private var lastNode: UnsafeMutablePointer<ListNode<Element>>!

  public init(_ l: List<Element>) {
    firstNode = l.lastNode
    lastNode = nil
  }

  @discardableResult
  public mutating func next() -> Element? {
    guard firstNode != nil else {
      return nil
    }

    let temp = firstNode
    firstNode = xor(lastNode, firstNode?.pointee.npxAddr)
    lastNode = temp

    return temp?.pointee.element
  }
}

extension List: Sequence {
  public func makeIterator() -> ListIterator<Element> {
    return ListIterator(self)
  }

  public func makeReversedIterator() -> ListReversedIterator<Element> {
    return ListReversedIterator(self)
  }
}