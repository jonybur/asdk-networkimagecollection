//
//  BSWaterfallViewController.swift
//  Sample
//
//  Created by Jonathan Bursztyn on 1/10/17.
//  Copyright © 2017 Jonathan Bursztyn. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class BSWaterfallViewController: UIViewController, MosaicCollectionViewLayoutDelegate, ASCollectionDataSource, ASCollectionDelegate {

	var _sections = [[Picture]]()
	let _collectionNode: ASCollectionNode!
	let _layoutInspector = MosaicCollectionViewLayoutInspector()
	
    required init?(coder aDecoder: NSCoder) {
        
		let layout = MosaicCollectionViewLayout()
		layout.numberOfColumns = 3;
        layout.headerHeight = 44;
		_collectionNode = ASCollectionNode(frame: CGRect.zero, collectionViewLayout: layout)
		super.init(nibName: nil, bundle: nil);
		layout.delegate = self
		
		_collectionNode.dataSource = self;
		_collectionNode.delegate = self;
		_collectionNode.view.layoutInspector = _layoutInspector
		_collectionNode.backgroundColor = UIColor.white
		_collectionNode.view.isScrollEnabled = true
		_collectionNode.registerSupplementaryNode(ofKind: UICollectionElementKindSectionHeader)
    }
	
	deinit {
		_collectionNode.dataSource = nil;
		_collectionNode.delegate = nil;
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.addSubnode(_collectionNode!)
        
        let pages = ["instagram", "facebook", "google", "natgeo", "microsoft"]
        
        for pagename in pages {
            InstagramClient.getInstagramPage(username: pagename).then(execute: { section -> (Void) in
                self._sections.append(section)
                self._collectionNode.reloadData()
            });
        }
	}
	
	override func viewWillLayoutSubviews() {
		_collectionNode.frame = self.view.bounds;
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
		let picture = _sections[indexPath.section][indexPath.item]
		return BSWaterfallViewCell(with: picture)
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, nodeForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> ASCellNode {
		let textAttributes : NSDictionary = [
			NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline),
			NSForegroundColorAttributeName: UIColor.gray
		]
		let textInsets = UIEdgeInsets(top: 11, left: 0, bottom: 11, right: 0)
		let textCellNode = ASTextCellNode(attributes: textAttributes as! [AnyHashable : Any], insets: textInsets)
        
		textCellNode.text = String(format: _sections[indexPath.section][indexPath.item].username, indexPath.section + 1)
		return textCellNode;
	}
	
	func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
		return _sections.count
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
		return _sections[section].count
	}
	
	internal func collectionView(_ collectionView: UICollectionView, layout: MosaicCollectionViewLayout, originalItemSizeAtIndexPath: IndexPath) -> CGSize {
        return _sections[originalItemSizeAtIndexPath.section][originalItemSizeAtIndexPath.item].ratio
	}
}

