//
//  TableViewExampleController.swift
//  DataProvider
//
//  Created by Guilherme Silva Lisboa on 2016-03-16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import DataProvider

let kCellRID : String = "MycellRID"

class TableViewExampleController: UIViewController {
    
    private var tableView : UITableView!
    private var provider : TableViewProvider!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: view.frame,style: UITableViewStyle.grouped)
        view.addSubview(tableView)
        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(TableViewExampleController.addPerson)), UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.refresh, target: self, action: #selector(TableViewExampleController.resetData))]
        self.createProvider()
    }
    
    /**
     Example of how to create section header/Footer view configuration to be used in the table view.
     */
    private func createSectionViewConfig(text : String, bgColor : UIColor) -> ProviderSectionViewConfiguration {
        
        //Create your view as needed.
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 50))
        view.backgroundColor = bgColor
        let label = UILabel(frame: view.frame)
        label.text = text
        label.textColor = .white
        view.addSubview(label)
        
        //Initialize the configuration sending your view as parameter. You can also set a custom height for the configuration in case your view uses autolayout
        let config = ProviderSectionViewConfiguration(view: view)
        return config
    }
    
    func addPerson() {
        let item = ProviderItem(data: Person(name: "PersonName", lastName: "\(NSDate())"), cellReuseIdentifier: kCellRID)
        provider.addItemsToProvider(items: [item], inSection: 0, rowAnimation: UITableViewRowAnimation.automatic)
    }
    
    func resetData() {
        let headerConfig = self.createSectionViewConfig(text: "Section 1 Header", bgColor: UIColor.black)
        let footerConfig = self.createSectionViewConfig(text: "Section 1 Footer", bgColor: .lightGray)
        let section1 = ProviderSection(items: ProviderItem.itemsCollectionWithData(dataArray: Person.peopleCollection(), cellReuseIdentifier: kCellRID), headerViewConfig: headerConfig, footerViewConfig: footerConfig)
        
        
        
        let headerConfig2 = self.createSectionViewConfig(text: "Section 2 Header", bgColor: .black)
        let footerConfig2 = self.createSectionViewConfig(text: "Section 2 Footer", bgColor: .lightGray)
        let section2 = ProviderSection(items: ProviderItem.itemsCollectionWithData(dataArray: Person.peopleCollection(), cellReuseIdentifier: kCellRID), headerViewConfig: headerConfig2, footerViewConfig: footerConfig2)
        
        
        
        provider.updateProviderData(newSections: [section1,section2])
    }
    
    private func createProvider() {
        let data = Person.peopleCollection()
        
        //Create the items and sections for the provider to use.
        let providerItems : [ProviderItem] = ProviderItem.itemsCollectionWithData(dataArray: data, cellReuseIdentifier: kCellRID)
        let section = ProviderSection(items: providerItems)
        
        //Optional provider configuration
        let providerConfig = ProviderConfiguration(reuseIdentifier: kCellRID, cellClass: UITableViewCell.self)
        
        //Create the provider object
        let provider = TableViewProvider(withTableView: tableView, sections: [section], delegate: self, cellConfiguration: [providerConfig])
        self.provider = provider
    }
}

extension TableViewExampleController : TableViewProviderDelegate {
    /**
     Called when a cell of the table view is deselected.
     
     - parameter provider:  table view provider object.
     - parameter indexPath: index path of the selected item.
     */

    public func provider(provider: TableViewProvider, didDeselectCellAtIndexPath indexPath: IndexPath) {
        
    }
    
    public func provider(provider : TableViewProvider, didSelectCellAtIndexPath indexPath: IndexPath) {
        let item: ProviderItem = provider.providerItemAtIndexPath(indexPath: indexPath)!
        let data = item.data as! Person
        
        let alert = UIAlertController(title: "selected cell", message: "person name: \(data.name,data.lastName)", preferredStyle: UIAlertControllerStyle.alert)
        
        //Delete row
        alert.addAction(UIAlertAction(title: "Delete Cell", style: UIAlertActionStyle.destructive, handler: {[weak self] (action) -> Void in
            //You can either remove with index paths
            
//            provider.removeItems([indexPath])
            
            //Or with a block, up to your need
            
            provider.removeItems(removeBlock: { (item) -> Bool in
                if let otherPerson = item.data as? Person {
                    return data.fullName() == otherPerson.fullName()
                }
                return false
            }, inSection: indexPath.section)
            
//            provider.removeItems({ (item) -> Bool in
//                if let otherPerson = item.data as? Person {
//                    return data.fullName() == otherPerson.fullName()
//                }
//                return false
//                }, inSection: indexPath.section)
            
                self?.dismiss(animated: true, completion: nil)
            }))
        
        
        //Dismiss view
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: {[weak self] (action) -> Void in
            self?.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension UITableViewCell : ProviderCellProtocol {
    public func configureCell(cellData: Any) {
        if let person = cellData as? Person {
            textLabel?.text = person.name + " " + person.lastName
        }
    }
}
