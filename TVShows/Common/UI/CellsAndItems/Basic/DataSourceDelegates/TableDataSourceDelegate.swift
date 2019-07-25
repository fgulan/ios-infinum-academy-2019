//
//  TableDataSourceDelegate.swift
//
//

import UIKit
import RxSwift

class EmptyTableSection: TableSectionItem {
    
    var tableItems: [TableCellItem]
    
    init(tableItems: [TableCellItem]) {
        self.tableItems = tableItems
    }
    
    convenience init?(tableItems: [TableCellItem]?) {
        if let item = tableItems {
            self.init(tableItems: item)
            return
        }
        return nil
    }
    
    var headerHeight: CGFloat {
        if #available(iOS 11.0, *) {
            return .leastNonzeroMagnitude
        } else {
            return 1
        }
    }
    
    var estimatedHeaderHeight: CGFloat {
        return headerHeight
    }
    
    var footerHeight: CGFloat {
        if #available(iOS 11.0, *) {
            return .leastNonzeroMagnitude
        } else {
            return 1
        }
    }
    
    var estimatedFooterHeight: CGFloat {
        return footerHeight
    }
}

class TableDataSourceDelegate: NSObject {
    
    private let tableView: UITableView
    private let reloader: TableViewReloader
    private let disposeBag = DisposeBag()
    
    var sections: [TableSectionItem]? {
        didSet(oldValue) { reloader.reload(tableView, oldSections: oldValue, newSections: sections) }
    }
    
    var items: [TableCellItem]? {
        get { return sections?.map({ $0.tableItems }).reduce([TableCellItem](), +) }
        set {
            guard let tableItems = newValue else { return }
            sections = [EmptyTableSection(tableItems: tableItems) as TableSectionItem]
        }
    }
    
    init(tableView: UITableView, reloader: TableViewReloader = DefaultTableViewReloader()) {
        self.tableView = tableView
        self.reloader = reloader
        super.init()
        tableView.dataSource = self
        tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }

}

extension TableDataSourceDelegate: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections?[section].tableItems.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return sections![indexPath].cell(from: tableView, at: indexPath)
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return sections![section].titleForHeader(from: tableView, at: section)
//    }
//
//    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
//        return sections![section].titleForFooter(from: tableView, at: section)
//    }
    
}

extension TableDataSourceDelegate: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return sections![section].estimatedHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sections![section].headerHeight
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return sections![section].estimatedFooterHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return sections![section].footerHeight
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return sections![indexPath].estimatedHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sections![indexPath].height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sections?[section].headerView(from:tableView, at:section)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return sections?[section].footerView(from:tableView, at:section)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        return sections![indexPath].didSelect(at: indexPath)
    }
    
}
