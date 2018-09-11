//
//  ArcProgressView.h
//  dsasdwq
//
//  Created by 朱鑫华 on 2018/9/11.
//  Copyright © 2018年 朱鑫华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArcProgressView : UIView

@property (nonatomic,assign) CGFloat progress;
+ (instancetype)arcProgressView;
- (void)startAnimation;
@end
