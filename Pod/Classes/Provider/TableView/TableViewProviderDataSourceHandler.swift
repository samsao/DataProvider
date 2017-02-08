//
//  TableViewProviderDataSourceHandler.swift
//  Pods
//
//  Created by Guilherme Silva Lisboa on 2016-03-22.
//
//

import UIKit

open class TableViewProviderDataSourceHandler : NSObject, UITableViewDataSource{
    // MARK: Properties
    
    open weak var provider : TableViewProvider!
    
    // MARK: UITableViewDataSource
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        return self.provider.sections.count
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.provider.sections[section].items.count
    }
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let providerItem : ProviderItem = self.provider.sections[indexPath.section].items[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: providerItem.cellReusableIdentifier)! as UITableViewCell
        
        if let cellProtocol = cell as? ProviderCellProtocol {
            cellProtocol.configureCell(providerItem.data)
        }
        return cell
    }
}
