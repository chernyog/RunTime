//
//  Employee.m
//  运行时演练
//
//  Created by apple on 15/8/4.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "Employee.h"

@implementation Employee

- (NSString *)description
{
    return [NSString stringWithFormat:@"name:%@, age:%d, sex:%@, hometown:%@", self.name, self.age, _sex, _hometown];
}

- (void)doWork
{
    NSLog(@"%@ doWork!", self.name);
}

- (void)goHome
{
    NSLog(@"%@ goHome!", self.name);
}

@end
