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
    
       self.automaticallyAdjustsScrollViewInsets=false
      listview=ListView.init(frame: CGRect.init(x: 0, y: 64, width: self.view.frame.size.width, height: self.view.frame.size.height-64), Xwidth: Double(self.view.frame.width/5), Yheight: 60, isDouble: true, isShowSort: true, isShowNumber: true)
      listview?.leftTitles=["简码代称"]
      listview?.rightTitles=["最新价","涨跌幅","成交量","开盘价","收盘价"]
      self.view.addSubview(listview!)
      listview?.delegate=self
      let viewModel = ListViewViewModel.init()
          viewModel.delegate=self
        let model=ListModel.init()
        model.text="name"
        model.color=UIColor.red

      let path = Bundle.main.path(forResource: "data", ofType: "json")
      viewModel.loadData(path: path!, show: [["text":"name","isColor":false],["text":"traAmount","isColor":false],["text":"preClosePri","isColor":true],["text":"openPri","isColor":true],["text":"todayMin","isColor":true],["text":"ma5","isColor":false],["text":"ma10","isColor":false]])
    }
    func getListViewData(data: NSArray) {
        
        listview?.Data=data
    }
    func ListViewDidSelect(tag:Int,indexPathRow:Int) {
        
        print("tag:\(tag),indexPathRow:\(indexPathRow)")
        let se = secondViewController.init()
        self.navigationController?.pushViewController(se, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

