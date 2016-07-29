//
//  ViewController.m
//  GradientLabel
//
//  Created by _Finder丶Tiwk on 16/7/28.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "ViewController.h"
#import "UILabel+Gradient.h"

#define RGBACOLOR(__r,__g,__b,__a) \
[UIColor colorWithRed:(__r)/255.0f green:(__g)/255.0f blue:(__b)/255.0f alpha:(__a)]
#define RGBCOLOR(__r,__g,__b)  RGBACOLOR(__r,__g,__b,1)


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation ViewController


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    NSValue *v1 = [NSValue valueWithVector:GradientVectorMake(0,1,0,0)];
    NSValue *v2 = [NSValue valueWithVector:GradientVectorMake(1,0,0,0)];
    NSValue *v3 = [NSValue valueWithVector:GradientVectorMake(0,1,1,0)];

    UIColor *c1 = RGBCOLOR(84, 84, 84);
    UIColor *c2 = RGBCOLOR(67, 145, 204);
    UIColor *c3 = RGBCOLOR(101, 204, 121);
    
    [_titleLabel addGradientColors:@[c1,c2,c3]
                         intervals:@[@(1.8),@(1.2),@(1.4)]
                           vectors:@[v1,v2,v3]
                            hideen:YES
                       finishBlock:^{
                           NSLog(@"渐变完成了");
                           [self imageAnimation];
    }];
    
}

- (void)imageAnimation{
    CGFloat delta     = 60;
    CGFloat radius    = _iconImageView.frame.size.width/2;
    CGFloat newRadius = radius + delta;
    CGPoint center    = _iconImageView.center;
    CGFloat x = center.x - newRadius;
    CGFloat y = center.y - newRadius;

    __weak typeof(self) weakRef = self;
    [UIView animateWithDuration:1.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        __strong typeof(weakRef) strongRef = weakRef;
        strongRef->_iconImageView.frame   = CGRectMake(x, y, 2*newRadius, 2*newRadius);
        strongRef->_iconImageView.alpha    = 0.4;
    } completion:^(BOOL finished) {
        
    }];
}

@end
