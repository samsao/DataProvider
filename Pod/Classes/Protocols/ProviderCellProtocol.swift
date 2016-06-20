//
//  ProviderCellProtocol.swift
//  DataProvider
//
//  Created by Guilherme Silva Lisboa on 2015-12-22.
//  Copyright © 2015 Samsao. All rights reserved.
//

import Foundation

public protocol ProviderCellProtocol {
    
    /**
     Configure the cell with received data.
     
     - parameter cellData: data object in provider item.
     */
    func configureCell(_ cellData : Any)
}
