//
//  UILabel+Gradient.m
//  GradientLabel
//
//  Created by _Finder丶Tiwk on 16/7/28.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "UILabel+Gradient.h"

@implementation NSValue (GradientVector)

+ (instancetype)valueWithVector:(GradientVector)vector{
    return [NSValue valueWithBytes:&vector objCType:@encode(GradientVector)];
}

- (GradientVector)gradientVectorValue{
    GradientVector vector;
    [self getValue:&vector];
    return vector;
}

@end

@implementation UILabel (Gradient)

- (void)addGradientColors:(NSArray<UIColor *> *)colors
                intervals:(NSArray<NSNumber *> *)intervals
                  vectors:(NSArray<NSValue *> *)vectors{
    [self addGradientColors:colors intervals:intervals vectors:vectors hideen:YES];
}

- (void)addGradientColors:(NSArray<UIColor *> *)colors
                intervals:(NSArray<NSNumber *> *)intervals
                  vectors:(NSArray<NSValue *> *)vectors
                   hideen:(BOOL)hidden{
    [self addGradientColors:colors intervals:intervals vectors:vectors hideen:hidden finishBlock:NULL];
}


__weak UIView *__superView;
static NSUInteger __animationStep = 0;
static BOOL __hiddenWhenFinish;
static CGRect __labelFrame;
static XGradientFinishBlock __finishBlock;

NSArray<UIColor *>  *__colorsArray;
NSArray<NSValue *>  *__vectorsArray;
NSArray<NSNumber *> *__intervalsArray;

- (void)addGradientColors:(NSArray<UIColor *> *)colors
                intervals:(NSArray<NSNumber *> *)intervals
                  vectors:(NSArray<NSValue *> *)vectors
                   hideen:(BOOL)hidden
              finishBlock:(XGradientFinishBlock)block{
    
    __superView      = self.superview;
    __labelFrame     = self.frame;
    __colorsArray    = colors;
    __intervalsArray = intervals;
    __vectorsArray   = vectors;
    
    __hiddenWhenFinish = hidden;
    if (block) {
        __finishBlock = block;
    }
    [self step:__animationStep];
}



- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    if (!flag) {
        return;
    }
    
    [__superView addSubview:self];
    self.textColor = __presentingColor;
    
    [__gradientLayer removeAllAnimations];
    [__gradientLayer removeFromSuperlayer];
    __gradientLayer = nil;
    
    if ((++__animationStep) > (__colorsArray.count-1)) {
        
        if (__hiddenWhenFinish) {
            [UIView animateWithDuration:0.8 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                self.alpha = 0.0f;
            } completion:^(BOOL finished) {
                __colorsArray    = nil;
                __intervalsArray = nil;
                __vectorsArray   = nil;
                __animationStep  = 0;
                if (__finishBlock) {
                    __finishBlock();
                }
            }];
            
        }else{
            __colorsArray    = nil;
            __intervalsArray = nil;
            __vectorsArray   = nil;
            __animationStep  = 0;
            if (__finishBlock) {
                __finishBlock();
            }
        }
    }else{
        [self step:__animationStep];
    }
}

#pragma mark 添加动画图层
__weak static UIColor *__presentingColor;
static CAGradientLayer *__gradientLayer;

- (void)step:(NSUInteger)index{
    __strong typeof(__superView) strongSuperView = __superView;
    __presentingColor = __colorsArray[index];
    
    
    __gradientLayer = [CAGradientLayer layer];
    __gradientLayer.colors = @[(__bridge id)__presentingColor.CGColor,(__bridge id)self.textColor.CGColor];
    
    GradientVector vector = [__vectorsArray[index] gradientVectorValue];

    __gradientLayer.startPoint = vector.start;
    __gradientLayer.endPoint   = vector.end;
    __gradientLayer.locations = @[@(0),@(0)];
    __gradientLayer.frame = __labelFrame;
    [strongSuperView.layer addSublayer:__gradientLayer];
    __gradientLayer.mask = self.layer;
    self.frame = __gradientLayer.bounds;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"locations"];
    animation.toValue = @[@(1),@(1)];
    animation.duration = [__intervalsArray[index] doubleValue];
    animation.delegate = self;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    [__gradientLayer addAnimation:animation forKey:@"locationsAnimation"];
}


@end
