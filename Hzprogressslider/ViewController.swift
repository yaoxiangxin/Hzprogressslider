//
//  ViewController.swift
//  Hzprogressslider
//
//  Created by Huanzhong Huang on 9/4/16.
//  Copyright © 2016 Huanzhong Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let progressSlider = ProgressSlider(frame: CGRectZero)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(progressSlider)
    }
    
    override func viewDidLayoutSubviews() {
        let margin: CGFloat = 20.0
        let width = view.bounds.width - 2 * margin
        let height: CGFloat = 44.0
        progressSlider.frame = CGRect(x: margin, y: view.center.y - height / 2, width: width, height: height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
