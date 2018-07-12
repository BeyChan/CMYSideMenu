//
//  CMYPresentViewController.swift
//  CMYSideMenuDemo
//
//  Created by 程明勇 on 2018/7/12.
//  Copyright © 2018年 程明勇. All rights reserved.
//

import UIKit

class CMYPresentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let imgView = UIImageView.init(frame: self.view.bounds)
        imgView.image = UIImage.init(named: "Stars")
        self.view.addSubview(imgView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
