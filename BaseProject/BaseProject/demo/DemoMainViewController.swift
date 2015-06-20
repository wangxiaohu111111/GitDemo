//
//  DemoMainViewController.swift
//  BaseProject
//
//  Created by wangxiaohu on 15-2-11.
//  Copyright (c) 2015年 com.sofn.youhaog. All rights reserved.
//

import UIKit;

class DemoMainViewController: BaseViewController {
    
    @IBOutlet weak var ffpegButton: UIButton!
    
    @IBOutlet weak var nettyButton: UIButton!
    
    @IBOutlet weak var afnetworkButton: UIButton!
    
    @IBOutlet weak var ocSwiftButton: UIButton!
    
    @IBOutlet weak var keyBoardButton: UIButton!
    
     var isHindeNav=true
    
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        isHindeNav=true;
        self.navigationController!.interactivePopGestureRecognizer.enabled=false;
    }
    
    override func createNavTitleView() -> UIView! {
        var titleView:UILabel=UILabel(frame: CGRectMake(0, 0, 100, 50));
        
        titleView.text="测试页面";
        titleView.textColor=UIColor.whiteColor();
        titleView.font=UIFont.boldSystemFontOfSize(18);
        titleView.textAlignment=NSTextAlignment.Center;
        
        return titleView;
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated);
        if isHindeNav {
            self.navigationController?.setNavigationBarHidden(true, animated: true);
        }
    }
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated);
    }
    
    @IBAction func keyBoardAction(sender: AnyObject) {
        self.isHindeNav=false;
        var keyboardViewController:KeyBoardDemoViewController!=KeyBoardDemoViewController();
        
        self.navigationController!.pushViewController(keyboardViewController, animated: true);
        
    }
    
    @IBAction func afnetworkingAction(sender: UIButton) {
        self.isHindeNav=false;
        
        var afnetworkingViewController:AFNetworkingViewController!=AFNetworkingViewController();
        
        self.navigationController!.pushViewController(afnetworkingViewController, animated: true);
//        self .performSegueWithIdentifier("", sender: nil);
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        self.isHindeNav=false;
        println("identifier="+segue.identifier);
    }
    
    @IBAction func ocSwiftAction(sender: UIButton) {
        self.isHindeNav=false;
        
        var occhannel:OCChannel!=OCChannel();
        var msg:String!=occhannel.ChannelChange(2);
        println("msg="+msg);

    }
    
    @IBAction func nettyAction(sender: UIButton) {
        self.isHindeNav=false;
        
        var nettyViewController:NettyDemoViewController!=NettyDemoViewController();
        
        self.navigationController!.pushViewController(nettyViewController, animated: true);
        
    }
    @IBAction func playFFMPEGAction(sender: UIButton) {
        self.isHindeNav=false;
        var videoPlayViewController:VideoViewController!=VideoViewController();
        self.navigationController!.pushViewController(videoPlayViewController, animated: true);
//        var xmoveView:KxMovieMainViewController=KxMovieMainViewController();
//        self.navigationController!.pushViewController(xmoveView, animated: true);
    }
}
