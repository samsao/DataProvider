//
//  CollectionViewProviderDelegateHandler.swift
//  Pods
//
//  Created by Guilherme Silva Lisboa on 2016-03-22.
//
//


public class CollectionViewProviderDelegateHandler: NSObject, UICollectionViewDelegate {
    
    public weak var provider : CollectionViewProvider!
    // MARK: UICollectionViewDelegate
    public func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        self.provider.delegate?.provider(self.provider, didDeselectCellAtIndexPath: indexPath)
    }
    
    public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.provider.delegate?.provider(self.provider, didSelectCellAtIndexPath: indexPath)
    }
}
