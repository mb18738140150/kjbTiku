//
//  AnswersCardViewController.h
//  Accountant
//
//  Created by aaa on 2017/3/30.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SubmitBlock)();

@interface AnswersCardViewController : UIViewController

- (void)submiteBlock:(SubmitBlock)block;

@end
