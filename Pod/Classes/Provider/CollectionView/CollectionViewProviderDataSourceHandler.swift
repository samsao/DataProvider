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
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.provider.sections[section].items.count
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.provider.sections.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item : ProviderItem = self.provider.sections[indexPath.section].items[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.cellReusableIdentifier, for: indexPath)
        
        if let cellProtocol = cell as? ProviderCellProtocol {
            cellProtocol.configureCell(cellData: item.data)
        }
        
        return cell
    }
}
