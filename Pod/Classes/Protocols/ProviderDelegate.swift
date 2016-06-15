//
//  ProviderDelegate.swift
//  Pods
//
//  Created by Guilherme Silva Lisboa on 2015-12-22.
//
//

import Foundation

public protocol TableViewProviderDelegate: class {

	/**
	 Called when a cell of the table view is selected.

	 - parameter provider:  table view provider object.
	 - parameter indexPath: index path of the selected item.
	 */
	func provider(provider: TableViewProvider, didSelectCellAtIndexPath indexPath: NSIndexPath)

	/**
	 Called when a cell of the table view is deselected.

	 - parameter provider:  table view provider object.
	 - parameter indexPath: index path of the selected item.
	 */
	func provider(provider: TableViewProvider, didDeselectCellAtIndexPath indexPath: NSIndexPath)
}

public protocol CollectionViewProviderDelegate: class {
	/**
	 Called when a cell of the collection view is selected.

	 - parameter provider:  collection view provider.
	 - parameter indexPath: index path of the selected item.
	 */
	func provider(provider: CollectionViewProvider, didSelectCellAtIndexPath indexPath: NSIndexPath)

	/**
	 Called when a cell of the collection is deselected.

	 - parameter provider:  collection view provider object.
	 - parameter indexPath: index path of the selected item.
	 */
	func provider(provider: CollectionViewProvider, didDeselectCellAtIndexPath indexPath: NSIndexPath)
}