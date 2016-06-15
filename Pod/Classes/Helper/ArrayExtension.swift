//
//  ArrayExtension.swift
//  Pods
//
//  Created by Guilherme Silva Lisboa on 2016-01-15.
//
//

import Foundation

internal extension Array {

	/**
	 Remove objects with index set.

	 - parameter indexSet: index set to remove the objects.
	 */
	mutating func removeObjectsWithIndexSet(indexSet: NSIndexSet) {

		var removedIndexes = [Int]()
		indexSet.enumerateIndexesUsingBlock { (index, stop) -> Void in
			self.removeAtIndex(index - removedIndexes.numberOfElementsLessThan(index))
			removedIndexes.append(index)
		}

	}

}

private extension Array where Element: Comparable {
	/**
	 Get the number of elements in the array that are less than the element sent.

	 - parameter value: element to be compared to

	 - returns: number of elements lower than the compared.
	 */
	func numberOfElementsLessThan(value: Element) -> Int {
		var amount = 0
		self.forEach { (element) in
			if (element < value) {
				amount += 1
			}
		}
		return amount
	}
}