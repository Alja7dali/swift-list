extension List {
  // Reorders the elements of the list such that all the elements that match the given predicate are after all the elements that don’t match.
  @discardableResult
  public mutating func partition(by belongsInSecondPartition: (Element) throws -> Bool) rethrows -> Int {
    var pivotIndex = 0

    var partitionedList = List()

    while count > 0 {
      if try belongsInSecondPartition(firstNode.pointee.element) {
        partitionedList.append(firstNode.pointee.element)
      } else {
        partitionedList.prepend(firstNode.pointee.element)
        pivotIndex += 1
      }
      deleteFirst()
    }

    self = partitionedList
    return pivotIndex
  }
}