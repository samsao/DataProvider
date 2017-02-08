//
//  CollectionViewExampleController.swift
//  DataProvider
//
//  Created by Guilherme Silva Lisboa on 2016-03-16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import DataProvider

class CollectionViewExampleController: UIViewController {
    var collectionView : UICollectionView!
    var provider : CollectionViewProvider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createCollectionView()
        createProvider()
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(CollectionViewExampleController.addPerson)), UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(CollectionViewExampleController.resetData))]
        
    }
    
    private func createCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        layout.itemSize = CGSize(width: view.frame.size.width,height: 100)
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        self.collectionView = collectionView
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
    }
    
    private func createProvider() {
        let providerConfig = ProviderConfiguration(reuseIdentifier: kCellRID, cellClass: CustomCollectionCell.self)
        let items = ProviderItem.itemsCollectionWithData(Person.peopleCollection(), cellReuseIdentifier: kCellRID)
        let section = ProviderSection.init(items: items)
        let provider = CollectionViewProvider(withCollectionView: collectionView, sections: [section], delegate: self, cellConfiguration: [providerConfig])
        self.provider = provider
    }
    
    func addPerson() {
        let item = ProviderItem(data: Person(name: "PersonName", lastName: "\(NSDate())"), cellReuseIdentifier: kCellRID)
        provider.addItemsToProvider([item], inSection: 0)
    }
    
    func resetData() {
        let sectionData : [[String : [Person]]] = [[kCellRID : Person.peopleCollection()]]
        
        let sections = ProviderSection.sectionsCollectionWithData(sectionData)
        provider.updateProviderData(sections)
    }
    
    
}

extension CollectionViewExampleController : CollectionViewProviderDelegate {
    /**
     Called when a cell of the collection is deselected.
     
     - parameter provider:  collection view provider object.
     - parameter indexPath: index path of the selected item.
     */
	public func provider(_ provider: CollectionViewProvider, didDeselectCellAtIndexPath indexPath: IndexPath) {

	}

	public func provider(_ provider: CollectionViewProvider, didSelectCellAtIndexPath indexPath: IndexPath) {

	}

    /**
     Called when a cell of the collection view is selected.
     
     - parameter provider:  collection view provider.
     - parameter indexPath: index path of the selected item.
     */
    public func provider(provider: CollectionViewProvider, didSelectCellAtIndexPath indexPath: IndexPath) {
        let item : ProviderItem = provider.providerItemAtIndexPath(indexPath)!
        let data = item.data as! Person
        
        let alert = UIAlertController(title: "selected cell", message: "person name: \(data.name,data.lastName)", preferredStyle: UIAlertControllerStyle.alert)
        
        //Delete row
        alert.addAction(UIAlertAction(title: "Delete Cell", style: UIAlertActionStyle.destructive, handler: {[weak self] (action) -> Void in
            provider.removeItems([indexPath])
            self?.dismiss(animated: true, completion: nil)
            }))
        
        //Dismiss view
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: {[weak self] (action) -> Void in
            self?.dismiss(animated: true, completion: nil)
            }))
        self.present(alert, animated: true, completion: nil)
    }


}
