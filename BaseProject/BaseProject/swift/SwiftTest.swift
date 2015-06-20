//
//  NewViewController.swift
//  IOSBaseProject
//
//  Created by wangxiaohu on 15-3-18.
//  Copyright (c) 2015年 com.sofn.youhaog. All rights reserved.
//

import Foundation

class SwiftTest : NSObject{
    
    func hasAct(tag:Int) -> String{
        
        var ocTest=OCTest();
        println("index="+ocTest.hasTest(11));
        
        switch (tag)
            {
        case 1:return "Movie"
        case 2:return "CCTV"
        case 3:return "Sport TV"
        default:return "Area TV"
        }
        
    }
    
    override init(){
        println("swift constructor is called.")
    }
    
    deinit{
        println("swift destroyed is called.")
    }
}