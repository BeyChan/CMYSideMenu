//
//  ViewController.swift
//  CMYSideMenuDemo
//
//  Created by 程明勇 on 2018/7/12.
//  Copyright © 2018年 程明勇. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate var titleArray = ["左出平移","左出遮盖","左出缩放","右出平移","右出遮盖","右出缩放"];
    
    fileprivate let sb = UIStoryboard.init(name: "Main", bundle: Bundle.main)
    
    fileprivate lazy var leftVC: UIViewController = {
        let vc =  sb.instantiateViewController(withIdentifier: "CMYLeftTableViewController") as! CMYLeftTableViewController
        return vc
    }()
    
    fileprivate lazy var rightVC: UIViewController = {
        let vc =  sb.instantiateViewController(withIdentifier: "CMYRightTableViewController") as! CMYRightTableViewController
        return vc
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configSubviews()
    }

    @IBAction func showLeft(_ sender: Any) {
      
        self.cmy_showSideMenu(viewController: self.leftVC)
    }
    
    @IBAction func showRight(_ sender: Any) {

        self.cmy_showSideMenu(configuration: { (config) in
            config.direction = .right
        }, viewController: self.rightVC)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension ViewController {
    fileprivate func configSubviews() {
        self.title = "侧栏展示Demo"
        self.view.backgroundColor = UIColor.white
        let imgView = UIImageView.init(frame: self.view.bounds)
        imgView.image = UIImage.init(named: "Stars")
        self.view.addSubview(imgView)
        
        let tableView:UITableView = UITableView.init(frame: self.view.bounds, style:UITableViewStyle(rawValue: 0)!)
        tableView.backgroundView = imgView;
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView.init()
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "id")
        if #available(iOS 11.0, *) {
            //            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        }
        self.view.addSubview(tableView)
        
        leftVC = sb.instantiateViewController(withIdentifier: "CMYLeftTableViewController") as! CMYLeftTableViewController
        rightVC = sb.instantiateViewController(withIdentifier: "CMYRightTableViewController") as! CMYRightTableViewController
        
        self.cmy_registGestureShowSide { (direction) in
            if direction == .left {
                self.cmy_showSideMenu(configuration: { (config) in
                    config.animationType = .translationPush
                }, viewController: self.leftVC)
            }else {
                self.cmy_showSideMenu(configuration: { (config) in
                    config.direction = .right
                }, viewController: self.rightVC)
            }
        }
    }
}
extension ViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "id")!
        cell.textLabel?.text = titleArray[indexPath.row]
        cell.accessoryType = .disclosureIndicator;
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 { //左出平移

            cmy_showSideMenu(configuration: { (config) in
                
            }, viewController: self.leftVC)
        }else if indexPath.row == 1 { //左出遮罩
            let sb = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "CMYLeftTableViewController") as! CMYLeftTableViewController

            cmy_showSideMenu(configuration: { (config) in
                config.animationType = .translationMask
                config.sideRelative = 0.6
                //                config.timeInterval = 3;
            }, viewController: vc)
        }else if indexPath.row == 2 { //左出缩放

            cmy_showSideMenu(configuration: { (config) in
                config.animationType = .zoom // 侧边来出来的动画方式
                config.timeInterval = 0.3 // 执行动画的时长 默认0.3
                config.direction = .left // 侧边来出来的的方向 默认从左边出来
                config.maskAlpha = 0.5 // 遮罩视图的透明度 默认0.5
                config.sideRelative = 0.7 // 侧边栏相对屏幕宽度比例 默认0.7
                config.zoomOffsetRelative = 0.5 // 缩放模式时 缩放控制器的view偏移相对屏幕宽度比例 默认0.5
                config.zoomRelative = 0.7 // 缩放模式时缩放的比例 默认0.7
            }, viewController: self.leftVC)
        }else if indexPath.row == 3 { //右出平移
      
            cmy_showSideMenu(configuration: { (config) in
                config.direction = .right
            }, viewController: self.rightVC)
        }else if indexPath.row == 4 { //右出遮罩
          
            cmy_showSideMenu(configuration: { (config) in
                config.direction = .right
                config.sideRelative = 0.5
                config.animationType = .translationMask
            }, viewController: self.rightVC)
        }else if indexPath.row == 5 { //右出缩放
  
            cmy_showSideMenu(configuration: { (config) in
                config.direction = .right
                config.animationType = .zoom
            }, viewController: self.rightVC)
        }
    }
}

