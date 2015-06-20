//
//  ByteUtil.m
//  BaseProject
//
//  Created by wangxiaohu on 15-2-6.
//  Copyright (c) 2015年 com.sofn.youhaog. All rights reserved.
//

#import "ByteUtil.h"

@implementation ByteUtil


+(NSString *)nsDataToNSString:(NSData *)data{
    NSString * aString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return aString;
}

+(NSData *)nsStringToNSData:(NSString *)msg{
    
    return [msg dataUsingEncoding: NSUTF8StringEncoding];
}

+(Byte *)nsDataToBytes:(NSString *)data{
    NSData *testData = [data dataUsingEncoding: NSUTF8StringEncoding];
    Byte *testByte = (Byte *)[testData bytes];
    return testByte;
}

+(NSData *)shortToByteArr:(short)param{
    Byte bt1 = ((param >> 8) & 0xff);
    Byte bt2 = (param & 0xff);
    
    Byte byte1[] = {bt1,bt2};
    NSData * adata1 = [[NSData alloc] initWithBytes:byte1 length:sizeof(byte1)];
    
    return adata1;
}

+(NSData *)intToByte:(int)param{
    
    Byte bt1 = ((param >> 24) & 0xff);
    Byte bt2  = ((param >> 16) & 0xff);
    Byte bt3  = ((param >> 8) & 0xff);
    Byte bt4 = (param & 0xff);
    
    Byte byte1[] = {bt1,bt2,bt3,bt4};
    NSData * adata1 = [[NSData alloc] initWithBytes:byte1 length:sizeof(byte1)];
    return adata1;
}

+(NSData *)longToByte:(long)param{
    
    Byte bt1 = ((param >> 56) & 0xff);
    Byte bt2 = ((param >> 48) & 0xff);
    Byte bt3 = ((param >> 40) & 0xff);
    Byte bt4 = ((param >> 32) & 0xff);
    Byte bt5 = ((param >> 24) & 0xff);
    Byte bt6 = ((param >> 16) & 0xff);
    Byte bt7 = ((param >> 8) & 0xff);
    Byte bt8 = (param & 0xff);
    
    Byte byte1[] = {bt1,bt2,bt3,bt4,bt5,bt6,bt7,bt8};
    NSData * adata1 = [[NSData alloc] initWithBytes:byte1 length:sizeof(byte1)];
    return adata1;
}

+(NSData *)charToByte:(char)param{
    
    int temp = (int) param;
    Byte bt1 = (temp >> 8 & 0xff);
    Byte bt2 = (temp & 0xff);
    Byte byte1[] = {bt1,bt2};
    NSData * adata1 = [[NSData alloc] initWithBytes:byte1 length:sizeof(byte1)];
    return adata1;
}
//
//    /**
//     * double转换byte数组
//     *
//     * @param param
//     *            double
//     * @return byte数组
//     *
//     * @author li
//     * @date 2014-1-16 下午4:45:57
//     */
//    public static byte[] doubleToByteArr(double param) {
//        byte[] b = new byte[8];
//        long l = Double.doubleToLongBits(param);
//        for (int i = 0; i < b.length; i++) {
//            b[i] = new Long(l).byteValue();
//            l = l >> 8;
//        }
//        return b;
//    }
//
//    /**
//     * float转换byte数组
//     *
//     * @param param
//     *            float
//     * @return byte数组
//     *
//     * @author li
//     * @date 2014-1-16 下午5:05:04
//     */
//    public static byte[] floatToByteArr(float param) {
//        byte[] b = new byte[4];
//        int l = Float.floatToIntBits(param);
//        for (int i = 0; i < b.length; i++) {
//            b[i] = new Integer(l).byteValue();
//            l = l >> 8;
//        }
//        return b;
//    }
//
//    /**
//     * 将2字节的byte数组转成short值
//     *
//     * @param b
//     *            byte数组
//     * @return
//     *
//     * @author li
//     * @date 2014-1-16 下午3:00:01
//     */
//    public static short byteArrToShort(byte[] b) {
//        byte[] a = new byte[2];
//        int i = a.length - 1, j = b.length - 1;
//        for (; i >= 0; i--, j--) {
//            // 从b的尾部(即int值的低位)开始copy数据
//            if (j >= 0)
//                a[i] = b[j];
//            else
//                // 如果b.length不足2,则将高位补0
//                a[i] = 0;
//        }
//        // &0xff将byte值无差异转成int,避免Java自动类型提升后,会保留高位的符号位
//        int v0 = (a[0] & 0xff) << 8;
//        int v1 = (a[1] & 0xff);
//        return (short) (v0 + v1);
//    }
//
//    /**
//     * 将4字节的byte数组转成int值
//     *
//     * @param b
//     *            byte数组
//     * @return
//     *
//     * @author li
//     * @date 2014-1-16 下午3:00:01
//     */

+(int)bytesToInt:(NSData *)parame{
    Byte a[] = {0x00,0x00,0x00,0x00};
    int i = (int)[parame length] - 1;
    int j = (int)[parame length] - 1;
    Byte * b = (Byte *)[parame bytes];
    for (; i >= 0; i--, j--) {
        // 从b的尾部(即int值的低位)开始copy数据
        if (j >= 0){
            a[i] = b[j];
        }else{
            // 如果b.length不足4,则将高位补0
            a[i] = 0;
        }
    }
    // &0xff将byte值无差异转成int,避免Java自动类型提升后,会保留高位的符号位
    int v0 = (a[0] & 0xff) << 24;
    int v1 = (a[1] & 0xff) << 16;
    int v2 = (a[2] & 0xff) << 8;
    int v3 = (a[3] & 0xff);
    return v0 + v1 + v2 + v3;
}
//    public static int byteArrToInt(byte[] b) {
//        byte[] a = new byte[4];
//        int i = a.length - 1, j = b.length - 1;
//        for (; i >= 0; i--, j--) {
//            // 从b的尾部(即int值的低位)开始copy数据
//            if (j >= 0)
//                a[i] = b[j];
//            else
//                // 如果b.length不足4,则将高位补0
//                a[i] = 0;
//        }
//        // &0xff将byte值无差异转成int,避免Java自动类型提升后,会保留高位的符号位
//        int v0 = (a[0] & 0xff) << 24;
//        int v1 = (a[1] & 0xff) << 16;
//        int v2 = (a[2] & 0xff) << 8;
//        int v3 = (a[3] & 0xff);
//        return v0 + v1 + v2 + v3;
//    }
//
//    /**
//     * 将8字节的byte数组转成long值
//     *
//     * @param b
//     *            byte数组
//     * @return
//     *
//     * @author li
//     * @date 2014-1-16 下午3:00:01
//     */
//    public static long byteArrToLong(byte[] b) {
//        byte[] a = new byte[8];
//        int i = a.length - 1, j = b.length - 1;
//        for (; i >= 0; i--, j--) {
//            // 从b的尾部(即int值的低位)开始copy数据
//            if (j >= 0)
//                a[i] = b[j];
//            else
//                // 如果b.length不足4,则将高位补0
//                a[i] = 0;
//        }
//        // &0xff将byte值无差异转成int,避免Java自动类型提升后,会保留高位的符号位
//        int v0 = (a[0] & 0xff) << 56;
//        int v1 = (a[1] & 0xff) << 48;
//        int v2 = (a[2] & 0xff) << 40;
//        int v3 = (a[3] & 0xff) << 32;
//        int v4 = (a[4] & 0xff) << 24;
//        int v5 = (a[5] & 0xff) << 16;
//        int v6 = (a[6] & 0xff) << 8;
//        int v7 = (a[7] & 0xff);
//        return v0 + v1 + v2 + v3 + v4 + v5 + v6 + v7;
//    }
//
//    /**
//     * 将2字节的byte数组转成字符值
//     *
//     * @param b
//     *            byte数组
//     * @return
//     *
//     * @author li
//     * @date 2014-1-16 下午3:00:01
//     */
//    public static char byteArrToChar(byte[] b) {
//        byte[] a = new byte[2];
//        int i = a.length - 1, j = b.length - 1;
//        for (; i >= 0; i--, j--) {
//            // 从b的尾部(即int值的低位)开始copy数据
//            if (j >= 0)
//                a[i] = b[j];
//            else
//                // 如果b.length不足2,则将高位补0
//                a[i] = 0;
//        }
//        // &0xff将byte值无差异转成int,避免Java自动类型提升后,会保留高位的符号位
//        int v0 = (a[0] & 0xff) << 8;
//        int v1 = (a[1] & 0xff);
//        return (char) (v0 + v1);
//    }
//
//    /**
//     * byte数组到double转换
//     *
//     * @param
//     * @return double
//     *
//     * @author li
//     * @date 2014-1-16 下午5:25:14
//     */
//    public static double byteArrToDouble(byte[] b) {
//        long l;
//        l = b[0];
//        l &= 0xff;
//        l |= ((long) b[1] << 8);
//        l &= 0xffff;
//        l |= ((long) b[2] << 16);
//        l &= 0xffffff;
//        l |= ((long) b[3] << 24);
//        l &= 0xffffffffl;
//        l |= ((long) b[4] << 32);
//        l &= 0xffffffffffl;
//        l |= ((long) b[5] << 40);
//        l &= 0xffffffffffffl;
//        l |= ((long) b[6] << 48);
//        l &= 0xffffffffffffffl;
//        l |= ((long) b[7] << 56);
//        return Double.longBitsToDouble(l);
//    }
//
//    /**
//     * byte数组到float转换
//     *
//     * @param
//     * @return float
//     *
//     * @author li
//     * @date 2014-1-16 下午5:25:14
//     */
//    public static float byteArrToFloat(byte[] b) {
//        int l;
//        l = b[0];
//        l &= 0xff;
//        l |= ((long) b[1] << 8);
//        l &= 0xffff;
//        l |= ((long) b[2] << 16);
//        l &= 0xffffff;
//        l |= ((long) b[3] << 24);
//        return Float.intBitsToFloat(l);
//    }


@end
