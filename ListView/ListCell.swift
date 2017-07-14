//
//  ListCell.swift
//  ListView
//
//  Created by wanglongfei on 2017/6/29.
//  Copyright © 2017年 wanglongfei. All rights reserved.
//

import UIKit

extension UIView{

    class func CustomheadView(dataAry:NSArray,width:Double,height:Double,isDouble:Bool,index:Int,sort:Bool,isShowSort:Bool)->UIView{
    
     let customView=UIView.init(frame: CGRect.init(x: 0, y: 0, width: width*Double(dataAry.count)*width, height: height))
    
        for item in dataAry.enumerated() {
            let button = UIButton.init(type: UIButtonType.custom)
            button.frame=CGRect.init(x: width*Double(item.offset), y: 0, width: width, height: height)
            button.setTitle("\(item.element)", for: .normal)
            if isShowSort {
                if item.offset == index {
                    
                    if sort {
                      
                        button.setTitle("\(item.element)↑", for: .normal)
                        
                    }else{
                    
                        button.setTitle("\(item.element)↓", for: .normal)
                    
                    }
                    
                }
                
                
            }
            button.titleLabel?.font=UIFont.systemFont(ofSize: 16)
            customView.addSubview(button)
            button.tag=1000+item.offset
        }
    
        return customView
    
    }

    class func CustomButtonView(dataAry:NSArray
        ,width:Double,height:Double,isDouble:Bool)->UIView
    {
       let customView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: width*Double(dataAry.count), height: height))
        for item in dataAry.enumerated() {
            
            let tempDic = item.element as! NSDictionary
            if isDouble {
                
                let button = UIButton.init(type: .custom)
                button.frame=CGRect.init(x: width*Double(item.offset/2), y: Double(item.offset%2)*height/2, width: width, height: height/2)
                let str = tempDic["text"] as? String
                button.setTitle(str, for: .normal)
                button.setTitleColor(UIColor.black, for: .normal)
                button.titleLabel?.font=UIFont.systemFont(ofSize: 16)
                
                if item.offset==1 {
                    button.titleLabel?.font=UIFont.systemFont(ofSize: 10)
                    button.setTitleColor(UIColor.lightGray, for: .normal)
                
                    
                }
                button.tag=1000+item.offset
                customView.addSubview(button)
            }else{
            
              let button = UIButton.init(type: .custom)
                button.frame=CGRect.init(x: width*Double(item.offset), y: 0, width: width, height: height)
               
                button.setTitle(tempDic["text"] as? String, for: .normal)
             
                button.setTitleColor(tempDic["color"] as? UIColor, for: .normal)
                button.titleLabel?.font=UIFont.systemFont(ofSize: 16)
                button.tag=1000+item.offset
                customView.addSubview(button)
            }
            
            
        }
    
         return customView
    }
    class func CustomLabelView(dataAry:NSArray,width:Double,height:Double,isDouble:Bool)->UIView{
    
        let customView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: width*Double(dataAry.count), height: height))
    
        for item  in dataAry.enumerated() {
            
            let tempDic = item.element as! NSDictionary
            
            if isDouble {
                
                let label = UILabel.init(frame: CGRect.init(x: width*Double(item.offset/2), y: Double(item.offset%2)*height/2, width: width, height: height/2))
                let str = tempDic["text"] as? String
                label.text=str
                label.textAlignment=NSTextAlignment.center
                label.font=UIFont.systemFont(ofSize: 16)
                label.textColor=UIColor.black
                if item.offset==1 {
                    label.font=UIFont.systemFont(ofSize: 10)
                    label.textColor=UIColor.lightGray
                    label.textAlignment=NSTextAlignment.right
                    
                }
                customView.addSubview(label)
                
            }else{
            
                let label = UILabel.init(frame: CGRect.init(x: width*Double(item.offset), y: 0, width: width, height: height))
                label.text=tempDic["text"] as? String
                label.textColor=tempDic["color"] as? UIColor
                label.textAlignment=NSTextAlignment.center
                label.font=UIFont.systemFont(ofSize: 16)
                label.adjustsFontSizeToFitWidth=true
                customView.addSubview(label)
            }
            
            
        }
    
    
    return customView
    }

}



typealias ListCellButtonClick = (Int)->()
class ListCell: UITableViewCell {

    
    var buttonclick:ListCellButtonClick?
    init(style: UITableViewCellStyle, reuseIdentifier: String?,dataAry:NSArray,width:Double,height:Double,isDouble:Bool) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.separatorInset=UIEdgeInsetsMake(0, 0, 0, 0)
        let cell = UIView.CustomButtonView(dataAry: dataAry, width: width, height: height, isDouble: isDouble)
        
        
        for button in cell.subviews {
            
            let btn = button as! UIButton
            
            btn.addTarget(self, action: #selector(onButton(sender:)), for: .touchUpInside)
            
        }
        
        self.contentView.addSubview(cell)
        
    }
    func onButton(sender:UIButton){
    
    
         self.buttonclick!(sender.tag)
       
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
