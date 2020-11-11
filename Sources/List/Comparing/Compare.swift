extension List {
  public func compare<C: Collection>(_ collection: C) -> Int where C.Element == Element {
    return count - collection.count
  }
}