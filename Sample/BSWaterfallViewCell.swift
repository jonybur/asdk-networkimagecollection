//
//  BSWaterfallViewCell.swift
//  Sample
//
//  Created by Jonathan Bursztyn on 1/10/17.
//  Copyright © 2017 Jonathan Bursztyn. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Foundation

class BSWaterfallViewCell: ASCellNode {
	
    let _imageNode : ASNetworkImageNode = ASNetworkImageNode()
    var _picture : Picture!
	
	required init(with picture : Picture) {
		super.init()
		
		_imageNode.setURL(URL(string: picture.url), resetToDefault: false)
		_imageNode.shouldRenderProgressImages = true
		
		_picture = picture
		
		self.addSubnode(self._imageNode)
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		let imagePlace = ASRatioLayoutSpec(ratio: self._picture.ratio.height, child: _imageNode)
		
		let stackLayout = ASStackLayoutSpec.vertical()
		stackLayout.justifyContent = .start
		stackLayout.alignItems = .start
		stackLayout.style.flexShrink = 1.0
		stackLayout.children = [imagePlace]
		
		return ASInsetLayoutSpec(insets: UIEdgeInsets.zero, child: stackLayout)
	}
}
