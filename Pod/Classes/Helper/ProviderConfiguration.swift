//
//  ProviderConfiguration.swift
//  Pods
//
//  Created by Guilherme Silva Lisboa on 2016-01-15.
//
//

import Foundation

/*
 *	The ProviderConfiguration defines a cell reusable identifier with it's cell declaration (class name or nib name)
 */
public struct ProviderConfiguration {
	internal let cellReuseIdentifier: String
	internal let cellClass: AnyClass?
	internal let cellNibName: String?
	internal let nibBundle: NSBundle?

	public init(reuseIdentifier: String, cellClass: AnyClass) {
		self.cellReuseIdentifier = reuseIdentifier
		self.cellClass = cellClass
		self.cellNibName = nil
		self.nibBundle = nil
	}

	public init(reuseIdentifier: String, cellNibName: String, nibBundle: NSBundle? = nil) {
		self.cellReuseIdentifier = reuseIdentifier
		self.cellNibName = cellNibName
		self.nibBundle = nibBundle
		self.cellClass = nil
	}
}