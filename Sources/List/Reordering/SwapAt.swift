extension List {
  // Exchanges the values at the specified indices of the list.
  public mutating func swapAt(_ xIndex: Int, _ yIndex: Int) {

    var (xIndex, yIndex) = fixRange(xIndex, yIndex, count)

    precondition(xIndex > -1 && yIndex > -1, "List: Negative index is out of range")
    precondition(xIndex < count && yIndex < count, "List: Index is out of range")

    (xIndex, yIndex) = swapIndex(xIndex, yIndex)

    var
      prev: UnsafeMutablePointer<ListNode<Element>>?,
      next: UnsafeMutablePointer<ListNode<Element>>?,
      temp: UnsafeMutablePointer<ListNode<Element>>!

    switch true {
    case xIndex < (count-1)/2:
      var curr: UnsafeMutablePointer<ListNode<Element>>! = firstNode
      var i = 0
      while i < xIndex {
        successor(&prev, &curr, &next)
        i += 1
      }
      temp = curr

      while i < yIndex {
        successor(&prev, &curr, &next)
        i += 1
      }

      let element = temp.pointee.element
      temp.pointee.element = curr.pointee.element
      curr.pointee.element = element

    default:
      var curr: UnsafeMutablePointer<ListNode<Element>>! = lastNode
      var i = count-1
      while i > yIndex {
        predecessor(&prev, &curr, &next)
        i -= 1
      }
      temp = curr

      while i > xIndex {
        predecessor(&prev, &curr, &next)
        i -= 1
      }

      let element = temp.pointee.element
      temp.pointee.element = curr.pointee.element
      curr.pointee.element = element
    }
  }
}