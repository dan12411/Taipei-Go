//
//  DetailImagePageViewController.swift
//  Taipei Go
//
//  Created by 洪德晟 on 16/02/2018.
//  Copyright © 2018 Dan. All rights reserved.
//

import UIKit

class DetailImagePageViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var imageViews: [UIImageView] = []
    var pageCount: Int {
        return imageViews.count
    }
    var pageDic = [Int:UIImageView]()
    var pageControl: UIPageControl!
    
    @objc private func pageChanged(_ sender: UIPageControl) {
        let page = sender.currentPage
        print(sender.currentPage)
        self.loadScrollViewWithPage(page: page - 1)
        self.loadScrollViewWithPage(page: page)
        self.loadScrollViewWithPage(page: page + 1)
        
        self.removeScrollViewWithPage(page: page - 2)
        self.removeScrollViewWithPage(page: page + 2)
        
        var frame = scrollView.frame
        frame.origin.x = frame.size.width * CGFloat(page)
        frame.origin.y = 0
        
        scrollView.scrollRectToVisible(frame, animated: true)
    }
    
    private func setUpPageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0, y: 250, width: self.view.frame.width, height: 50))
        pageControl.numberOfPages = pageCount
        self.view.addSubview(pageControl)
        pageControl.addTarget(self, action: #selector(pageChanged(_:)), for: .valueChanged)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollView.contentSize = CGSize(width: UIScreen.main.bounds.size.width * CGFloat(self.pageCount), height: 300)
        self.scrollView.isPagingEnabled = true
        
        self.loadScrollViewWithPage(page:0)
        self.loadScrollViewWithPage(page:1)
        
        setUpPageControl()
    }
    
}

extension DetailImagePageViewController: UIScrollViewDelegate {
    
    func loadScrollViewWithPage(page:Int) {
        if page < 0 || page >= self.pageCount {
            return
        } else if self.pageDic[page] == nil {
            
            let imageView = UIImageView(frame: CGRect(
                x: UIScreen.main.bounds.size.width * CGFloat(page),
                y: 0,
                width: UIScreen.main.bounds.size.width,
                height: 300
                ))
            
            imageView.contentMode = .scaleToFill
            imageView.image = self.imageViews[page].image
            self.scrollView.addSubview(imageView)
            self.pageDic[page] = imageView
        }
    }
    
    func removeScrollViewWithPage(page:Int) {
        if page < 0 || page >= self.pageCount {
            return
        } else if pageDic[page] != nil {
            self.pageDic[page]?.removeFromSuperview()
            self.pageDic[page] = nil
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x - pageWidth / 2) /
            pageWidth)) + 1
        pageControl.currentPage = page
        
        self.loadScrollViewWithPage(page: page - 1)
        self.loadScrollViewWithPage(page: page)
        self.loadScrollViewWithPage(page: page + 1)
        
        self.removeScrollViewWithPage(page: page - 2)
        self.removeScrollViewWithPage(page: page + 2)
    }
    
}
