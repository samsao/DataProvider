//
//  TableViewProviderDelegateHandler.swift
//  Pods
//
//  Created by Guilherme Silva Lisboa on 2016-03-22.
//
//

import UIKit

open class TableViewProviderDelegateHandler : NSObject, UITableViewDelegate {
    
    // MARK: Properties
    
    open weak var provider : TableViewProvider!
    
    // MARK: - UITableViewDelegate
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.provider.delegate?.provider(self.provider, didSelectCellAtIndexPath: indexPath)
    }
    
    open func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.provider.delegate?.provider(self.provider, didDeselectCellAtIndexPath: indexPath)
    }
    
    // MARK: Header
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.provider.sections[section].headerViewConfiguration?.view
    }
    
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.provider.sections[section].headerViewConfiguration?.height ?? 0
    }
    
    // MARK: Footer
    
    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return self.provider.sections[section].footerViewConfiguration?.view
    }
    
    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self.provider.sections[section].footerViewConfiguration?.height ?? 0
    }
}
