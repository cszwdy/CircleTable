//
//  TableFlowLayout.swift
//  CircleTable
//
//  Created by Chen on 29/08/2017.
//  Copyright © 2017 HUAYUN. All rights reserved.
//

import UIKit

class TableFlowLayout: UICollectionViewFlowLayout {
    
    var headFrames = [CGRect]()
    var heads = [UIView]()
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let attributes = super.layoutAttributesForElements(in: rect)
        
        if let attrs = attributes {
            for a in attrs {
                if a.representedElementCategory == UICollectionElementCategory.supplementaryView {
                    
                    if let head = self.collectionView?.viewWithTag(660+a.indexPath.section), !heads.contains(head) {
                        print(head.frame.minY)
                        headFrames.append(head.frame)
                        heads.append(head)
                    }
                }
                
                if let c = collectionView {
                    let y = c.bounds.height - (a.frame.minY - c.contentOffset.y)
                    let w = min(320-100, abs(320 - sqrt(320*320 - y*y)))
                    if let cell = c.cellForItem(at: a.indexPath) {
                        if let contentView = cell.contentView.viewWithTag(888) {
                            contentView.transform = CGAffineTransform(translationX: w, y: 0)
                        }
                    }
                }
            }
            
            for (i, h) in heads.enumerated() {
                let offsetY = headFrames[0..<i].reduce(0){$0+$1.height}
                let minY = headFrames[i].origin.y
                
                h.frame.origin.y = max(minY, collectionView!.contentOffset.y+offsetY)
                
                if let c = collectionView {
                    let y = c.bounds.height - (h.frame.minY - c.contentOffset.y)
                    let w = min(320-88, abs(320 - sqrt(320*320 - y*y)))
                        if let contentView = h.viewWithTag(888) {
                            contentView.transform = CGAffineTransform(translationX: w, y: 0)
                        }
                }
            }
            
        }
        
        
        
        return attributes
    }
    
    
    
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        let attributes = super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath)
        
        if let collectionView = collectionView {
            attributes?.frame.origin.y = 20
        }
        
        
        return attributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    
}
