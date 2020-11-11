extension List {
  public func slice(_ minIndex: Int, _ maxIndex: Int) -> List {
    let (minIndex, maxIndex) = fixRange(minIndex, maxIndex, count)

    precondition(minIndex > -1 && maxIndex > -1, "List: Negative index is out of range")
    precondition(minIndex < count && maxIndex < count, "List: Index is out of range")

    var subList = List()

    switch true {
    case maxIndex - minIndex == 0 || maxIndex == minIndex:
      // getting an element at specific index
      let element = self[minIndex]
      subList.append(self[minIndex])
      deallocate(element)

    case maxIndex < minIndex:
      // getting elements where start index is higher than end index
      // e.g. 
      //  let list = [1, 2, 3, 4, 5, 6]
      //  let sublist = list.range(-2, 2) // same as list.range(count-2, 2)
      //  print(sublist) // [5, 6, 1, 2, 3]

      var i = count-1
      var revItr = ListReversedIterator(self)
      while i > minIndex-1 {
        subList.prepend(revItr.next()!)
        i -= 1
      }

      i = 0
      var itr = ListIterator(self)
      while i < maxIndex+1 {
        subList.append(itr.next()!)
        i += 1
      }

    case minIndex < (count-1)/2:
      // getting elements near first half
      
      var i = 0
      var itr = ListIterator(self)

      while i < minIndex {
        itr.next()
        i += 1
      }

      repeat {
        subList.append(itr.next()!)
        i += 1
      } while i < maxIndex + 1

    default:
      // getting elements near last half

      var i = count-1
      var itr = ListReversedIterator(self)

      while i > maxIndex {
        itr.next()
        i -= 1
      }

      repeat {
        subList.prepend(itr.next()!)
        i -= 1
      } while i > minIndex - 1
    }

    return subList
  }
}