//
//  ListView.swift
//  ListView
//
//  Created by wanglongfei on 2017/6/29.
//  Copyright © 2017年 wanglongfei. All rights reserved.
//

import UIKit



let zeroframe=CGRect.init(x: 0, y: 0, width: 0, height: 0)


protocol ListViewDidSelectDelegate {
    
    func ListViewDidSelect(tag:Int,indexPathRow:Int)
    
}

class ListView: UIView,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate {

    var delegate:ListViewDidSelectDelegate?
    
    private let rightTableView=UITableView.init(frame:zeroframe, style: UITableViewStyle.plain)
    private let rightScrollView=UIScrollView.init(frame: zeroframe)
    private let leftTableView=UITableView.init(frame: zeroframe, style: UITableViewStyle.plain)
    private let numberTableView=UITableView.init(frame: zeroframe, style: UITableViewStyle.plain)
    private var _isShowSort:Bool?
    private var _isShowNumber:Bool?
    private let rightData=NSMutableArray.init()
    private let leftData=NSMutableArray.init()
    private var sort:Bool?
    private var headIndexSelect:Int?
    private var _isDouble:Bool?
    private var lbwidth:Double?
    private var lbheight:Double?
    var Data:NSArray?{
    
        didSet{
        
           self.createData()
        
        }
    
    }
    var rightTitles:NSArray?{
    
    
        didSet{
        
         rightTableView.frame.size.width=CGFloat(lbwidth!*Double((rightTitles?.count)!))
         rightScrollView.contentSize=CGSize.init(width: lbwidth!*Double((rightTitles?.count)!), height: 0)
        
        }
    
    }
    var leftTitles:NSArray?
    
    func createData() {
        
        leftData.removeAllObjects()
        rightData.removeAllObjects()
        for item in (Data?.enumerated())! {
            
            let leftTempAry=NSMutableArray.init()
            let rightTempAry=NSMutableArray.init()
            
            for dic in (item.element as! NSArray).enumerated() {
                
                let tempDic = dic.element as! NSDictionary
                if _isDouble! {
                    
                    if dic.offset/2==0 {
                        
                        leftTempAry.add(tempDic)
                    }else{
                     
                        rightTempAry.add(tempDic)
                    }
                    
                }else{
                
                    if dic.offset==0 {
                        
                        leftTempAry.add(tempDic)
                    }else{
                        
                        rightTempAry.add(tempDic)
                        
                    }

                
                
                }
                
            }
            leftData.add(leftTempAry)
            rightData.add(rightTempAry)
            
        }
        rightTableView.reloadData()
        leftTableView.reloadData()
        
    }
  
    
    init(frame: CGRect,Xwidth:Double,Yheight:Double,isDouble:Bool,isShowSort:Bool,isShowNumber:Bool) {
        super.init(frame: frame)
        lbwidth=Xwidth
        lbheight=Yheight
        _isDouble=isDouble
        _isShowSort=isShowSort
        _isShowNumber=isShowNumber
        sort=false
        numberTableView.frame=CGRect.init(x: 0, y: 0, width: lbwidth!, height:Double(frame.height))
        rightScrollView.frame=CGRect.init(x: lbwidth!, y: 0, width: Double(frame.width)-lbwidth!, height: Double(frame.height))
        
        if isShowNumber {
            
            rightScrollView.frame.origin.x=CGFloat(2*lbwidth!)
            rightScrollView.frame.size.width=frame.width-CGFloat(2*lbwidth!)
        }else{
        
             numberTableView.frame.size.width=0
        
        }
        leftTableView.frame=CGRect.init(x: Double(numberTableView.frame.size.width), y: 0, width: Double(frame.width), height: Double(frame.height))
        rightTableView.frame=CGRect.init(x: 0, y: 0, width: lbwidth!, height: Double(frame.height))
        self.addSubview(numberTableView)
        self.addSubview(leftTableView)
        self.addSubview(rightScrollView)
        rightScrollView.addSubview(rightTableView)
        headIndexSelect=1
        leftTableView.delegate=self
        leftTableView.dataSource=self
        rightTableView.delegate=self
        rightTableView.dataSource=self
        rightScrollView.delegate=self
        numberTableView.delegate=self
        numberTableView.dataSource=self
        leftTableView.rowHeight=CGFloat(lbheight!)
        rightTableView.rowHeight=CGFloat(lbheight!)
        numberTableView.rowHeight=CGFloat(lbheight!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Data==nil ? 0 : Data!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView==leftTableView {
            let cell = ListCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "listcell", dataAry: leftData[indexPath.row] as! NSArray, width: lbwidth!, height: lbheight!, isDouble: _isDouble!)
            cell.buttonclick={tag in
                
            
                
            }
            return cell
        }else if tableView==rightTableView{
        
            let cell = ListCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "listcell", dataAry: rightData[indexPath.row] as! NSArray, width: lbwidth!, height: lbheight!, isDouble: false)
            cell.buttonclick={tag in
                
              self.delegate?.ListViewDidSelect(tag: tag, indexPathRow: indexPath.row)
                
            }
            
            return cell
        
        
        }else{
        
            let cell = ListCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "listcell", dataAry: [["text":"\(indexPath.row+1)","color":UIColor.black]], width: lbwidth!, height: lbheight!, isDouble: false)
              cell.buttonclick={tag in
                
                
                
             }
             return cell
        }
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if tableView==leftTableView {
            
            let leftHeadView = UIView.CustomheadView(dataAry:leftTitles!, width: lbwidth!, height: 40, isDouble: false, index: headIndexSelect!, sort: sort!, isShowSort: false)
            leftHeadView.backgroundColor=UIColor.lightGray
            return leftHeadView
        }else if tableView==rightTableView{
         
            let rightHeadView = UIView.CustomheadView(dataAry: rightTitles!, width: lbwidth!, height: 40, isDouble: false, index: headIndexSelect!, sort: sort!, isShowSort: _isShowSort!)
            if _isShowSort! {
                for item in rightHeadView.subviews {
                    
                    let button = item as! UIButton
                    button.addTarget(self, action: #selector(onButton(sender:)), for: .touchUpInside)
                    
                }
            }
          rightHeadView.backgroundColor=UIColor.lightGray
            return rightHeadView
        
        }else{
        
              let show = UIView.CustomheadView(dataAry: ["排名"], width: lbwidth!, height: 40, isDouble: false, index: 0, sort: sort!, isShowSort: false)
              show.backgroundColor=UIColor.lightGray
              return show
        }
        
    }
    func onButton(sender:UIButton) {
        
        var ary:NSArray?
        headIndexSelect=sender.tag-1000
        if sort! {
            
            ary=self.sortDataAry(index:sender.tag,Sortingmarks:0)
            
        }else{
        
            ary=self.sortDataAry(index:sender.tag,Sortingmarks:1)
        
        }
        sort = !sort!
        
        self.Data = ary as NSArray?
    }
    func sortDataAry(index:Int,Sortingmarks:Int) -> NSArray {
        
        let ary = self.Data?.sortedArray(comparator: { (one, two) -> ComparisonResult in
            
            let dic1 = one as! NSArray
            let dic2 = two as! NSArray
            var count:Int?
            if _isDouble!{
            
               count=2
            
            }else{
            
               count=1
            }
            let str1 = dic1[index-1000+count!] as! NSDictionary
            let str2 = dic2[index-1000+count!] as! NSDictionary
            let r1 = str1["text"] as! NSString
            let r2 = str2["text"] as! NSString
            if Sortingmarks==0{
             
                if r1.doubleValue <= r2.doubleValue{
                    
                     return ComparisonResult.orderedDescending
                    
                }else{
                
                     return ComparisonResult.orderedAscending
                    
                }
            
            
            }else{
            
                if r1.doubleValue >= r2.doubleValue{
                
                 return ComparisonResult.orderedDescending
                
                }else{
                
                   return ComparisonResult.orderedAscending
                    
                }
            
            
            }
            
        })
        
        
        return ary! as NSArray
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView==leftTableView {
            
            self.ScrollFollowTheOther(tableView: rightTableView, otherTableView: leftTableView)
            self.ScrollFollowTheOther(tableView: numberTableView, otherTableView: leftTableView)
        }else if scrollView==rightTableView{
        
           self.ScrollFollowTheOther(tableView: leftTableView, otherTableView: rightTableView)
           self.ScrollFollowTheOther(tableView: numberTableView, otherTableView: rightTableView)
        
        }else if scrollView==numberTableView{
        
            self.ScrollFollowTheOther(tableView: leftTableView, otherTableView: numberTableView)
            self.ScrollFollowTheOther(tableView: rightTableView, otherTableView: numberTableView)
        
        }else{
        
        
        }
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func ScrollFollowTheOther(tableView:UITableView,otherTableView:UITableView) {
        
        let offsetY = otherTableView.contentOffset.y
        var offset = tableView.contentOffset
        offset.y = offsetY
        tableView.contentOffset=offset
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
       
        
    }
    
}
