//
//  CollectionViewProvider.swift
//  Pods
//
//  Created by Guilherme Silva Lisboa on 2015-12-23.
//
//

import UIKit

public class CollectionViewProvider: Provider {
	
	// MARK: Properties
	
	public weak var delegate : CollectionViewProviderDelegate?
	private unowned var collectionView : UICollectionView
    
    private var collectionDelegate : CollectionViewProviderDelegateHandler!
    private var collectionDataSource : CollectionViewProviderDataSourceHandler!
    
	// MARK: Initialization
	
	/**
	Intialize provider with collection view, .
	
	- parameter sections: array of sections for the provider.
	- parameter delegate: collection view provider delegate.
	- parameter cellConfiguration: provider cell Configuration for register cells on collection view.
	
	- returns: instance of created provider.
	*/
    public init(withCollectionView collectionView: UICollectionView, sections: [ProviderSection], delegate : CollectionViewProviderDelegate?, cellConfiguration : [ProviderConfiguration],
                                   collectionDelegate : CollectionViewProviderDelegateHandler = CollectionViewProviderDelegateHandler(), collectionDataSource : CollectionViewProviderDataSourceHandler = CollectionViewProviderDataSourceHandler()) {
		self.delegate = delegate
		self.collectionView = collectionView
		super.init(withSections: sections)
		self.configureCollectionView(configuration: cellConfiguration, collectionDelegate: collectionDelegate, collectionDataSource: collectionDataSource)
	}
	
	// MARK: - Public API
	// MARK: Section
	/**
	Add sections to collection view.
	
	- parameter sections:     sections to be added.
	*/
	public func addSections(sections: [ProviderSection]) {
		let indexSet : IndexSet = super.addSections(sections: sections)
		self.collectionView.insertSections(indexSet)
	}
	
	/**
	Add section to collection view in a specific index.
	
	- parameter section:      section to be added.
	- parameter index:        index of the section to be added.
	*/
	override public func addSection(section: ProviderSection, index: Int) {
		super.addSection(section: section, index: index)
		self.collectionView.insertSections(IndexSet(integer: index))
	}
	
	/**
	remove sections from collection view.
	
	- parameter removeBlock: block to remove the sections with. return true to remove, false otherwise.
	*/
	public func removeSections(removeBlock : ProviderRemoveSectionBlock) {
		let indexSet : IndexSet = super.removeSections(removeBlock)
		self.collectionView.deleteSections(indexSet)
	}
	
	/**
	Remove Sections at indexes in an index set.
	
	- parameter indexes:      index set
	*/
	override public func removeSections(indexes: IndexSet) {
		super.removeSections(indexes: indexes)
		self.collectionView.deleteSections(indexes)
	}
	
	// MARK: Items
	/**
	Add items to collection view in a specific section.
	
	- parameter items:        items to be added.
	- parameter sectionIndex: index of section to add items.
	*/
	override public func addItemsToProvider(items: [ProviderItem], inSection sectionIndex: Int) {
		let initialPosition = self.sections[sectionIndex].items.count
		super.addItemsToProvider(items: items, inSection: sectionIndex)
		
		var indexPaths : [IndexPath] = []
		for i in initialPosition..<self.sections[sectionIndex].items.count {
			indexPaths.append(IndexPath(row: i, section: sectionIndex))
		}
		self.collectionView.performBatchUpdates({ () -> Void in
			self.collectionView.insertItems(at: indexPaths)
			}, completion:  nil)
	}
	
    /**
     Insert Items in provider from a specific index path.
     
     - parameter items:        items to be inserted
     - parameter indexPath:    starting index path
     */
    public func insertItemsToProvider(items: [ProviderItem], fromIndexPath indexPath: IndexPath) {
        var indexPaths = [IndexPath]()
        for (index, item) in items.enumerated() {
            let newIndexPath = IndexPath(row: indexPath.row + index, section: indexPath.section)
            indexPaths.append(newIndexPath)
            super.addItemToProvider(item: item, atIndexPath: newIndexPath)
        }
        self.collectionView.performBatchUpdates({ () -> Void in
            self.collectionView.insertItems(at: indexPaths)
            }, completion:  nil)
    }
    
	/**
	Add item to provider in a specific index path.
	
	- parameter item:         item to be added.
	- parameter indexPath:    index path to add the item.
	*/
	override public func addItemToProvider(item: ProviderItem, atIndexPath indexPath: IndexPath) {
		super.addItemToProvider(item: item, atIndexPath: indexPath)
		self.collectionView.performBatchUpdates({ () -> Void in
			self.collectionView.insertItems(at: [indexPath])
			}, completion: nil)
	}
	
    /**
     Remove items in a section with a block.
     
     - parameter removeBlock:  Items to be removed from section.
     - parameter sectionIndex: index of the section to remove those items.
     */
    public func removeItems(removeBlock : ProviderRemoveItemBlock, inSection sectionIndex: Int)  {
        let indexSet : IndexSet = super.removeItems(removeBlock: removeBlock, inSection: sectionIndex)
        
        var indexPaths : [IndexPath] = []
		for (index, _) in indexSet.enumerated() {
			 indexPaths.append(IndexPath(row: index, section: sectionIndex))
		}
        self.collectionView.performBatchUpdates({ () -> Void in
            self.collectionView.deleteItems(at: indexPaths)
            }, completion: nil)
    }
    /**
     Remove items at index paths from provider and collection view.
     
     - parameter indexPaths:   index paths of items to be removed.
     */
    public override func removeItems(indexPaths : [IndexPath]) {
        super.removeItems(indexPaths: indexPaths)
        
        self.collectionView.performBatchUpdates({ 
            self.collectionView.deleteItems(at: indexPaths)
            }, completion: nil)
    }
	// MARK: Update
	
	override public func updateProviderData(newSections: [ProviderSection]) {
		super.updateProviderData(newSections: newSections)
		self.collectionView.reloadData()
	}
	
	/**
	Replace the data in a collection view section.
	
	- parameter newItems:     new items for the section
	- parameter sectionIndex: index of the section to update.
	*/
	override public func updateSectionData(newItems: [ProviderItem], sectionIndexToUpdate sectionIndex: Int) {
		super.updateSectionData(newItems: newItems, sectionIndexToUpdate: sectionIndex)
		self.collectionView.reloadSections(IndexSet(integer: sectionIndex))
	}

	/**
	Set dategate and dataSource of collectionView to nil.
	*/
	override public func nullifyDelegates() {
		collectionView.delegate = nil
		collectionView.dataSource = nil
	}
	
	// MARK: - Private API
	// MARK: Configuration
	
	/**
	Configure Collection view for use in the provider.
	
	- parameter collectionView: collection view to configure.
	- parameter configuration:  provider cell configuration
	*/
    private func configureCollectionView(configuration : [ProviderConfiguration],
                                         collectionDelegate : CollectionViewProviderDelegateHandler, collectionDataSource : CollectionViewProviderDataSourceHandler) {
        
        collectionDelegate.provider = self
        collectionDataSource.provider = self
        
        self.collectionDataSource = collectionDataSource
        self.collectionDelegate = collectionDelegate
        
        collectionView.delegate = collectionDelegate
		collectionView.dataSource = collectionDataSource
		
		for config in configuration {
			if (config.cellClass != nil) {
				collectionView.register(config.cellClass, forCellWithReuseIdentifier: config.cellReuseIdentifier)
			} else {
				collectionView.register(UINib(nibName: config.cellNibName!, bundle: config.nibBundle), forCellWithReuseIdentifier: config.cellReuseIdentifier)
			}
		}
	}
	
}
