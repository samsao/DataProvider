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
    public func providerItemAtIndexPath(indexPath : IndexPath) -> ProviderItem? {
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
    internal func addSections(sections : [ProviderSection]) -> IndexSet{
        var range : NSRange = NSRange()
        range.location = self.sections.count
        range.length = sections.count
        let indexSet : IndexSet = IndexSet(integersIn: range.toRange() ?? 0..<0)
        self.sections.append(contentsOf: sections)
        return indexSet
    }
    
    /**
    Add section to provider
    
    - parameter section:   section to be added.
    - parameter index: index for the section to be added.
    */
    internal func addSection(section : ProviderSection, index : Int) {
        self.sections.insert(section, at: index)
        
    }
    
    /**
     Remove sections with a index set.
     
     - parameter indexes: index set with sections indexes to be deleted.
     */
    internal func removeSections(indexes : IndexSet) {
        self.sections.removeObjectsWith(indexSet: indexes)
    }
    
    /**
     Remove sections of the provider.
     
     - parameter sectionsToRemove: array of sections to remove in the provider.
     - returns: index set of removed sections.
     */
    internal func removeSections(_ removeBlock : ProviderRemoveSectionBlock) -> IndexSet {
        var indexSet = IndexSet()
        
        for (index, section) in self.sections.enumerated() {
            
            if removeBlock(section: section) {
				indexSet.insert(index)
            }
        }
		
        self.sections.removeObjectsWith(indexSet: indexSet)
        
        return indexSet
    }
    
    // MARK: Items
    
    /**
    Add Item to provider at a index path
    
    - parameter item:      item to be added.
    - parameter indexPath: index path to add this item at.
    */
    internal func addItemToProvider(item : ProviderItem, atIndexPath indexPath : IndexPath) {
        self.sections[indexPath.section].items.insert(item, at: indexPath.row)
    }
    
    /**
     Add an array of items in a section of the provider.
     
     - parameter items:   items to be added.
     - parameter section: index of the provider section to add the items.
     */
    internal func addItemsToProvider(items : [ProviderItem], inSection sectionIndex : Int) {
        self.sections[sectionIndex].items.append(contentsOf: items)
    }
    
    /**
     Remove items from provider
     
     - parameter removeBlock:  Block to remove the item.
     - parameter sectionIndex: section index to remove this items from.
     
     - returns: indexes of the deleted items in the section.
     */
    internal func removeItems(removeBlock : ProviderRemoveItemBlock, inSection sectionIndex : Int) -> IndexSet{
        
        var indexSet = IndexSet()
        
        for (index, item) in self.sections[sectionIndex].items.enumerated() {
            
            if removeBlock(item: item) {
                indexSet.insert(index)
            }
        }
		
        self.sections[sectionIndex].items.removeObjectsWith(indexSet: indexSet)
        return indexSet
    }
    
    /**
     Remove items at index paths
     
     - parameter indexPaths: index paths to be removed.
     */
    internal func removeItems(indexPaths : [IndexPath]) {
        indexPaths.forEach { (indexPath) in
            self.sections[indexPath.section].items.remove(at: indexPath.row);
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
    
	internal func nullifyDelegates() {
		return
	}
}
