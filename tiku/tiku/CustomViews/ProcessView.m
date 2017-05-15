//
//  ProcessView.m
//  tiku
//
//  Created by aaa on 2017/5/9.
//  Copyright © 2017年 ytx. All rights reserved.
//

#import "ProcessView.h"
#import "UIMacro.h"

@implementation ProcessView

-(void)setProgress:(CGFloat)progress{
    _progress = progress;
    
    CGPoint startP = CGPointMake(0, self.frame.size.height / 2);
    CGPoint endP = CGPointMake(self.progress * self.frame.size.width, self.frame.size.height / 2);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startP];
    [path addLineToPoint:endP];
    
    CAShapeLayer * layer = [[CAShapeLayer alloc]init];
    layer.frame = self.bounds;
    layer.lineWidth = self.frame.size.height;
    layer.path = path.CGPath;
    layer.strokeColor = kCommonMainColor.CGColor;
    [self.layer addSublayer:layer];
    
    CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    transformAnimation.duration = 1;
    transformAnimation.fromValue = @(0);
    transformAnimation.toValue = @(1);
    
    [layer addAnimation:transformAnimation forKey:nil];
    
    layer.strokeStart = 0;
    layer.strokeEnd = 1.0;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
