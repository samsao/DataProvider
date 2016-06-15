//
//  TableViewProviderDelegateHandler.swift
//  Pods
//
//  Created by Guilherme Silva Lisboa on 2016-03-22.
//
//

import UIKit

public class TableViewProviderDelegateHandler: NSObject, UITableViewDelegate {

	// MARK: Properties

	public weak var provider: TableViewProvider!

	// MARK: - UITableViewDelegate

	public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		self.provider.delegate?.provider(self.provider, didSelectCellAtIndexPath: indexPath)
	}

	public func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
		self.provider.delegate?.provider(self.provider, didDeselectCellAtIndexPath: indexPath)
	}

	// MARK: Header

	public func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		return self.provider.sections[section].headerViewConfiguration?.view
	}

	public func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return self.provider.sections[section].headerViewConfiguration?.height ?? 0
	}

	// MARK: Footer

	public func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		return self.provider.sections[section].footerViewConfiguration?.view
	}

	public func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return self.provider.sections[section].footerViewConfiguration?.height ?? 0
	}
}
