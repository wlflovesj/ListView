//
//  LineGraph.swift
//  ListView
//
//  Created by wanglongfei on 2017/7/10.
//  Copyright © 2017年 wanglongfei. All rights reserved.
//

import UIKit



protocol LineGraphSelectLine {
    
    func lineSelectSomeLine(lineCount:Int)
    
}

class customRoundLayer: CAShapeLayer {
    
    var count:Int?
}
class customLineLayer: CAShapeLayer {
    
    var lineCount:Int?
}
class LineGraph: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var delegate:LineGraphSelectLine?
    var max:Double?
    var dataAry:NSArray?
    init(frame: CGRect,dataAry:NSArray) {
        
        super.init(frame: frame)
        self.dataAry=dataAry
        self.createBackGroundUI()
        self.createUI()
        self.createHeightLabel()
        self.createWidthLabel()
    }
    func createWidthLabel(){
    
      
        let width = Double(self.frame.size.width-20)/Double((self.dataAry?.count)!)
       
        for item in (self.dataAry?.enumerated())! {
            
            let x = Double(item.offset) * width + 20
           let label = UILabel.init(frame: CGRect.init(x:x , y: Double(self.frame.size.height-20), width: width, height: 20))
           label.font=UIFont.systemFont(ofSize: 10)
           label.text=String.init(format: "%d", item.offset)
           label.textAlignment=NSTextAlignment.left
           label.textColor=UIColor.white.withAlphaComponent(0.5)
             self.addSubview(label)
            
        }
        
    }
    func createHeightLabel(){
    
    
        let ratio = Double(self.frame.size.height-30)/max!
        let heightText = max!/Double((self.dataAry?.count)!)
        let height=self.frame.size.height-20
        for item in (self.dataAry?.enumerated())! {
            
     
            let YNumber=heightText*ratio
            
            let label = UILabel.init(frame: CGRect.init(x: 0, y:Double(height)-(Double(item.offset+1)*YNumber) , width: 20, height: 20))
        
            label.text=NSString.init(format: "%.0f", heightText*Double(item.offset)) as String
            label.textAlignment=NSTextAlignment.right
            label.font=UIFont.systemFont(ofSize: 10)
            label.textColor=UIColor.white.withAlphaComponent(0.5)
            self.addSubview(label)
            
        }
        
    
    
    }
    
    func createBackGroundUI(){
    
        
     
        let width = Double(self.frame.size.width-20)/Double((self.dataAry?.count)!)
        let height=self.frame.size.height-20
        let yGap=(self.frame.size.height-30)/CGFloat((self.dataAry?.count)!)
        for item in (self.dataAry?.enumerated())! {
            
            let x=Double(item.offset)*width+20
            let path = UIBezierPath.init()
            path.move(to: CGPoint.init(x: x, y: 10))
            path.addLine(to: CGPoint.init(x: x, y: Double(height)))
            path.move(to: CGPoint.init(x: 20, y:height - yGap*CGFloat(item.offset)))
            path.addLine(to: CGPoint.init(x: frame.width, y:height - yGap*CGFloat(item.offset)))
            let layer = CAShapeLayer.init()
            layer.path=path.cgPath
            layer.lineWidth=1
            layer.lineDashPattern=[NSNumber.init(value: 5),NSNumber.init(value: 3)]
            layer.strokeColor=UIColor.white.withAlphaComponent(0.2).cgColor
            self.layer.addSublayer(layer)
            
        }
        
       
    
    
    }
    
    func createUI(){
    
     let ary = self.dataAry?.sortedArray(comparator: { (one , two) -> ComparisonResult in
        
             let str1 = one as! NSString
             let str2 = two as! NSString
        if str1.doubleValue <= str2.doubleValue{
        
        
          return ComparisonResult.orderedDescending
        }else{
            
         
             return ComparisonResult.orderedAscending
        }
        
        
     })
     
        max = (ary?[0] as! NSString).doubleValue
        
        let ratio = Double(self.frame.size.height-30)/max!
        let width = Double(self.frame.size.width-20)/Double((self.dataAry?.count)!)
        let height=self.frame.size.height-20
        
     
        
        for item in (self.dataAry?.enumerated())! {
            let YNumber=(item.element as! NSString).doubleValue*ratio
            let x=Double(item.offset)*width+20
            let path = UIBezierPath.init()
            
            
            path.move(to: CGPoint.init(x:x , y: Double(height)-YNumber))
            
       
            if item.offset<(dataAry?.count)!-1 {
            let YNumberNext=(self.dataAry![item.offset+1] as! NSString).doubleValue*ratio
            let xNext=Double(item.offset+1)*width+20
            path.addLine(to: CGPoint.init(x: xNext, y:Double(height)-YNumberNext))
         
            }
          
            let layer=customLineLayer.init()
            
            layer.fillColor=UIColor.red.cgColor
            layer.strokeColor=UIColor.red.cgColor
            layer.lineWidth=2
            layer.lineCap=kCALineCapSquare
            layer.path=path.cgPath
            layer.lineCount=item.offset
            let animation=CABasicAnimation.init(keyPath: "strokeEnd")
            animation.fromValue=0
            animation.toValue=1
            animation.duration=2
            layer.add(animation, forKey: "")
            
            self.layer.addSublayer(layer)
            
            let roundPath=UIBezierPath.init(arcCenter: CGPoint.init(x: x, y: Double(height)-YNumber), radius: 4, startAngle: -.pi, endAngle: .pi, clockwise: true)
            let roundLayer = customRoundLayer.init()
            roundLayer.count=item.offset
            roundLayer.fillColor=UIColor.red.cgColor
            roundLayer.path=roundPath.cgPath
            roundLayer.lineWidth=1
            self.layer.addSublayer(roundLayer)
        }
        
        
    
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesBegan(touches, with: event)
        let touch = touches.first! as UITouch
        let point = touch.location(in: self)
        for layer in self.layer.sublayers! {
            
          
//            if layer.isKind(of: customRoundLayer.classForCoder()) {
//                 let lyer = layer as! customRoundLayer
//                if (lyer.path?.contains(point))! {
//                    
//                    
//                print("\(String(describing: lyer.count))")
//                    
//                }
//             
//                
//            }
            
            if layer.isKind(of: customLineLayer.classForCoder()) {
                
                let lineLayer = layer as! customLineLayer
              
                if (lineLayer.path?.boundingBox.contains(point))! {
                    
                    self.delegate?.lineSelectSomeLine(lineCount: lineLayer.lineCount!)
                    
                    lineLayer.lineWidth=3
                    
                }else{
                
                    lineLayer.lineWidth=2
                
                }
                
            }
            
        }
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
