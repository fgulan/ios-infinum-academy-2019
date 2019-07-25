//
//  CollectionDataSourceDelegate.swift
//
//

import UIKit
import RxSwift

class EmptyCollectionSection: CollectionSectionItem {
    
    var collectionItems: [CollectionCellItem]
    
    init(collectionItems: [CollectionCellItem]) {
        self.collectionItems = collectionItems
    }
    
    convenience init?(collectionItems: [CollectionCellItem]?) {
        if let item = collectionItems {
            self.init(collectionItems: item)
            return
        }
        return nil
    }
}

class CollectionDataSourceDelegate: NSObject {
    
    private let collectionView: UICollectionView
    private let reloader: CollectionViewReloader
    
    private let disposeBag = DisposeBag()
    
    var sections: [CollectionSectionItem]? {
        didSet { reloader.reload(collectionView, oldSections: oldValue, newSections: sections) }
    }
    
    var items: [CollectionCellItem]? {
        get { return sections?.map({ $0.collectionItems }).reduce([CollectionCellItem](), +) }
        set {
            guard let tableItems = newValue else { return }
            sections = [EmptyCollectionSection(collectionItems: tableItems) as CollectionSectionItem]
        }
    }
    
    init(collectionView: UICollectionView, reloader: CollectionViewReloader = DefaultCollectionViewReloader()) {
        self.collectionView = collectionView
        self.reloader = reloader
        super.init()
        collectionView.dataSource = self
        collectionView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
    
}

extension CollectionDataSourceDelegate: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections?[section].collectionItems.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return sections![indexPath].cell(from: collectionView, at: indexPath)
    }
    
}

extension CollectionDataSourceDelegate: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        sections![indexPath].didSelect(at: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        sections![indexPath].willDisplay(cell: cell, at: indexPath)
    }

}

extension CollectionDataSourceDelegate: UIScrollViewDelegate {
        
}
