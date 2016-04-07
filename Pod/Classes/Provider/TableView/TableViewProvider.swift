//
//  ProviderTableView.swift
//  Pods
//
//  Created by Guilherme Silva Lisboa on 2015-12-22.
//
//

import UIKit

public class TableViewProvider : Provider {
	
	// MARK: Properties
	
	public weak var delegate : TableViewProviderDelegate?
	private unowned var tableView : UITableView
    private var tableViewDelegate : TableViewProviderDelegateHandler!
    private var tableViewDataSource : TableViewProviderDataSourceHandler!
	// MARK: Initialization
	
	/**
	Initialize table view provider for use on table view.
	
	- parameter tableView: provider's table view.
	- parameter sections:  initial sections data for the table view.
	- parameter delegate:  provider delegate.
	- parameter cellConfiguration : configuration for the provider cells registration on the table view.
	
	- returns: instance of the provider.
	*/
    public init(withTableView tableView: UITableView, sections: [ProviderSection],
                              delegate : TableViewProviderDelegate?, cellConfiguration : [ProviderConfiguration],
                              tableDelegate : TableViewProviderDelegateHandler = TableViewProviderDelegateHandler(), tableDataSource : TableViewProviderDataSourceHandler = TableViewProviderDataSourceHandler()) {
        self.delegate = delegate
        self.tableView = tableView        
		super.init(withSections: sections)
		self.configureTableView(cellConfiguration, tableDelegate: tableDelegate, tableDataSource: tableDataSource)
	}
    
	// MARK: - Public API
	// MARK: Section
	/**
	Add sections to table view.
	
	- parameter sections:     sections to be added.
	- parameter rowAnimation: UITableViewRowAnimation for the sections.
	*/
	public func addSections(sections: [ProviderSection], rowAnimation : UITableViewRowAnimation = UITableViewRowAnimation.Automatic) {
		let indexSet : NSIndexSet = super.addSections(sections)
		self.tableView.insertSections(indexSet, withRowAnimation: rowAnimation)
	}
	
	/**
	Add section to table view in a specific index.
	
	- parameter section:      section to be added.
	- parameter index:        index of the section to be added.
	- parameter rowAnimation: UITableViewRowAnimation for section insert.
	*/
	public func addSection(section: ProviderSection, index: Int, rowAnimation : UITableViewRowAnimation = UITableViewRowAnimation.Automatic) {
		super.addSection(section, index: index)
		self.tableView.insertSections(NSIndexSet(index: index), withRowAnimation: rowAnimation)
	}
	
	/**
	remove sections from table view.
	
	- parameter removeBlock: block to remove the sections with. return true to remove, false otherwise.
	- parameter rowAnimation:     UITableViewRowAnimation for the deletion.
	*/
	public func removeSections(removeBlock : ProviderRemoveSectionBlock, rowAnimation : UITableViewRowAnimation = UITableViewRowAnimation.Automatic) {
		let indexSet : NSIndexSet = super.removeSections(removeBlock)
		self.tableView.deleteSections(indexSet, withRowAnimation: rowAnimation)
	}
	
	/**
	Remove Sections at indexes in an index set.
	
	- parameter indexes:      index set
	- parameter rowAnimation: UITableViewRowAnimation for the deletion.
	*/
	public func removeSections(atIndexes indexes: NSIndexSet, rowAnimation : UITableViewRowAnimation = UITableViewRowAnimation.Automatic) {
		super.removeSections(indexes)
		self.tableView.deleteSections(indexes, withRowAnimation: rowAnimation)
	}
	
	// MARK: Items
	/**
	Add items to table view in a specific section.
	
	- parameter items:        items to be added.
	- parameter sectionIndex: index of section to add items.
	- parameter rowAnimation: UITableViewRowAnimation for the insertion.
	*/
	public func addItemsToProvider(items: [ProviderItem], inSection sectionIndex: Int, rowAnimation : UITableViewRowAnimation = UITableViewRowAnimation.Automatic) {
		let initialPosition = self.sections[sectionIndex].items.count
		super.addItemsToProvider(items, inSection: sectionIndex)
		
		var indexPaths : [NSIndexPath] = []
		for i in initialPosition..<self.sections[sectionIndex].items.count {
			indexPaths.append(NSIndexPath(forRow: i, inSection: sectionIndex))
		}
		self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: rowAnimation)
	}
	
    /**
     Insert Items in provider from a specific index path.
     
     - parameter items:        items to be inserted
     - parameter indexPath:    starting index path
     - parameter rowAnimation: UITableViewRowAnimation for the insertion.
     */
    public func insertItemsToProvider(items: [ProviderItem], fromIndexPath indexPath: NSIndexPath, rowAnimation: UITableViewRowAnimation) {
        var indexPaths = [NSIndexPath]()
        for (index, item) in items.enumerate() {
            let newIndexPath = NSIndexPath(forRow: indexPath.row + index, inSection: indexPath.section)
            indexPaths.append(newIndexPath)
            super.addItemToProvider(item, atIndexPath: newIndexPath)
        }
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: rowAnimation)
    }

    
	/**
	Add item to provider in a specific index path.
	
	- parameter item:         item to be added.
	- parameter indexPath:    index path to add the item.
	- parameter rowAnimation: UITableViewRowAnimation for the insertion.
	*/
	public func addItemToProvider(item: ProviderItem, atIndexPath indexPath: NSIndexPath, rowAnimation : UITableViewRowAnimation = UITableViewRowAnimation.Automatic) {
		super.addItemToProvider(item, atIndexPath: indexPath)
		
		self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: rowAnimation)
	}
	
    
    
    /**
     Remove items in a section with a block.
     
     - parameter removeBlock:  Items to be removed from section.
     - parameter sectionIndex: index of the section to remove those items.
     - parameter rowAnimation: row animation for the deletion.
     */
    public func removeItems(removeBlock : ProviderRemoveItemBlock, inSection sectionIndex: Int, rowAnimation : UITableViewRowAnimation = UITableViewRowAnimation.Automatic)  {
        let indexSet : NSIndexSet = super.removeItems(removeBlock, inSection: sectionIndex)
        
        var indexPaths : [NSIndexPath] = []
        
        indexSet.enumerateIndexesUsingBlock { (index, stop) -> Void in
            indexPaths.append(NSIndexPath(forRow: index, inSection: sectionIndex))
        }
        
        self.tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: rowAnimation)
    }
	
    /**
     Remove items at index paths from provider and table view.
     
     - parameter indexPaths:   index paths of items to be removed.
     - parameter rowAnimation: row animation for the deletion.
     */
    public func removeItems(indexPaths : [NSIndexPath], rowAnimation : UITableViewRowAnimation = UITableViewRowAnimation.Automatic) {
        super.removeItems(indexPaths)
		
        self.tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: rowAnimation)
    }
    
	// MARK: Update
	
	override public func updateProviderData(newSections: [ProviderSection]) {
		super.updateProviderData(newSections)
		self.tableView.reloadData()
	}
	
	/**
	Replace the data in a table view section.
	
	- parameter newItems:     new items for the section
	- parameter sectionIndex: index of the section to update.
	- parameter rowAnimation: UITableViewRowAnimation for the operation.
	*/
	public func updateSectionData(newItems: [ProviderItem], sectionIndexToUpdate sectionIndex: Int, rowAnimation : UITableViewRowAnimation = UITableViewRowAnimation.Automatic) {
		super.updateSectionData(newItems, sectionIndexToUpdate: sectionIndex)
		self.tableView.reloadSections(NSIndexSet(index: sectionIndex), withRowAnimation: rowAnimation)
	}
	
	// MARK: - Private API
	// MARK: Configuration
	
	/**
	Configure table view for use with provider.
	
	- parameter tableView:     table view to be configured.
	- parameter configuration: extra configuration for cells if desired.
	*/
	private func configureTableView (configuration : [ProviderConfiguration], tableDelegate : TableViewProviderDelegateHandler, tableDataSource : TableViewProviderDataSourceHandler) {
        
        self.tableViewDelegate = tableDelegate
        self.tableViewDataSource = tableDataSource
        
        tableDataSource.provider = self
        tableDelegate.provider = self
        
        self.tableView.delegate = tableDelegate
        self.tableView.dataSource = tableDataSource
        
		
		for config in configuration {
			if (config.cellClass != nil) {
				tableView.registerClass(config.cellClass, forCellReuseIdentifier: config.cellReuseIdentifier)
			} else {
				tableView.registerNib(UINib(nibName: config.cellNibName!, bundle: config.nibBundle), forCellReuseIdentifier: config.cellReuseIdentifier)
			}
		}
	}
}
