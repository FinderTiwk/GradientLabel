//
//  UILabel+Gradient.h
//  GradientLabel
//
//  Created by _Finder丶Tiwk on 16/7/28.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import <UIKit/UIKit.h>

/*! 颜色渐变方向向量*/
struct GradientVector {
    CGPoint start;  /**< 向量起点*/
    CGPoint end;    /**< 向量终点*/
};
typedef struct GradientVector GradientVector;
CG_INLINE GradientVector GradientVectorMake(CGFloat x0,CGFloat y0,CGFloat x1,CGFloat y1){
    GradientVector vector;
    vector.start = CGPointMake(x0, y0);
    vector.end   = CGPointMake(x1, y1);
    return vector;
}

@interface NSValue (GradientVector)
+ (NSValue *)valueWithVector:(GradientVector)vector;
- (GradientVector)gradientVectorValue;

@end



@interface UILabel (Gradient)

/*! 动画完成后的回调*/
typedef void(^XGradientFinishBlock)();


/*!
 *  @author _Finder丶Tiwk, 16-07-28 18:07:06
 *
 *  @brief 为UILabel添加颜色渐变动画效果
 *  @param colors    渐变的UIColor数组
 *  @param intervals 每次渐变的时长
 *  @param vectors   每次渐变的方向向量
 *  @param hidden    渐变结束后Label是否隐藏(0.8秒内alpha变为0)
 *  @param block     渐变完成后的回调
 *  @since v1.1.0
 */

- (void)addGradientColors:(NSArray<UIColor *> *)colors
                intervals:(NSArray<NSNumber *> *)intervals
                  vectors:(NSArray<NSValue *> *)vectors;


- (void)addGradientColors:(NSArray<UIColor *> *)colors
                intervals:(NSArray<NSNumber *> *)intervals
                  vectors:(NSArray<NSValue *> *)vectors
                   hideen:(BOOL)hidden;

- (void)addGradientColors:(NSArray<UIColor *> *)colors
                intervals:(NSArray<NSNumber *> *)intervals
                  vectors:(NSArray<NSValue *> *)vectors
                   hideen:(BOOL)hidden
              finishBlock:(XGradientFinishBlock)block;



@end
