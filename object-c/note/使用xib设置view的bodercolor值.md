# 使用xib设置view的BoderColor值

## 通过 category 来解决这个问题

> 原理：通过重写boardColor的方法来实现



#### .h 文件
	#import <QuartzCore/QuartzCore.h>

	@interface CALayer (RHCalayer_XibConfiguration)

	@property (nonatomic,assign)UIColor *boardUIColor;

	@end
	
	
#### .m 文件
	- (void)setBoardUIColor:(UIColor *)boardUIColor {
    	self.borderColor= boardUIColor.CGColor;
	}

	- (UIColor *)boardUIColor {
    	return [UIColor colorWithCGColor:self.borderColor];
	}
	
	
#### 然后在xib中添加boardUIColor属性即可


