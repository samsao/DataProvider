//
//  CollectionViewProviderDelegateHandler.swift
//  Pods
//
//  Created by Guilherme Silva Lisboa on 2016-03-22.
//
//


open class CollectionViewProviderDelegateHandler: NSObject, UICollectionViewDelegate {
    
    open weak var provider : CollectionViewProvider!
    // MARK: UICollectionViewDelegate
    open func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        self.provider.delegate?.provider(self.provider, didDeselectCellAtIndexPath: indexPath)
    }
    
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.provider.delegate?.provider(self.provider, didSelectCellAtIndexPath: indexPath)
    }
}
