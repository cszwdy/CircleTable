//
//  CViewController.swift
//  CircleTable
//
//  Created by Chen on 29/08/2017.
//  Copyright © 2017 HUAYUN. All rights reserved.
//

import UIKit

class CViewController: UIViewController {
    
    var collectionView: UICollectionView!
    let layout = TableFlowLayout()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 568*0.4, width: 320, height: 568*0.6), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Header")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
    }
}

extension CViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        cell.contentView.backgroundColor = UIColor.clear
        
        if cell.viewWithTag(888) == nil {
            let view = UIView(frame: cell.bounds.insetBy(dx: 5, dy: 5))
            view.backgroundColor = UIColor.groupTableViewBackground
            view.tag = 888
            cell.contentView.addSubview(view)
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Header", for: indexPath)
        

        return header
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        
        if collectionView.viewWithTag(660+indexPath.section) == nil {
            let head = UIView(frame: view.frame)
            head.backgroundColor = UIColor.darkGray
            head.tag = 660+indexPath.section
            
            if head.viewWithTag(888) == nil {
                let contentView = UIView(frame: head.bounds.insetBy(dx: 5, dy: 5))
                contentView.backgroundColor = UIColor.groupTableViewBackground
                contentView.tag = 888
                head.addSubview(contentView)
            }
            
            collectionView.addSubview(head)
        }
        
    }
}

extension CViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 44)
    }
}
