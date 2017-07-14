//
//  secondViewController.swift
//  ListView
//
//  Created by wanglongfei on 2017/7/10.
//  Copyright © 2017年 wanglongfei. All rights reserved.
//

import UIKit

class secondViewController: UIViewController,LineGraphSelectLine {

    let label=UILabel.init(frame: CGRect.init(x: 0, y: 400, width: UIScreen.main.bounds.width, height: 30))
    override func viewDidLoad() {
        super.viewDidLoad()
        let line = LineGraph.init(frame: CGRect.init(x: 0, y: 100, width: self.view.frame.width, height: 200), dataAry: ["20","30","15","13","22","32","34","45","67","32","45","32","55","32","33","12"])
        line.backgroundColor=UIColor.black
        line.delegate=self
        label.textColor=UIColor.white
        label.textAlignment=NSTextAlignment.center
        self.view.addSubview(line)
        self.view.addSubview(label)
        
        // Do any additional setup after loading the view.
    }
    func lineSelectSomeLine(lineCount: Int) {
        
        label.text="(选中了第\(lineCount)条线)"
       
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
