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
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: #selector(CollectionViewExampleController.addPerson)), UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: #selector(CollectionViewExampleController.resetData))]
        
    }
    
    private func createCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.Vertical
        layout.itemSize = CGSize(width: view.frame.size.width,height: 100)
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        self.collectionView = collectionView
        collectionView.backgroundColor = UIColor.whiteColor()
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
    func provider(provider: CollectionViewProvider, didDeselectCellAtIndexPath indexPath: NSIndexPath) {
        
    }
    

    func provider(provider: CollectionViewProvider, didSelectCellAtIndexPath indexPath: NSIndexPath) {
        let item : ProviderItem = provider.providerItemAtIndexPath(indexPath)!
        let data = item.data as! Person
        
        let alert = UIAlertController(title: "selected cell", message: "person name: \(data.name,data.lastName)", preferredStyle: UIAlertControllerStyle.Alert)
        
        //Delete row
        alert.addAction(UIAlertAction(title: "Delete Cell", style: UIAlertActionStyle.Destructive, handler: {[weak self] (action) -> Void in
            provider.removeItems([indexPath])
            self?.dismissViewControllerAnimated(true, completion: nil)
            }))
        
        //Dismiss view
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: {[weak self] (action) -> Void in
            self?.dismissViewControllerAnimated(true, completion: nil)
            }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
