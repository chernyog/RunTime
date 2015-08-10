//
//  Employee.h
//  运行时演练
//
//  Created by apple on 15/8/4.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  员工类
 */
@interface Employee : NSObject
{
    NSString *_sex; /**< 性别 */
    NSString *_hometown; /**< 籍贯 */
}

@property (nonatomic, copy) NSString *name; /**< 姓名 */
@property (nonatomic, assign) int age; /**< 年龄 */

- (void)doWork; /**< 上班 */

@end
