//
//  CollectionViewProviderDataSourceHandler.swift
//  Pods
//
//  Created by Guilherme Silva Lisboa on 2016-03-22.
//
//

open class CollectionViewProviderDataSourceHandler: NSObject, UICollectionViewDataSource {

    open weak var provider : CollectionViewProvider!
    
    // MARK: UICollectionViewDataSource
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.provider.sections[section].items.count
    }
    
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.provider.sections.count
    }
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item : ProviderItem = self.provider.sections[indexPath.section].items[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.cellReusableIdentifier, for: indexPath)
        
        if let cellProtocol = cell as? ProviderCellProtocol {
            cellProtocol.configureCell(item.data)
        }
        
        return cell
    }
}
