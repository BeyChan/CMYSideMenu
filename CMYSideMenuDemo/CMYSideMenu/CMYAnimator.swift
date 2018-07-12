//
//  CMYAnimator.swift
//  CMYSideMenu
//
//  Created by 程明勇 on 2018/7/11.
//  Copyright © 2018年 程明勇. All rights reserved.
//

import UIKit

class CMYAnimator: NSObject,UIViewControllerTransitioningDelegate {
    
    var presentationInteractiveTransition: CMYSideMenuInteractiveTransition?
    var dismissalInteractiveTransition: CMYSideMenuInteractiveTransition!
    var config: CMYSideMenuConfig!
    
    init(config:CMYSideMenuConfig?) {
        self.config = config
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CMYInteractiveTransition(showType: .show, config: config)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CMYInteractiveTransition(showType: .hidden, config: config)
    }
    
    // present交互的百分比
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if presentationInteractiveTransition == nil {
            return nil
        }else {
            return (presentationInteractiveTransition?.isInteractive)! ? presentationInteractiveTransition : nil
        }
    }
    
    // dismiss交互的百分比
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return dismissalInteractiveTransition.isInteractive ? dismissalInteractiveTransition : nil
    }
    deinit {
//        print( NSStringFromClass(self.classForCoder) + " 销毁了---->3")
    }
    
}

