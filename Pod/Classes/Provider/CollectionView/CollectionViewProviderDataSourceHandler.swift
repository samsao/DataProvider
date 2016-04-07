//
//  CollectionViewProviderDataSourceHandler.swift
//  Pods
//
//  Created by Guilherme Silva Lisboa on 2016-03-22.
//
//

public class CollectionViewProviderDataSourceHandler: NSObject, UICollectionViewDataSource {

    public weak var provider : CollectionViewProvider!
    
    // MARK: UICollectionViewDataSource
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.provider.sections[section].items.count
    }
    
    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.provider.sections.count
    }
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let item : ProviderItem = self.provider.sections[indexPath.section].items[indexPath.row]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(item.cellReusableIdentifier, forIndexPath: indexPath)
        
        if let cellProtocol = cell as? ProviderCellProtocol {
            cellProtocol.configureCell(item.data)
        }
        
        return cell
    }
}
