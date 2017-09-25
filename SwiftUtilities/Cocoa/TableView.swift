//
//  TableView.swift
//  SwiftUtilities
//
//  Created by Rodrigo Ruiz on 8/2/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

public class TableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    public func setup<Item: Equatable>(
        items: [[Item]],
        cellForRow: @escaping (Item, IndexPath) -> UITableViewCell,
        didSelectRow: ((Item?) -> Void)? = nil
        ) {
        cellForRowAt = { cellForRow(items[$0.section][$0.row], $0) }
        
        tNumberOfSections = items.count
        numberOfRowsInSection = { items[$0].count }
        
        didSelectRowAt = map({ items[$0.section][$0.row] }) >>> didSelectRow
        
        dataSource = self
        delegate = self
        
        update(items: items)
    }
    
    // MARK: - UITableViewDataSource
    
    private var cellForRowAt: ((IndexPath) -> UITableViewCell) = { _ in UITableViewCell() }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellForRowAt(indexPath)
    }
    
    private var tNumberOfSections = 0
    public func numberOfSections(in tableView: UITableView) -> Int {
        return tNumberOfSections
    }
    
    private var numberOfRowsInSection: (Int) -> Int = { _ in 0 }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowsInSection(section)
    }
    
    // MARK: - UITableViewDelegate
    
    private var didSelectRowAt: ((IndexPath?) -> Void)?
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRowAt?(indexPath)
    }
    
    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        didSelectRowAt?(nil)
    }
    
    // MARK: - Private
    
    private var items: [[Any]] = []
    
    private func update<Item: Equatable>(items: [[Item]]) {
        guard
            let indexPath = indexPathForSelectedRow,
            let selectedItem = self.items[indexPath.section][indexPath.row] as? Item
            else {
                self.items = items
                reloadData()
                return
        }
        
        let newSelectedIndexPath = items.find({ (sectionElement, sectionIndex) -> IndexPath? in
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
        
        self.items = items
        reloadData()
        
        selectRow(at: newSelectedIndexPath, animated: true, scrollPosition: .none)
        
        if newSelectedIndexPath == nil {
            didSelectRowAt?(nil)
        }
    }
    
}
