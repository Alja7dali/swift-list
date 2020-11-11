extension List {
  // Reverses the elements of the list in place.
  public mutating func reverse() {
    let temp = firstNode
    firstNode = lastNode
    lastNode = temp
  }

  // Returns a view presenting the elements of the list in reverse order.
  public func reversed() -> List {
    var list = clone(self)
    list.reverse()
    return list
  }
}