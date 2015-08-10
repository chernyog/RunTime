//
//  ViewController.m
//  运行时演练
//
//  Created by apple on 15/8/4.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ViewController.h"
#import "Employee.h"
#import <objc/runtime.h>

#import "FileMD5Hash.h"
#import "NSString+Hash.h"

#define kFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"data.plist"]

@interface ViewController ()

@property (nonatomic, strong) Employee *employee; /**< 员工类 */

@end

@implementation ViewController

+ (void)load {
    [super load];
//    NSLog(@"cy =========== %s", __func__);
    
}

+ (void)initialize {
    [super initialize];
//    NSLog(@"cy =========== %s", __func__);
}

//+(NSString*)getFileMD5WithPath:(NSString*)path
//{
//    return (__bridge_transfer NSString *)FileMD5HashCreateWithPath((__bridge CFStringRef)path, FileHashDefaultChunkSizeForReadingData);
//}

#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // MD5
    NSDictionary *dict = @{
                           @"name" : @"ls",
                           @"age" : @18
                           };
    NSDictionary *oldDict = [NSDictionary dictionaryWithContentsOfFile:kFilePath];
    NSString *oldStr = [oldDict.description md5String];
    NSString *newStr = [dict.description md5String];
    NSLog(@"cy =========== %@", newStr);
//    BOOL result = [dict writeToFile:kFilePath atomically:YES];
//    if (result) {
//        NSLog(@"写入成功！");
//    } else {
//        NSLog(@"写入失败！");
//    }
    
//    // 获取类的所有属性
//    [self getAllProperties];
//    // 给类的私有属性赋值
//    [self setValueForPrivateProperty];
    
    // 获取Employee的属性
    NSLog(@"cy =========== %@", self.employee);
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([Employee class], &count);
    if (count == 0) return;
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        // 属性名
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        NSLog(@"cy ======== propertyName = %@", propertyName);
        Ivar ivar = class_getInstanceVariable([self.employee class], [propertyName UTF8String]);
        if (ivar == nil) {
            ivar = class_getInstanceVariable([self.employee class], [[NSString stringWithFormat:@"_%@",propertyName] UTF8String]);
        }
        // 取值
        id propertyVal = object_getIvar(self.employee, ivar);
        NSLog(@"cy ======== propertyVal = %@", propertyVal);
    }
    free(properties);
}

#pragma mark - 懒加载
- (Employee *)employee
{
    if (_employee == nil)
    {
        _employee = [[Employee alloc]init];
        _employee.name = @"张三";
        _employee.age = 18;
    }
    return _employee;
}

#pragma mark - 私有方法

#pragma mark - 给类的私有属性赋值
/**
 *  给类的私有属性赋值
 */
- (void)setValueForPrivateProperty {
    NSLog(@"/******************************* 华丽的分割线 *******************************/");
    unsigned int count = 0;
    Ivar *vars = class_copyIvarList([Employee class], &count);
    if (count == 0) return;
    for (int i = 0; i < count; i++) {
        Ivar var = vars[i];
        // 属性名
        const char *name = ivar_getName(var);
        // 属性类型
        const char *type = ivar_getTypeEncoding(var);
        NSLog(@"属性名：%s     类型：%s", name, type);
    }
    
    // 赋值前：
    NSLog(@"cy ======== 赋值前：%@", self.employee);
    object_setIvar(self.employee, vars[0], @"男");
    object_setIvar(self.employee, vars[1], @"湖北十堰");
    // 赋值后：
    NSLog(@"cy ======== 赋值后：%@", self.employee);
    free(vars);
}

#pragma mark - 获取类的所有属性
/**
 *  获取类的所有属性
 */
- (void)getAllProperties {
    // 获取Employee的所有属性
    unsigned int count = 0;
    Ivar *properties = class_copyIvarList([Employee class], &count);
    if (count == 0) return;
    for (int i = 0; i < count; i++) {
        Ivar var = properties[i];
        // 属性名
        const char *name = ivar_getName(var);
        // 属性类型
        const char *type = ivar_getTypeEncoding(var);
        NSLog(@"成员变量名：%s     类型：%s", name, type);
    }
    free(properties);
}

@end
