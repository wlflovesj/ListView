//
//  ListViewViewModel.swift
//  ListView
//
//  Created by wanglongfei on 2017/6/29.
//  Copyright © 2017年 wanglongfei. All rights reserved.
//

import UIKit

protocol GetListViewDataDelegate {
    func getListViewData(data:NSArray)
}

class ListViewViewModel: NSObject {

    var delegate:GetListViewDataDelegate?
    
    func loadData(path:String,show:NSArray){
    
     let data = NSData.init(contentsOfFile: path)! as Data
     let dataAry =  try? JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions(rawValue: 0))
        if dataAry==nil {
            return
        }
        let ary = NSMutableArray.init()
        for obj in dataAry as! NSArray {
            let ob = obj as! NSDictionary
            let showAry=NSMutableArray.init()
            if show.count>0 {
                
                for item in show.enumerated() {
                    
                    let itemDic = item.element as! NSDictionary
                    let labelDic = NSMutableDictionary.init()
                    
                    if (ob.allKeys as NSArray).contains(itemDic["text"] as! String) {
                        
                        if ob[itemDic["text"] as! String] as? String != nil{
                           //值为字符串 没有颜色变化
                            labelDic.setValue(ob[itemDic["text"] as! String], forKey: "text")
                            labelDic.setValue(UIColor.black, forKey: "color")
                            
                        }else{
                        
                            //值为数字 根据不同算法显示不同颜色
                           let number = ob[itemDic["text"] as! String] as! NSNumber
                            if itemDic["isColor"] as! Bool {
                               //是否演示不同颜色
                                if number.doubleValue>30 {
                                    
                                    labelDic.setValue(UIColor.red, forKey: "color")
                                    
                                }else if number.doubleValue<20 {
                                
                                
                                      labelDic.setValue(UIColor.green, forKey: "color")
                                
                                }else{
                                
                                      labelDic.setValue(UIColor.black, forKey: "color")
                                
                                }
                                
                                
                            }else{
                            
                            
                                labelDic.setValue(UIColor.black, forKey: "color")
                            
                            }
                        
                            labelDic.setValue(number.stringValue, forKey: "text")
                        }
                        
                        showAry.add(labelDic)
                    }
                    
                }
                
                
                
            }else{
            
                for item in ob.allValues.enumerated() {
                    
                    let labelDic = NSMutableDictionary.init()
                    
                    if item.element as? String != nil {
                        
                        labelDic.setValue(item.element, forKey: "text")
                    }else{
                       
                        let number = item.element as! NSNumber
                        labelDic.setValue(number.stringValue, forKey: "text")
                    
                    }
                    
                    labelDic.setValue(UIColor.black, forKey: "color")
                    showAry.add(labelDic)
                }
                
            
            }
            
            ary.add(showAry)
        }
        
    
        delegate?.getListViewData(data: ary)
    }
    
    
    
    
    
}
