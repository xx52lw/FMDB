//
//  DataBase.h
//  LWCoreData
//
//  Created by liwei on 16/11/9.
//  Copyright © 2016年 winchannel. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Car;
@class Person;

@interface DataBase : NSObject

/** 共享单例 */
+ (instancetype)sharedDataBase;

/** 为表添加字段 */
- (void)tableName:(NSString *)table column:(NSString *)column;

/** 添加人 */
- (void)addPerson:(Person *)person;
/** 删除人 */
- (void)deletePerson:(Person *)person;
/** 更新人 */
- (void)updatePerson:(Person *)person;
/** 查询人 */
- (NSArray *)selectPerson:(Person *)person;
/** 查询所有人 */
- (NSArray *)selectAllPerson;

/** 给人添加车 */
- (void)addCar:(Car *)car toPerson:(Person *)person;
/** 给人删除车 */
- (void)deleteCar:(Car *)car fromPerson:(Person *)person;
/** 查询人的车 */
- (NSArray *)selectFromPerson:(Person *)person;
/** 删除人的车 */
- (void)deleteAllCarFromPerson:(Person *)person;

@end
