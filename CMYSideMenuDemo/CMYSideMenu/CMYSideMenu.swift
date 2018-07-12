//
//  CMYSideMenu.swift
//  CMYSideMenu
//
//  Created by 程明勇 on 2018/7/11.
//  Copyright © 2018年 程明勇. All rights reserved.
//

import UIKit

var showControlelrTransitioningDelegateKey = "showControlelrTransitioningDelegateKey"
let CMYSideMenuTapNotification = "CMYSideMenuTapNotification"
let CMYSideMenuPanNotification = "CMYSideMenuPanNotification"
let kScreenWidth = UIScreen.main.bounds.width

extension UIViewController {
    
    /// 默认侧边栏显示方式
    ///
    /// - Parameter viewController: 侧栏控制器
    public func cmy_showSideMenu(viewController: UIViewController) {
        self.cmy_showSideMenu(configuration: { (config) in
            
        }, viewController: viewController)
    }
    
    /// 侧边栏出来
    ///
    /// - Parameters:
    ///   - configuration: 配置
    ///   - viewController: 将要展现的viewController
    public func cmy_showSideMenu(configuration:(CMYSideMenuConfig)->(), viewController:UIViewController) {
        
        let config = CMYSideMenuConfig()
        configuration(config)
        
        var animator = objc_getAssociatedObject(self, &showControlelrTransitioningDelegateKey)
        if animator == nil {
            animator = CMYAnimator(config:config)
            objc_setAssociatedObject(viewController, &showControlelrTransitioningDelegateKey, animator, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }else {
            let d = animator as! CMYAnimator
            d.config = config
        }
        let d = animator as! CMYAnimator
        let dismissalInteractiveTransition = CMYSideMenuInteractiveTransition(showType: .hidden, viewController:viewController, config: config)
        d.dismissalInteractiveTransition = dismissalInteractiveTransition
        viewController.transitioningDelegate = animator as? UIViewControllerTransitioningDelegate

        DispatchQueue.main.async { //防止present延迟
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    
    /// 让侧边栏支持手势拖拽出来
    ///
    /// - Parameter completeShowGesture: 侧边栏展示的方向
    public func cmy_registGestureShowSide(completeShowGesture:@escaping (CMYSideMenuDirection)->()) {
        let  animator = CMYAnimator(config: nil)
        let presentationInteractiveTransition = CMYSideMenuInteractiveTransition(showType: .show, viewController: nil, config: nil)
        presentationInteractiveTransition.addPanGesture(fromViewController: self)
        presentationInteractiveTransition.completeShowGesture = completeShowGesture
        animator.presentationInteractiveTransition = presentationInteractiveTransition
        
        self.transitioningDelegate = animator
        objc_setAssociatedObject(self, &showControlelrTransitioningDelegateKey, animator, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    public func cmy_sidePushViewController(viewController: UIViewController) {
        let rootVC: UIViewController = (UIApplication.shared.keyWindow?.rootViewController)!
        var nav: UINavigationController?
        if rootVC.isKind(of: UITabBarController.classForCoder()) {
            let tabBar: UITabBarController = rootVC as! UITabBarController
            nav = tabBar.selectedViewController as? UINavigationController
        }else if rootVC.isKind(of: UINavigationController.classForCoder()) {
            nav = rootVC as? UINavigationController
        }else {
            fatalError("没有UINavigationController")
        }
        self.dismiss(animated: true, completion: nil)
        nav?.pushViewController(viewController, animated: false)
    }
    
    
    /// 侧边栏调用present
    ///
    /// - Parameter viewController
    public func cmy_sidePresentViewController(viewController: UIViewController) {
        let rootVC: UIViewController = (UIApplication.shared.keyWindow?.rootViewController)!
        if ((rootVC.presentedViewController) != nil) {
            rootVC.presentedViewController?.dismiss(animated: true, completion: {
                DispatchQueue.main.async {                
                    rootVC.present(viewController, animated: true, completion: nil)
                }
            })
        }
    }
    
    
    /// 隐藏侧边栏
    public func cmy_hideSideController() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
