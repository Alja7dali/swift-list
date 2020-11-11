extension List {
  // Moves the end N of elements to the start of the list.
  public mutating func rotateRight(_ n: Int = 1) {
    guard count > 0 && n != 0 else { return }

    var n = fixIndex(n, count)

    while n > 0 {
      prepend(lastNode.pointee.element)
      deleteLast()
      n -= 1
    }
  }

  // Moves the start N of elements to the end of the list.
  public mutating func rotateLeft(_ n: Int = 1) {
    guard count > 0 && n != 0 else { return }

    var n = fixIndex(n, count)

    while n > 0 {
      append(firstNode.pointee.element)
      deleteFirst()
      n -= 1
    }
  }
}