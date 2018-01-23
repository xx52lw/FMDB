//
//  Person.h
//  LWCoreData
//
//  Created by liwei on 16/11/9.
//  Copyright © 2016年 liwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

/** 人的ID */
@property (nonatomic, copy) NSString * userID;
/** 人的姓名 */
@property (nonatomic, copy) NSString * name;
/** 性别 */
@property (nonatomic, copy) NSString * sex;
/** 人的车辆 */
@property (nonatomic, strong) NSMutableArray   * carArray;

@end
