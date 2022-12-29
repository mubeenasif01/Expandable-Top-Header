//
//  ViewController.swift
//  Top Header Expandable
//
//  Created by Mubeen on 29/12/2022.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerHeight: NSLayoutConstraint!
    
    
    let maxHeaderHeight: CGFloat = 162.5
    let minHeaderHeight: CGFloat = 70
    var previousScrollOffset: CGFloat = 0
    
    
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register Nib
        let cell = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: "TableViewCell")
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollDiff = scrollView.contentOffset.y -  previousScrollOffset
        let isScrollingDown = scrollDiff > 0
        let isScrollingUp = scrollDiff < 0
        if canAnimateHeader(scrollView) {
            var newHeight = headerHeight.constant
            if isScrollingDown {
                newHeight = max(minHeaderHeight, headerHeight.constant - abs(scrollDiff))
            } else if isScrollingUp {
                newHeight = min(maxHeaderHeight, headerHeight.constant + abs(scrollDiff))
            }
            if newHeight != headerHeight.constant {
                headerHeight.constant = newHeight
                setScrollPosition()
                previousScrollOffset = scrollView.contentOffset.y
            }
        }
    }
    
    func canAnimateHeader (_ scrollView: UIScrollView) -> Bool {
        let scrollViewMaxHeight = scrollView.frame.height + (self.headerHeight.constant - minHeaderHeight)
        return scrollView.contentSize.height > scrollViewMaxHeight
    }
    
    func setScrollPosition() {
        self.tableView.contentOffset = CGPoint(x:0, y: 0)
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    // Mark: - Table View delegate methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.titleLabel.text = "Mubeen"
        return cell
    }
    
}
