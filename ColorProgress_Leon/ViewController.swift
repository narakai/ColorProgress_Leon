//
//  ViewController.swift
//  ColorProgress_Leon
//
//  Created by lai leon on 2017/9/5.
//  Copyright © 2017 clem. All rights reserved.
//

import UIKit

let YHRect = UIScreen.main.bounds
let YHHeight = YHRect.size.height
let YHWidth = YHRect.size.width
let ProgressRect = CGRect(x: 20, y: 200, width: YHWidth - 40, height: 20)

class ViewController: UIViewController {

    let colorProgress = ColorProgress(frame: ProgressRect)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupView()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {
            (time) in
            self.colorProgress.progress += 0.08
            if self.colorProgress.progress >= 1.0 {
                time.invalidate()
            }
        })
    }


    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(colorProgress)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
