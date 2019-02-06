//
//  Macro.h
//  Renaissance
//
//  Created by Albus on 2019/2/6.
//  Copyright © 2019 Albus. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

//弱引用自身
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

//获取屏幕 宽度、高度
#define ScreenW ([UIScreen mainScreen].bounds.size.width)
#define ScreenH ([UIScreen mainScreen].bounds.size.height)

//16进制颜色
#define HexColor(hexStr) [UIColor colorWithHexString:hexStr]
#define HexAlphaColor(hexStr, alpha) [UIColor colorWithHexString:hexStr alpha:alpha]

//获取主窗口
#define TheWindow [UIApplication sharedApplication].delegate.window

#endif /* Macro_h */
