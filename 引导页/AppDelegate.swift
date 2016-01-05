//
//  AppDelegate.swift
//  引导页
//
//  Created by apple on 16/1/4.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        let guide = GuideViewController()

        window?.rootViewController = guide
        window?.makeKeyAndVisible()
        
        // 一定要在窗口调用完成makeKeyAndVisible方法后，根控制器才会创建，才能获取到内容
        setupGuideController(guide)
        
        return true
    }

    private func setupGuideController(guide: GuideViewController){
        
        guide.pages = 4
        
        guide.exitBtnClickedCallBack = {()->() in
            print("点击了退出按钮,一般在这里切换根控制器")
            self.window?.rootViewController = ViewController()
        }
        
        if let imageView = guide.getTargetView(2){
            
            let view = UIView(frame: CGRectMake(200, 200, 100, 100))
            view.backgroundColor = UIColor.orangeColor()
            imageView.addSubview(view)
        }

    }
}

