//
//  ProviderSection.swift
//  DataProvider
//
//  Created by Guilherme Silva Lisboa on 2015-12-22.
//  Copyright © 2015 Samsao. All rights reserved.
//

import Foundation

public struct ProviderSectionViewConfiguration {
    public internal(set) var view : UIView
    public internal(set) var height : CGFloat
    
    /**
     Initialize View configuration with a view and a height value for use as header or footer.
     
     - parameter view:       view.
     - parameter viewHeight: height for this view. If not specified uses view's frame height
     
     - returns: configuration with initialized values.
     */
    public init(view : UIView, viewHeight : CGFloat? = nil) {
        self.view = view
        self.height = viewHeight ?? view.frame.height
    }
}

public struct ProviderSection {
    // MARK: Properties
    public private(set) var headerViewConfiguration : ProviderSectionViewConfiguration?
    public private(set) var footerViewConfiguration : ProviderSectionViewConfiguration?
    public var items : [ProviderItem]
	
    // MARK: Intializers
	
    /**
     create new instance of a provider section with an array of items and possible configuration for header and footer views to be used in this section.
     
     - parameter items: items for the section.
     - parameter headerViewConfig: Header view configuration
     - parameter footerViewConfig: Footer view configuration
     
     - returns: new instance of a provider section.
     */
    public init(items : [ProviderItem], headerViewConfig : ProviderSectionViewConfiguration? = nil, footerViewConfig : ProviderSectionViewConfiguration? = nil) {
        self.items = items
        self.headerViewConfiguration = headerViewConfig
        self.footerViewConfiguration = footerViewConfig
    }
	
	// MARK: - Public API
    // MARK: Utility Methods
    
    
    /**
     Create collection of provider sections with an collection of dictionaries of reuse identifiers and data.
	
     - parameter sectionsData: collection of dictionaries where which dictionary represent the section data with it's reuse identifier and data.
     
     - returns: collection of provider sections filled with data.
     */
	//TODO: There's probably a better way to do this. The API is not really clean IMO - GC
    public static func sectionsCollectionWithData<T>(sectionsData : [[String : [T]]]) -> [ProviderSection]{
        var sections = [ProviderSection]()
        var section : ProviderSection!
        var item : ProviderItem!
        var items : [ProviderItem]!
		
		//FIXME: This should be optimized
        for data in sectionsData {
            items = [ProviderItem]()
            for cellReuseID in data.keys {
                for data in data[cellReuseID]! {
                    item = ProviderItem(data: data, cellReuseIdentifier: cellReuseID)
                    items.append(item)
                }
            }
            section = ProviderSection(items: items)
            sections.append(section)
        }
        return sections
    }
    
}
