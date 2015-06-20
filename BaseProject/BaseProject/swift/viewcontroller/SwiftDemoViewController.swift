//
//  SwiftDemoViewController.swift
//  IOSBaseProject
//
//  Created by wangxiaohu on 15-3-19.
//  Copyright (c) 2015年 com.sofn.youhaog. All rights reserved.
//

import UIKit

class SwiftDemoViewController : BaseViewController,PersonDelegate {
    
    var msg:String = "";

    
    override func viewDidLoad() {
        super.viewDidLoad();
        
//        var demo:Person=Person();
//        var demo:Person=Person(des:"xiaoqiang");
        var demo:Person=Person(des1: "xiaoqiang", des2: "xiaogang", des3: "xiaohu");
        demo.personDeleaget=self;
        
        println("des1="+demo.des1);
        println("des2="+demo.des2);
//        println("des4="+demo.des4);
        
        var numx:Int=demo.addNum(10, num2: 15);
        println("numx=\(numx)");
        println("DES="+Person.appString("james"));
        
        demo.showMsg("xxxxx",num:14);
        
        var demo1:SomeInternalClass=SomeInternalClass();
        
        println("numx=\(demo1.someInternalProperty)");
        demo1.test();
        
        
        
    }
    
    
    func callBack(des:String,num:Int)->NSMutableArray{
    
        println("call Back");
        var dataSet:NSMutableArray=NSMutableArray();
    
        for(var z=0;z<num;z++){
            var msgx="\(des)+\(z)";
            var title="msgx=";
            println(title+msgx);
            dataSet.addObject(msgx);
        }
        
        return dataSet;
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated);
        self.navigationController?.setNavigationBarHidden(true, animated: true);
    }
    
    @IBAction func backAction(sender: AnyObject) {
        
        self.navigationController?.popViewControllerAnimated(true);
//        self.dismissViewControllerAnimated(1, completion: {()->Void in
//            var i=2;
//            NSLog("dismissViewController completion i=%d",i);
//        });
//        self.performSegueWithIdentifier("", sender: nil);
    }
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        NSLog("prepareForSegue="+segue.identifier);
//    }
}