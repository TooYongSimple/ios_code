## 可以添加属性  从而让Storyboard 中能显示出圆角来

> .h 文件

	#import <UIKit/UIKit.h>

	IB_DESIGNABLE
	@interface XHButton : UIButton
	@property (nonatomic ,strong) IBInspectable 	UIColor *borderColor;
	@property (nonatomic) IBInspectable CGFloat 	borderWidth;
	@property (nonatomic) IBInspectable CGFloat 	cornerRadius;
	@end
> .m 文件

	- (void)setBorderColor:(UIColor *)borderColor {
    	self.layer.borderColor = borderColor.CGColor;
	}
	- (void)setBorderWidth:(CGFloat)borderWidth {
	    self.layer.borderWidth = borderWidth;
	}
	- (void)setCornerRadius:(CGFloat)cornerRadius {
		self.layer.masksToBounds = YES;			 		self.layer.cornerRadius = cornerRadius;
	}


### 可以添加属性  从而让Storyboard 中能显示出圆角来