//
//  SectionItem.swift
//
//

import UIKit

protocol SectionItem {

}

protocol TableSectionItem: SectionItem {
    
    //Requred
    var tableItems: [TableCellItem] { get }
    
    //Optional
    var headerHeight: CGFloat { get }
    var estimatedHeaderHeight: CGFloat { get }
    var footerHeight: CGFloat { get }
    var estimatedFooterHeight: CGFloat { get }
    
    func headerView(from tableView: UITableView, at index: Int) -> UIView?
    func titleForHeader(from tableView: UITableView, at index: Int) -> String?
    
    func footerView(from tableView: UITableView, at index: Int) -> UIView?
    func titleForFooter(from tableView: UITableView, at index: Int) -> String?
    
}

protocol CollectionSectionItem: SectionItem {
    
    //Requred
    var collectionItems: [CollectionCellItem] { get }
    
    //Optional
    
}

extension TableSectionItem {
    
    var headerHeight: CGFloat {
        return UITableView.automaticDimension
    }
    
    var estimatedHeaderHeight: CGFloat {
        return 0
    }
    
    var footerHeight: CGFloat {
        return UITableView.automaticDimension
    }
    
    var estimatedFooterHeight: CGFloat {
        return 0
    }
    
    func headerView(from tableView: UITableView, at index: Int) -> UIView? {
        return nil
    }
    
    func titleForHeader(from tableView: UITableView, at index: Int) -> String? {
        return nil
    }
    
    func footerView(from tableView: UITableView, at index: Int) -> UIView? {
        return nil
    }
    
    func titleForFooter(from tableView: UITableView, at index: Int) -> String? {
        return nil
    }
    
}

extension Array where Element: TableSectionItem {
    subscript(indexPath: IndexPath) -> TableCellItem {
        return self[indexPath.section].tableItems[indexPath.row]
    }
}

extension Array where Element == TableSectionItem {
    subscript(indexPath: IndexPath) -> TableCellItem {
        return self[indexPath.section].tableItems[indexPath.row]
    }
}

extension Array where Element: CollectionSectionItem {
    subscript(indexPath: IndexPath) -> CollectionCellItem {
        return self[indexPath.section].collectionItems[indexPath.row]
    }
}

extension Array where Element == CollectionSectionItem {
    subscript(indexPath: IndexPath) -> CollectionCellItem {
        return self[indexPath.section].collectionItems[indexPath.row]
    }
}
