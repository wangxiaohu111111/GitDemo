//
//  CommunicationConstant.h
//  BaseProject
//
//  Created by wangxiaohu on 15-2-6.
//  Copyright (c) 2015年 com.sofn.youhaog. All rights reserved.
//

#ifndef BaseProject_CommunicationConstant_h
#define BaseProject_CommunicationConstant_h



#define  TIME_FORMART @"yyyy-MM-dd HH:mm:ss";
#define  LOGIN_SUCCESS @"LOGIN_SUCCESS";//登录成功
#define  LOGIN_FAIL @"LOGIN_FAIL";//登录失败

static Byte LOGIN= 0x01;//登录类型
static Byte CONNECTED_RESPONSE= 0x02;//连接响应
static Byte LOGINOUT= 0x03;//登出
static Byte HEARTBEAT_SEND= 0x04;//发送心跳
static Byte HEARTBEAT_RESPONSE= 0x05;//响应心跳
static Byte CHAT_TEXT= 0x06;//文字传输
static Byte  CHAT_IMAGE= 0x07;//图片传输
static Byte CHAT_AV= 0x08;//微语音视频信息传输
static Byte SYSTEM_MESSAGE= 0x09;//系统提醒信息
static Byte USER_MESSAGE= 0x10;//用户提醒信息


static int dur=10;//心跳包间隔时间(秒)


#endif
