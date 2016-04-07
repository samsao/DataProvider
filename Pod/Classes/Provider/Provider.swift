//
//  Provider.swift
//  Pods
//
//  Created by Guilherme Silva Lisboa on 2015-12-22.
//
//

public typealias ProviderRemoveItemBlock = ((item : ProviderItem) -> Bool)
public typealias ProviderRemoveSectionBlock = ((section : ProviderSection) -> Bool)

public class Provider {
    
    // MARK: Properties
    public private(set) var sections : [ProviderSection]
    
    // MARK: Initialization
    
    /**
    Initialize provider with array of elements
    
    - parameter sections: sections for the provider.
    
    - returns: instance of created provider.
    */
    internal init(withSections sections : [ProviderSection]) {
        self.sections = sections
    }
	
	// MARK: - Public API
    // MARK: Data Methods
    
    /**
    Get the provider item at a specific index path
    
    - parameter indexPath: index path of the desired item.
    
    - returns: item at that index path.
    */
    public func providerItemAtIndexPath(indexPath : NSIndexPath) -> ProviderItem? {
        if(indexPath.section < self.sections.count) {
            let section : ProviderSection = self.sections[indexPath.section]
            if(indexPath.row < section.items.count) {
                return section.items[indexPath.row]
            }
        }
        return nil
    }

    
    // MARK: Sections
    
    /**
    Add sections to provider.
    
    - parameter sections: sections to be added.
    
    - returns: indexset with added sections range.
    */
    internal func addSections(sections : [ProviderSection]) -> NSIndexSet{
        var range : NSRange = NSRange()
        range.location = self.sections.count
        range.length = sections.count
        let indexSet : NSIndexSet = NSIndexSet(indexesInRange: range)
        self.sections.appendContentsOf(sections)
        return indexSet
    }
    
    /**
    Add section to provider
    
    - parameter section:   section to be added.
    - parameter index: index for the section to be added.
    */
    internal func addSection(section : ProviderSection, index : Int) {
        self.sections.insert(section, atIndex: index)
        
    }
    
    /**
     Remove sections with a index set.
     
     - parameter indexes: index set with sections indexes to be deleted.
     */
    internal func removeSections(indexes : NSIndexSet) {
        self.sections.removeObjectsWithIndexSet(indexes)
    }
    
    /**
     Remove sections of the provider.
     
     - parameter sectionsToRemove: array of sections to remove in the provider.
     - returns: index set of removed sections.
     */
    internal func removeSections(removeBlock : ProviderRemoveSectionBlock) -> NSIndexSet {
        let indexSet = NSMutableIndexSet()
        
        for (index, section) in self.sections.enumerate() {
            
            if removeBlock(section: section) {
                indexSet.addIndex(index)
            }
        }
        self.sections.removeObjectsWithIndexSet(indexSet)
        
        return indexSet
    }
    
    // MARK: Items
    
    /**
    Add Item to provider at a index path
    
    - parameter item:      item to be added.
    - parameter indexPath: index path to add this item at.
    */
    internal func addItemToProvider(item : ProviderItem, atIndexPath indexPath : NSIndexPath) {
        self.sections[indexPath.section].items.insert(item, atIndex: indexPath.row)
    }
    
    /**
     Add an array of items in a section of the provider.
     
     - parameter items:   items to be added.
     - parameter section: index of the provider section to add the items.
     */
    internal func addItemsToProvider(items : [ProviderItem], inSection sectionIndex : Int) {
        self.sections[sectionIndex].items.appendContentsOf(items)
    }
    
    /**
     Remove items from provider
     
     - parameter removeBlock:  Block to remove the item.
     - parameter sectionIndex: section index to remove this items from.
     
     - returns: indexes of the deleted items in the section.
     */
    internal func removeItems(removeBlock : ProviderRemoveItemBlock, inSection sectionIndex : Int) -> NSIndexSet{
        
        let indexSet = NSMutableIndexSet()
        
        for (index, item) in self.sections[sectionIndex].items.enumerate() {
            
            if removeBlock(item: item) {
                indexSet.addIndex(index)
            }
        }

        self.sections[sectionIndex].items.removeObjectsWithIndexSet(indexSet)
        return indexSet
    }
    
    /**
     Remove items at index paths
     
     - parameter indexPaths: index paths to be removed.
     */
    internal func removeItems(indexPaths : [NSIndexPath]) {
        indexPaths.forEach { (indexPath) in
            self.sections[indexPath.section].items.removeAtIndex(indexPath.row);
        }
    }
    
    // MARK: update Data
    
    /**
    Replace provider data with new one.
    
    - parameter newSections: new provider data.
    */
    internal func updateProviderData(newSections : [ProviderSection]) {
        self.sections = newSections
    }
    
    /**
     Replace the data in a specific section in the provider for the new one.
     
     - parameter newItems:     new section data.
     - parameter sectionIndex: index of the section to replace the data.
     */
    internal func updateSectionData(newItems : [ProviderItem], sectionIndexToUpdate sectionIndex : Int) {
        self.sections[sectionIndex].items = newItems
        
    }
    
    
    
    
}
