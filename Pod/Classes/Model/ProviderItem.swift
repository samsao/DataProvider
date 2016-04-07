//
//  ProviderItem.swift
//  DataProvider
//
//  Created by Guilherme Silva Lisboa on 2015-12-22.
//  Copyright © 2015 Samsao. All rights reserved.
//

import Foundation

public struct ProviderItem {
    // MARK: Properties
    public private(set) var cellReusableIdentifier : String
    public private(set) var data: Any
   
    // MARK: Initializers
    /**
     create new instance of provider item
     
     - parameter data:                data for the item
     - parameter cellReuseIdentifier: cell reusable identifier
     
     - returns: instance of a provider item
     */
    public init(data : Any, cellReuseIdentifier : String) {
        self.data = data
        self.cellReusableIdentifier = cellReuseIdentifier
    }
	
	// MARK: - Public API
    // MARK: Utility Methods
    
    /**
     Create a collection of Provider items with the same cellIdentifier from data collection.
     
     - parameter dataArray:           Array with data to be used into the cells
     - parameter cellReuseIdentifier: cell reuse Identifier
     
     - returns: collection of provider items with data.
     */
    public static func itemsCollectionWithData(dataArray : [Any], cellReuseIdentifier : String) -> [ProviderItem] {
        var items = [ProviderItem]()
        for data in dataArray {
            let item: ProviderItem = ProviderItem(data: data, cellReuseIdentifier: cellReuseIdentifier)
            items.append(item)
        }
        return items
    }
    
}