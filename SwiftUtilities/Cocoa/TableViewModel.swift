//
//  TableViewModel.swift
//  SwiftUtilities
//
//  Created by Rodrigo Ruiz on 8/2/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

public class TableViewModel<Item: Equatable>: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    public var items: [[Item]]? {
        didSet {
            if oldValue == items {
                return
            }
            
            if let oldItems = oldValue, let newItems = items {
                update(oldItems: oldItems, newItems: newItems)
            }
        }
    }
    
    public var cellForRow: ((Item, IndexPath) -> UITableViewCell)? {
        didSet {
            let indexPath = tableView?.indexPathForSelectedRow
            tableView?.reloadData()
            tableView?.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        }
    }
    
    public var didSelectRow: ((Item?) -> Void)?
    
    public func setTableView(_ tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView = tableView
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let item = items?[indexPath.section][indexPath.row],
            let cellForRow = cellForRow
        else {
            return UITableViewCell()
        }
        
        return cellForRow(item, indexPath)
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        if cellForRow == nil {
            return 0
        }
        
        return items?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cellForRow == nil {
            return 0
        }
        
        return items?[section].count ?? 0
    }
    
    // MARK: - UITableViewDelegate
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = items?[indexPath.section][indexPath.row] else { return }
        
        didSelectRow?(item)
    }
    
    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        didSelectRow?(nil)
    }
    
    // MARK: - Private
    
    private weak var tableView: UITableView?
    
    private func update<Item: Equatable>(oldItems: [[Item]], newItems: [[Item]]) {
        guard let indexPath = tableView?.indexPathForSelectedRow else {
            tableView?.reloadData()
            return
        }
        
        let selectedItem = oldItems[indexPath.section][indexPath.row]
        
        let newSelectedIndexPath = newItems.find({ (sectionElement, sectionIndex) -> IndexPath? in
            guard let rowIndex = sectionElement.find({ (rowElement, rowIndex) -> Int? in
                if rowElement == selectedItem {
                    return rowIndex
                }
                
                return nil
            }) else {
                return nil
            }
            
            return IndexPath(row: rowIndex, section: sectionIndex)
        })
        
        tableView?.reloadData()
        tableView?.selectRow(at: newSelectedIndexPath, animated: true, scrollPosition: .none)
        
        if newSelectedIndexPath == nil {
            didSelectRow?(nil)
        }
    }
    
}
