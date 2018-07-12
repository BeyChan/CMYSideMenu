//
//  CMYRightTableViewController.swift
//  CMYSideMenuDemo
//
//  Created by 程明勇 on 2018/7/12.
//  Copyright © 2018年 程明勇. All rights reserved.
//

import UIKit
let kCMYRightMenuTableViewCell = "CMYRightMenuTableViewCell"

class CMYRightTableViewController: UITableViewController {
    private var gradientLayer = CAGradientLayer()
    let titleArray = ["右边一","右边二"];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: kCMYRightMenuTableViewCell)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if gradientLayer.superlayer != nil {
            gradientLayer.removeFromSuperlayer()
        }
        let topColor = UIColor(red: 16.0/255.0, green: 12.0/255.0, blue: 54.0/255.0, alpha: 1.0)
        let bottomColor = UIColor(red: 127.0/255.0, green: 123.0/255.0, blue: 41.0/255.0, alpha: 1.0)
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: kCMYRightMenuTableViewCell)  else {
            preconditionFailure("Unregistered table view cell")
        }
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text = titleArray[indexPath.row]
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
        let controller = CMYPresentViewController.init()
        controller.title = titleArray[indexPath.row]
        DispatchQueue.main.async {
            self.cmy_sidePresentViewController(viewController: controller)
        }
    }
}
