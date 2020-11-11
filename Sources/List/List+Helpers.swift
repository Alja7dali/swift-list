internal func xor<Element>(_ predecessor: UnsafeMutablePointer<ListNode<Element>>?, _ successor: UnsafeMutablePointer<ListNode<Element>>?) -> UnsafeMutablePointer<ListNode<Element>>? {
  let next = UInt(bitPattern: predecessor) ^ UInt(bitPattern: successor)
  return UnsafeMutablePointer<ListNode<Element>>(bitPattern: next)
}

internal func fixIndex(_ atIndex: Int, _ maxCount: Int) -> Int {
  // fixing index (lower than 0)
  // only between (-count...0) can be fixed
  return atIndex < 0 ? atIndex + maxCount : atIndex
}

internal func fixRange(_ minIndex: Int, _ maxIndex: Int, _ maxCount: Int) -> (Int, Int) {
  return (fixIndex(minIndex, maxCount), fixIndex(maxIndex, maxCount))
}

internal func swapIndex(_ minIndex: Int, _ maxIndex: Int) -> (Int, Int) {
  return minIndex > maxIndex ? (maxIndex, minIndex) : (minIndex, maxIndex)
}

internal func successor<Element>(
  _ prev: inout UnsafeMutablePointer<ListNode<Element>>?,
  _ curr: inout UnsafeMutablePointer<ListNode<Element>>?,
  _ next: inout UnsafeMutablePointer<ListNode<Element>>?
  ) {
  next = xor(prev, curr?.pointee.npxAddr)
  prev = curr
  curr = next
}

internal func predecessor<Element>(
  _ prev: inout UnsafeMutablePointer<ListNode<Element>>?,
  _ curr: inout UnsafeMutablePointer<ListNode<Element>>?,
  _ next: inout UnsafeMutablePointer<ListNode<Element>>?
  ) {
  prev = xor(next, curr?.pointee.npxAddr)
  next = curr
  curr = prev
}

internal func removeNextFoundElements<Element>(
  prev: inout UnsafeMutablePointer<ListNode<Element>>?,
  curr: inout UnsafeMutablePointer<ListNode<Element>>?,
  next: inout UnsafeMutablePointer<ListNode<Element>>?,
  element: Element
  ) -> Int where Element: Equatable {
    
  while curr != nil && curr?.pointee.element != element {
    successor(&prev, &curr, &next)
  }

  if curr != nil {
    next = xor(curr?.pointee.npxAddr, prev)

    next?.pointee.npxAddr = xor(xor(curr, next?.pointee.npxAddr), prev)
    prev?.pointee.npxAddr = xor(xor(curr, prev?.pointee.npxAddr), next)

    deallocate(curr!.pointee.element)
    curr!.deallocate()

    var nextNext = next?.pointee.npxAddr
    return removeNextFoundElements(prev: &prev, curr: &next, next: &nextNext, element: element) + 1
  }

  return 0
}


internal func clone<Element>(_ list: List<List<Element>>) -> List<List<Element>> {
  var clonedList = List<List<Element>>()

  var itr = ListIterator(list)
  while let e = itr.next() {
    clonedList.append(clone(e))
  }

  return clonedList
}

internal func clone<Element>(_ list: List<Element>) -> List<Element> {
  var clonedList = List<Element>()

  var itr = ListIterator(list)
  while let e = itr.next() {
    clonedList.append(clone(e))
  }

  return clonedList
}

internal func clone<Element>(_ element: Element) -> Element {
  return element
}

// internal func allocate<Element>() -> UnsafeMutablePointer<ListNode<Element>> {
//   return UnsafeMutablePointer<ListNode<Element>>.allocate(capacity: 1)
// }

internal func allocate<Element>(_ e: Element) -> UnsafeMutablePointer<ListNode<Element>> {
  // let slice = UnsafeMutablePointer<ListNode<Element>>.allocate(capacity: 1)
  // let node = ListNode<Element>(e)
  // slice.pointee = node
  // return slice

  let slice = UnsafeMutablePointer<ListNode<Element>>.allocate(capacity: 1)
  // let node = ListNode<Element>(e)
  // slice.pointee = node
  slice.initialize(to: ListNode<Element>(e))
  return slice

  // var node = ListNode<Element>(e)
  // let slice = UnsafeMutablePointer<ListNode<Element>>(&node)
  // return slice

  // var node = ListNode<Element>(e)
  // // let slice = UnsafeMutablePointer<ListNode<Element>>(&node)
  // return &node
}

internal func deallocate<Element>( _ ptr: UnsafeMutablePointer<ListNode<Element>>?) {
  guard ptr != nil else { return }

  deallocate(ptr!.pointee.element)
  deallocate(ptr!.pointee.npxAddr)

  ptr!.deallocate()
}

internal func deallocate<Element>(_ list: List<List<Element>>) {
  var itr = ListIterator(list)
  while let e = itr.next() {
    deallocate(e)
  }

  deallocate(list.first)
  // deallocate(list.last)
}

internal func deallocate<Element>(_ list: List<Element>) {
  var itr = ListIterator(list)
  while let e = itr.next() {
    deallocate(e)
  }

  deallocate(list.first)
  // deallocate(list.last)
}

internal func deallocate<Element>(_ element: Element) { }


internal func describe<Element>(_ list: List<List<Element>>) -> String {
  var output = "["

  var itr = ListIterator(list)
  while let e = itr.next() {
    output.append("\(e), ")
  }

  return output.count == 1 ? "[]" : output.dropLast(2) + "]"
}

internal func describe<Element>(_ list: List<Element>) -> String {
  var output = "["

  var itr = ListIterator(list)
  while let e = itr.next() {
    output.append("\(e), ")
  }

  return output.count == 1 ? "[]" : output.dropLast(2) + "]"
}

internal func describe<Element>(_ element: Element) -> String {
  return "\(element)"
}

#if os(Linux)
import func Glibc.srandom
import func Glibc.random
import func Glibc.time
#endif

internal func seedRandom() {
  #if os(Linux)
    srandom(UInt32(time(nil)))
  #endif
}

internal func random(_ upperBound: Int) -> Int {
  #if os(Linux)
    return Int(random() % Int(upperBound))
  #else
    return Int(arc4random_uniform(UInt32(upperBound)))
  #endif
}