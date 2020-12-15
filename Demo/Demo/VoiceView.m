//
//  VoiceView.m
//  Demo
//
//  Created by zhangjianyun on 2020/12/15.
//

#import "VoiceView.h"

@interface VoiceView ()

// 用来记录音频强度
@property (nonatomic, strong) NSMutableArray * levels;
@property (nonatomic, strong) NSMutableArray * itemLineLayers;
@property (nonatomic) CGFloat itemHeight;
@property (nonatomic) CGFloat itemWidth;
@property (nonatomic) CGFloat lineWidth;//自适应
@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation VoiceView
- (id)init {
    NSLog(@"init");
    if(self = [super init]) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    NSLog(@"initWithFrame");
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    NSLog(@"awakeFromNib");
    [self setup];
}

- (void)setup {
    
    NSLog(@"setup");

    // 多少个竖杠
    self.numberOfItems = 9.f;
    // 颜色
    self.itemColor = [UIColor colorWithRed:241/255.f green:60/255.f blue:57/255.f alpha:1.0];
}

#pragma mark - layout

- (void)layoutSubviews {
    [super layoutSubviews];

    self.itemHeight = CGRectGetHeight(self.bounds);
    self.itemWidth = CGRectGetWidth(self.bounds);

    // 每个竖杠的宽度
    self.lineWidth = self.itemWidth / (self.numberOfItems * 2 + 2);
    NSLog(@"self.lineWidth = %f", self.lineWidth);
}

#pragma mark - setter

- (void)setItemColor:(UIColor *)itemColor {
    _itemColor = itemColor;
    for (CAShapeLayer *itemLine in self.itemLineLayers) {
        itemLine.strokeColor = [self.itemColor CGColor];
    }
}

- (void)setNumberOfItems:(NSUInteger)numberOfItems {
    if (_numberOfItems == numberOfItems) {
        return;
    }
    _numberOfItems = numberOfItems;

    self.levels = [[NSMutableArray alloc]init];
    for(int i = 0 ; i < self.numberOfItems ; i++){
        [self.levels addObject:@(0)];
    }

    for (CAShapeLayer *itemLine in self.itemLineLayers) {
        [itemLine removeFromSuperlayer];
    }
    
    // 创建动画所需的 layer
    self.itemLineLayers = [NSMutableArray array];
    for(int i=0; i < numberOfItems; i++) {
        CAShapeLayer *itemLine = [CAShapeLayer layer];
        itemLine.lineCap       = kCALineCapButt;
        itemLine.lineJoin      = kCALineJoinRound;
        itemLine.strokeColor   = [[UIColor clearColor] CGColor];
        itemLine.fillColor     = [[UIColor clearColor] CGColor];
        itemLine.strokeColor   = [self.itemColor CGColor];
        itemLine.lineWidth     = self.lineWidth;

        [self.layer addSublayer:itemLine];
        [self.itemLineLayers addObject:itemLine];
    }
}

- (void)setLineWidth:(CGFloat)lineWidth {
    if (_lineWidth != lineWidth) {
        _lineWidth = lineWidth;
        for (CAShapeLayer *itemLine in self.itemLineLayers) {
            itemLine.lineWidth = lineWidth;
        }
    }
}

- (void)setItemLevelCallback:(void (^)())itemLevelCallback {
    _itemLevelCallback = itemLevelCallback;
    [self start];
}

// 监听声音变化
- (void)setLevel:(CGFloat)level {
    
    level = (level+37.5)*3.2;
    if( level < 0 ) level = 0;

    [self.levels removeObjectAtIndex:self.numberOfItems - 1];
    [self.levels insertObject:@(level / 6.f) atIndex:0];
    
    [self updateItems];
}


#pragma mark - update

- (void)updateItems {
    //NSLog(@"updateMeters");

    UIGraphicsBeginImageContext(self.frame.size);

    int lineOffset = self.lineWidth * 2.f;

    int leftX = self.itemWidth;

    for(int i = 0; i < self.numberOfItems; i++) {

        CGFloat lineHeight = self.lineWidth + [self.levels[i] floatValue] * self.lineWidth / 2.f;
        CGFloat lineTop = (self.itemHeight - lineHeight) / 2.f;
        CGFloat lineBottom = (self.itemHeight + lineHeight) / 2.f;

        leftX -= lineOffset;

        UIBezierPath *linePathLeft = [UIBezierPath bezierPath];
        [linePathLeft moveToPoint:CGPointMake(leftX, lineTop)];
        [linePathLeft addLineToPoint:CGPointMake(leftX, lineBottom)];
        CAShapeLayer *itemLine2 = [self.itemLineLayers objectAtIndex:i];
        itemLine2.path = [linePathLeft CGPath];
    }
    
    UIGraphicsEndImageContext();
}

- (void)start {
    if (self.displayLink == nil) {
        self.displayLink = [CADisplayLink displayLinkWithTarget:_itemLevelCallback selector:@selector(invoke)];
        self.displayLink.frameInterval = 6.f;
        [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)stop {
    [self.displayLink invalidate];
    self.displayLink = nil;
}

@end
