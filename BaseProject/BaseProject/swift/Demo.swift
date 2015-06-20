//
//  Demo.swift
//  BaseProject
//
//  Created by wangxiaohu on 15-4-13.
//  Copyright (c) 2015年 com.sofn.youhaog. All rights reserved.
//

import Foundation

public class Person:NSObject{

    public var des1:String = "Des1";
    
    var des2:String="Des2";
    
    private var des4:String!="Des4";
    
    var personDeleaget:PersonDelegate?;
    
    override init() {
        super.init();
    }
    
    init(des:String) {
        
        self.des1=des;
    }
    
    init(des1:String,des2:String,des3:String){
        super.init();
        self.des1=des1;
        self.des2=des2;
        self.des4=des3;
    }
    
    private func somePrivateMethod() {}
    
    func addNum(num1:Int,num2:Int)->Int{
    
        return num1+num2;
    }
    
    class func appString(des:String)->String{
    
    
        return "xiaohu === "+des;
    }
    

}

extension Person{

    func showMsg(msg:String,num:Int)->String{
    
        personDeleaget?.callBack(msg, num: num);
        
        var msgall=des1+des2+des4+"--->"+msg;
    
        println("msg="+msgall);
        return msgall;
    }

}

protocol PersonDelegate{

    func callBack(des:String,num:Int)->NSMutableArray;

}

internal class SomeInternalClass {               // 隐式的 internal 类
    var someInternalProperty = 0         // 隐式的 internal 类成员
    private func somePrivateMethod() {}  // 显示的 private 类成员
    
    internal func test(){
        println("test");
    }
}

private class SomePrivateClass {        // 显示的 private 类
    var somePrivateProperty = 0          // 隐式的 private 类成员
    func somePrivateMethod() {}          // 隐式的 private 类成员
}