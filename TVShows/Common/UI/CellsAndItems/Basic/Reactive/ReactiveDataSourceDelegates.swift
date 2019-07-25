//
//  ReactiveDataSourceDelegates.swift
//
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: TableDataSourceDelegate {
    
    var items: Binder<[TableCellItem]?> {
        return Binder(self.base) { dataSourceDelegate, items in
            dataSourceDelegate.items = items
        }
    }
    
    var sections: Binder<[TableSectionItem]?> {
        return Binder(self.base) { dataSourceDelegate, sections in
            dataSourceDelegate.sections = sections
        }
    }
}

extension Reactive where Base: CollectionDataSourceDelegate {
    
    var items: Binder<[CollectionCellItem]?> {
        return Binder(self.base) { dataSourceDelegate, items in
            dataSourceDelegate.items = items
        }
    }
    
    var sections: Binder<[CollectionSectionItem]?> {
        return Binder(self.base) { dataSourceDelegate, sections in
            dataSourceDelegate.sections = sections
        }
    }
}
