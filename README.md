# DataProvider
Data provider is a library made to abstract Table and Collection views boilerplate code. It's all made in Swift!

[![CI Status](http://img.shields.io/travis/Guilherme Lisboa/DataProvider.svg?style=flat)](https://travis-ci.org/Guilherme Lisboa/DataProvider)
[![Version](https://img.shields.io/cocoapods/v/DataProvider.svg?style=flat)](http://cocoapods.org/pods/DataProvider)
[![License](https://img.shields.io/cocoapods/l/DataProvider.svg?style=flat)](http://cocoapods.org/pods/DataProvider)
[![Platform](https://img.shields.io/cocoapods/p/DataProvider.svg?style=flat)](http://cocoapods.org/pods/DataProvider)

## Table of Contents
- **[Features](#features)**  
- **[Installation](#installation)**  
- **[Usage](#usage)**  
- **[Classes & Structs](#classes-structs)**  
- **[Protocols](#protocols)**  
- **[Credits](#credits)**  
- **[License](#license)**  

## Features
We realized that every time we use a UITable/UICollection view there is a lot of repeated code and we came up with a solution capable of offering:
- Easy and fast setup
- Add, insert, remove or update your Table and Collection views data with in a simple method call
- Lighter controllers
- Abstracted logic
- Easily customizable
- Get rid of lots of boilerplate code from UIKit tools.

## Installation
### CocoaPods
DataProvider is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "DataProvider"
```
### Manually
Simply copy and paste the ```Classes``` folder and it's content into your project. It's all there!

## Usage
### Creating items
```swift
//Create a single item
let singleItem = ProviderItem(data: yourData, cellReuseIdentifier: "Your Cell Reuse ID")
//Suport method to create multiple items with same Cell Reuse Identifier.
let items : [ProviderItem] = ProviderItem.itemsCollectionWithData(yourDataArray, cellReuseIdentifier: "Your Cell Reuse ID")
```
### Creating Sections

```swift
// Create your Section with all the items you need!
let section = ProviderSection(items: providerItems)

// Need a tableview header or footer view on your section? We have it!
let section = ProviderSection(items: ProviderItem.itemsCollectionWithData(items, cellReuseIdentifier: kCellRID), headerViewConfig: headerConfig, footerViewConfig: footerConfig)

//Create your section header or footer configuration:
let config = ProviderSectionViewConfiguration(view: view)

//You can also send any you need height in the configuration!
let config = ProviderSectionViewConfiguration(view: view, viewHeight: height)
```
### Provider Configuration

we use this configuration to register and link the cells to the Table/Collection view. And this configuration model for is the same for both!
```swift
let providerConfig = ProviderConfiguration(reuseIdentifier: "Your Cell Reuse ID", cellClass: YourClass)
//Using interface builder? We didnt forget you:
let providerConfig = ProviderConfiguration(reuseIdentifier: "Your Cell Reuse ID", cellNibName: "Your Nib Name", nibBundle: NibBundleOrNil)
```
### Provider
All you need to do is create it and hold the reference. It'll do the rest for you!
```swift
//TableView
let provider = TableViewProvider(withTableView: yourTableView, sections: yourSections, delegate: tableViewProviderDelegate, cellConfiguration: yourConfigurations)
//CollectionView
let provider = CollectionViewProvider(withCollectionView: yourCollectionView, sections: yourSections, delegate: yourCollectionViewProviderDelegate, cellConfiguration: yourConfigurations)
```
Now that it's created, you can play with your data:
```swift
//Retrieve an item:
let item : ProviderItem = provider.providerItemAtIndexPath(indexPath)
let myData = item.data as! ...
//Insert other items:
provider.addItemsToProvider(yourItems, inSection: sectionIndex)
provider.addItemsToProvider(yourItems, inSection: sectionIndex, rowAnimation: UITableViewRowAnimation.Automatic) // You can also send a row animation in case of TableViewProvider
//Remove
provider.removeItems(indexPathes)
//Update
provider.updateProviderData(newSections)
```
We have other methods to assist you, it's all documented, check it out! 
If you need something specific you can always subclass it and do your custom implementation.

There is also an example project. To run it, simply use `pod try DataProvider` and run the example project

## Classes & Structs
```swift
ProviderItem //Struct related to a row/cell.
ProviderSection //Struct related to a section in a Table/Collection View.
ProviderConfiguration //Use this Struct to send your cells configuration to the provider.
ProviderSectionViewConfiguration //Use this struct to send header of footer views configuration for your Section.
```
### UICollectionView
```swift
CollectionViewProvider //Class with assist methods to insert, remove and edit data in a collection view. Also holds a reference for delegate and datasource.
CollectionViewProviderDelegateHandler //Class responsible for UICollectionViewDelegate code. Subclass it if you need to implement other delegate methods.
CollectionViewProviderDataSourceHandler //Class responsible for UICollectionViewDataSource code. Subclass it if you need to implement other data source methods.
```
### UITableView
```swift
TableViewProvider //Class with assist methods to insert, remove and edit data in a collection view. Also holds a reference for delegate and datasource.
TableViewProviderDelegateHandler //Class responsible for UITableViewDelegate code. Subclass it if you need to implement other delegate methods.
TableViewProviderDataSourceHandler //Class responsible for UITableViewDataSource code. Subclass it if you need to implement other data source methods.

```
## Protocols
```swift
ProviderDataComparable //Protocol to be implemented by the data of a provider item. Necessary to compare and differenciate an item's content from another.

ProviderCellProtocol //Protocol to be implemented by your cell class. Consider using an extension if you're using the default UICollection/UITable ViewCell.

TableViewProviderDelegate //TableViewProvider Protocol. Used to comunicate between the provider and your application. Subclass it if additional methods are needed.

CollectionViewProviderDelegate //CollectionViewProvider Protocol. Used to comunicate between the provider and your application. Subclass it if additional methods are needed.

```

## Credits
### Author
* [Guilherme Lisboa](https://github.com/Guilherme92Dev)

### Collaborators

* [Gabriel Cartier](https://github.com/GabrielCartier) ([@GabrielCartier](https://twitter.com/GabrielCartier))
* [Marcelo de Souza](https://github.com/marcelogfsouza)
* [Nicolas Vincensini](https://github.com/N1c0L4z3R)
* [Shanhe Nie](https://github.com/ccmjz)


### Thanks

* [Samsao Development Inc.](http://www.samsaodev.com/) ([@samsaodev](https://twitter.com/SamsaoDev))
* [Lukasz Piliszczuk](https://github.com/lukaspili) ([@lukaspili](https://twitter.com/lukaspili))


## License

DataProvider is available under the MIT license. See the LICENSE file for more info.
