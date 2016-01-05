//
//  GuideViewController.swift
//  引导页
//
//  Created by apple on 16/1/4.
//  Copyright © 2016年 apple. All rights reserved.
//
/*
    必须确保工程中有相对应的图片，命名规则如下。若有4页，则所有对应图片名称为
    iphone4： 480_0.png、480_1.png、480_2.png、480_3.png
    iphone5： 568_0.png、568_1.png、568_2.png、568_3.png
    iphone6： 667_0.png、667_1.png、667_2.png、667_3.png
   iphone6p： 736_0.png、736_1.png、736_2.png、736_3.png

    支持png和jpg两种图片格式
*/

import UIKit

typealias exitBtnClicked = ()->()

class GuideViewController: UIViewController {

    /// 引导页一共有多少页,默认是4
    var pages: Int = 4
    
    /// 翻页控制器的中点Y坐标，默认离屏幕底端50
    var pageCtlY: CGFloat = UIScreen.mainScreen().bounds.size.height - 50
    
    /// 退出按钮被点击回调
    var exitBtnClickedCallBack: exitBtnClicked?
    
    /// 返回序列号atIndex处的视图，供外界调用在上面添加自定义内容
    func getTargetView(atIndex: Int) -> UIImageView?{

        if atIndex > scrollView!.subviews.count - 1{
            return nil
        }
        let view = scrollView!.subviews[atIndex] as! UIImageView
        view.userInteractionEnabled = true   // 因为是UIImageView类型
        return view
    }
    
        
    override func viewDidLoad() {
        super.viewDidLoad()

        setupScrollView()
        
        addExitButton()
    }

    
    // MARK: - 私有方法 -----
    
    /// 添加右上角提前退出按钮
    private func addExitButton(){
        let exitBtn = UIButton(type: UIButtonType.ContactAdd)
        exitBtn.frame.origin = CGPointMake(scrollView!.bounds.size.width - exitBtn.bounds.size.width - 20, 20)
        exitBtn.addTarget(self, action: "exitButtonClicked:", forControlEvents: .TouchUpInside)
        self.view.addSubview(exitBtn)
    }
    
    /// 退出按钮被点击,注意，这个方法不能声明为private，因为点击按钮的时候外部需要调用
    func exitButtonClicked(btn: UIButton){
        if exitBtnClickedCallBack != nil{
            exitBtnClickedCallBack!()
        }
    }
    
    private var scrollView: UIScrollView?
    
    /// 创建scrollView
    private func setupScrollView(){
        scrollView = UIScrollView(frame: self.view.bounds)
        scrollView?.contentSize = CGSizeMake(self.view.bounds.width * CGFloat(pages), 0)
        scrollView?.pagingEnabled = true
        scrollView?.showsHorizontalScrollIndicator = false
        scrollView?.showsVerticalScrollIndicator = false
        scrollView?.bounces = false
        scrollView?.delegate = self
        self.view.addSubview(scrollView!)
        scrollView?.backgroundColor = UIColor.grayColor()
        
        setupScrollViewContents()
        setupPageController()
    }
    
    /// 填充scrollView内容
    private func setupScrollViewContents(){
        for i in 0..<pages{
            let imageView = UIImageView(frame: scrollView!.bounds)
            imageView.frame.origin.x = CGFloat(i) * scrollView!.frame.size.width
            imageView.image = getImage(i)
            scrollView?.addSubview(imageView)
        }
    }
    
    /// 获得索引处需要显示的图片
    private func getImage(index: Int) -> UIImage?{
        let height = Int(UIScreen.mainScreen().bounds.height)
        var image = UIImage(named: "\(height)_\(index)")
        if image == nil{
            image = UIImage(named: "\(height)_\(index).jpg")
        }
        return image
    }
    
    /// 生成翻页控制器
    private var pageController: UIPageControl?
    private func setupPageController(){
        let pageCtl = UIPageControl()
        pageCtl.numberOfPages = pages
        pageCtl.center = CGPointMake(self.view.center.x, pageCtlY)
        pageCtl.pageIndicatorTintColor = UIColor.grayColor()
        pageCtl.currentPageIndicatorTintColor = UIColor.redColor()
        self.view.addSubview(pageCtl)
        pageController = pageCtl
    }
}

extension GuideViewController: UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        pageController?.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
}
