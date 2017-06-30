//
//  ViewController.swift
//  ListView
//
//  Created by wanglongfei on 2017/6/29.
//  Copyright © 2017年 wanglongfei. All rights reserved.
//

import UIKit

class ViewController: UIViewController,ListViewDidSelectDelegate,GetListViewDataDelegate {

    var listview:ListView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.createUI()
    }
    
    func createUI(){
    
      listview=ListView.init(frame: self.view.frame, Xwidth: Double(self.view.frame.width/5), Yheight: 60, isDouble: true, isShowSort: true, isShowNumber: true)
      listview?.leftTitles=["简码代称"]
      listview?.rightTitles=["最新价","涨跌幅","成交量","开盘价","收盘价"]
      self.view.addSubview(listview!)
      listview?.delegate=self
      let viewModel = ListViewViewModel.init()
      viewModel.delegate=self
      let path = Bundle.main.path(forResource: "data", ofType: "txt")
      viewModel.loadData(path: path!, show: [["text":"name","isColor":false],["text":"traAmount","isColor":false],["text":"preClosePri","isColor":true],["text":"openPri","isColor":true],["text":"todayMin","isColor":true],["text":"ma5","isColor":false],["text":"ma10","isColor":false]])
    }
    func getListViewData(data: NSArray) {
        
        listview?.Data=data
    }
    func ListViewDidSelect(namecode: String) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

