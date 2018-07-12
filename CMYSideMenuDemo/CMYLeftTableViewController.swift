//
//  CMYLeftTableViewController.swift
//  CMYSideMenuDemo
//
//  Created by 程明勇 on 2018/7/12.
//  Copyright © 2018年 程明勇. All rights reserved.
//

import UIKit
let kCMYMenuTableViewCell = "CMYMenuTableViewCell"

class CMYLeftTableViewController: UITableViewController {
    
    private var gradientLayer = CAGradientLayer()
    
    var titleArray = ["左边push一","左边push二","左边Present三"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: UITableViewScrollPosition.none)
//        tableView.register(CMYMenuTableViewCell.classForCoder(), forCellReuseIdentifier: kCMYMenuTableViewCell)
//        tableView.register(CMYMenuTableViewCell.classForCoder(), forCellReuseIdentifier: kCMYMenuTableViewCell)
        tableView.reloadData()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if gradientLayer.superlayer != nil {
            gradientLayer.removeFromSuperlayer()
        }
        let topColor = UIColor(red: 16.0/255.0, green: 12.0/255.0, blue: 54.0/255.0, alpha: 1.0)
        let bottomColor = UIColor(red: 57.0/255.0, green: 33.0/255.0, blue: 61.0/255.0, alpha: 1.0)
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: kCMYMenuTableViewCell) as? CMYMenuTableViewCell else {
            preconditionFailure("Unregistered table view cell")
        }

        cell.titleLabel?.text = titleArray[indexPath.row]
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = UIColor.clear
        return v
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = UIViewController.init()
        controller.title = titleArray[indexPath.row]
        controller.view.backgroundColor = UIColor.randomColor()
        self.cmy_sidePushViewController(viewController: controller)
    }
}
