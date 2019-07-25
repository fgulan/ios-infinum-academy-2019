//
//  IndexTitleTableDataSourceDelegate.swift
//
//

import UIKit

protocol IndexTitleTableSectionItem {
    var title: String { get }
}

class IndexTitleTableDataSourceDelegate: TableDataSourceDelegate {
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        let sections = self.sections?.compactMap { $0 as? IndexTitleTableSectionItem }
        if sections?.count != self.sections?.count { return nil }
        return sections?.map { $0.title }
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        let sections = self.sections?.map { $0 as? IndexTitleTableSectionItem }
        let index = sections?.firstIndex { title == $0?.title }
        return index ?? 0
    }
    
}
