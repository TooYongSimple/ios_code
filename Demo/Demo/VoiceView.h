//
//  VoiceView.h
//  Demo
//
//  Created by zhangjianyun on 2020/12/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VoiceView : UIView
@property (nonatomic, copy) void (^itemLevelCallback)();

@property (nonatomic) NSUInteger numberOfItems;

@property (nonatomic) UIColor * itemColor;

@property (nonatomic) CGFloat level;

- (void)start;

- (void)stop;

@end

NS_ASSUME_NONNULL_END
