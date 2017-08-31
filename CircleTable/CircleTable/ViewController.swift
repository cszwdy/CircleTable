//
//  ViewController.swift
//  CircleTable
//
//  Created by Chen on 29/08/2017.
//  Copyright © 2017 HUAYUN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "Header")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header")
        
        if header?.viewWithTag(777) == nil {
            let v = UIView(frame: CGRect(x: 10, y: 10, width: 300, height: 68))
            v.tag = 777
            v.backgroundColor = UIColor.darkGray
            header?.addSubview(v)
        }
        
        if section % 2 == 0 {
            header?.contentView.backgroundColor = UIColor.red
        } else {
            header?.contentView.backgroundColor = UIColor.blue
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let v = cell.contentView.viewWithTag(666) {
            let y = tableView.bounds.height - (cell.frame.minY - tableView.contentOffset.y)  //
            let w = min(310, abs(320 - sqrt(320*320 - y*y)))
            //            let progress = (tableView.bounds.height - (cell.frame.minY - tableView.contentOffset.y)) / tableView.bounds.height
            v.transform = CGAffineTransform(translationX: w, y: 0)
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let v = view.viewWithTag(777) {
            let y =  tableView.bounds.height - (view.frame.minY - tableView.contentOffset.y)
            let w = min(310, abs(320 - sqrt(320*320 - y*y)))
            //            let progress = (tableView.bounds.height - (cell.frame.minY - tableView.contentOffset.y)) / tableView.bounds.height
            v.transform = CGAffineTransform(translationX: w, y: 0)
            
            
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let tableView = scrollView as? UITableView {
            for cell in tableView.visibleCells {
                if let v = cell.contentView.viewWithTag(666) {
                    let y =  tableView.bounds.height - (cell.frame.minY - tableView.contentOffset.y)
                    let w = min(310, abs(320 - sqrt(320*320 - y*y)))
//                    let progress = (scrollView.bounds.height - (cell.frame.minY - scrollView.contentOffset.y)) / scrollView.bounds.height
                   v.transform = CGAffineTransform(translationX: w, y: 0)
                }
            }
            
            if let rows = tableView.indexPathsForVisibleRows {
                let rows = Set(rows.flatMap{$0.section})
                let sections = Array(rows)
                for section in sections {
                    if let header = tableView.headerView(forSection: section) {
                        if let v = header.viewWithTag(777) {
                            let y = tableView.bounds.height - (header.frame.minY - scrollView.contentOffset.y)
                            let w = min(310, abs(320 - sqrt(320*320 - y*y)))
                            //            let progress = (tableView.bounds.height - (cell.frame.minY - tableView.contentOffset.y)) / tableView.bounds.height
                            v.transform = CGAffineTransform(translationX: w, y: 0)
                        }
                    }
                }
            }
        }
    }
}

