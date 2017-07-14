//
//  ListModel.swift
//  ListView
//
//  Created by wanglongfei on 2017/7/13.
//  Copyright © 2017年 wanglongfei. All rights reserved.
//

import UIKit



class ListModel: NSObject {

    var text:String?
    var color:UIColor?
    
    
    
    override init() {
        
        
       self.color=UIColor.red
       self.text="--"
        
    }
    
}
