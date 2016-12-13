//
//  DataBase.m
//  LWCoreData
//
//  Created by liwei on 16/11/9.
//  Copyright © 2016年 winchannel. All rights reserved.
//

#import "DataBase.h"
#import <FMDB.h>
#import "Car.h"
#import "Person.h"
@interface DataBase()

@property (nonatomic, strong) FMDatabase   * db;

@end
@implementation DataBase

/** 共享单例 */
+ (instancetype)sharedDataBase {
    static DataBase *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DataBase alloc] init];
        [instance initDataBase];
    });
    return instance;
}

#pragma mark 创建数据库
- (void)initDataBase {
    // 获取Documents目录路径
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 文件路径
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"model.sqlite"];
    self.db = [FMDatabase databaseWithPath:filePath];
    // 打开数据库，如果不存在就创建并打开
    bool open = [self.db open];
    if (open) {
        NSLog(@"打开数据库成功");
    }
    // 
    NSString *carSql = @"CREATE TABLE 'car'('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'ownID' VARCHAR(255),'carID' VARCHAR(255),'brand' VARCHAR(255),'price' VARCHAR(255))";
   bool carBool = [self.db executeUpdate:carSql];
    if (carBool) {
        NSLog(@"创建car表成功");
    }
    NSString *personSql = @"CREATE TABLE 'person'('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'userID' VARCHAR(255),'name' VARCHAR(255),'sex' VARCHAR(255))";
   bool personBool = [self.db executeUpdate:personSql];
    if (personBool) {
        NSLog(@"创建person表成功");
    }
    // 关闭数据库
    [self.db close];
}

/** 为表添加字段 */
- (void)tableName:(NSString *)table column:(NSString *)column {
    [self.db open];
    
    if ([self.db columnExists:column inTableWithName:table] == NO) {
        NSString *sql = [NSString stringWithFormat:@"ALTER TABLE %@ ADD COLUMN %@",table,column];
        [self.db executeUpdate:sql];
    }
    
    [self.db close];
}

/** 添加人 */
- (void)addPerson:(Person *)person {

    [self.db open];
    FMResultSet *res = [self.db executeQuery:@"SELECT * FROM person"];
    // 获取做大的ID
    NSInteger maxId = 0;
    while ([res next]) {
        if (maxId < [[res stringForColumn:@"userID"] integerValue]) {
            maxId = [[res stringForColumn:@"userID"] integerValue];
        }
    }
    maxId = maxId + 1;
    NSString *sql = @"INSERT INTO person(userID,name)VALUES(?,?)";
    [self.db executeUpdate:sql,[NSString stringWithFormat:@"%ld",(long)maxId],person.name];
    [self.db close];
    
}
/** 删除人 */
- (void)deletePerson:(Person *)person {

    [self.db open];
    
    NSString *sql = @"DELETE FROM 'person' WHERE name = ?";
    [self.db executeUpdate:sql,person.name];
    
    [self.db close];
    
}
/** 更新人 */
- (void)updatePerson:(Person *)person {
    [self.db open];
    
    NSString *sql = @"UPDATE 'person' SET sex = ?,userID = ? WHERE  name = ?";
    [self.db executeUpdate:sql,person.sex,person.userID,person.name];
    
    [self.db close];

}
/** 查询人 */
- (NSArray *)selectPerson:(Person *)person {
    [self.db open];
    NSMutableArray *arr = [NSMutableArray array];
    FMResultSet *res = [self.db executeQuery:@"SELECT * FROM person WHERE name = ?",person.name];
    while ([res next]) {
        Person *person = [[Person alloc] init];
        person.userID = [res stringForColumn:@"userID"];
        person.name   = [res stringForColumn:@"name"];
        [arr addObject:person];
    }
    return [NSArray arrayWithArray:arr];
}

/** 查询所有人 */
- (NSArray *)selectAllPerson {
    [self.db open];
    NSMutableArray *arr = [NSMutableArray array];
    FMResultSet *res = [self.db executeQuery:@"SELECT * FROM person"];
    while ([res next]) {
        Person *person = [[Person alloc] init];
        person.userID = [res stringForColumn:@"userID"];
        person.name   = [res stringForColumn:@"name"];
        [arr addObject:person];
    }
    return [NSArray arrayWithArray:arr];
}


/** 给人添加车 */
- (void)addCar:(Car *)car toPerson:(Person *)person {
    
    [self.db open];
    
    FMResultSet *res = [self.db executeQuery:@"SELECT * FROM car"];
    // 获取做大的ID
    NSInteger maxId = 0;
    while ([res next]) {
        if (maxId < [[res stringForColumn:@"carID"] integerValue]) {
            maxId = [[res stringForColumn:@"carID"] integerValue];
        }
    }
    maxId = maxId + 1;
    NSString *sql = @"INSERT INTO car(ownID,carID,brand,price) VALUES(?,?,?,?)";
    [self.db executeUpdate:sql,person.userID,[NSString stringWithFormat:@"%ld",(long)maxId],car.brand,car.price];
    
    [self.db close];

}
/** 给人删除车 */
- (void)deleteCar:(Car *)car fromPerson:(Person *)person {

}
/** 查询人的车 */
- (NSArray *)selectFromPerson:(Person *)person {
    [self.db open];
    NSMutableArray *arr = [NSMutableArray array];
    FMResultSet *res = [self.db executeQuery:@"SELECT * FROM car WHERE ownID = ?",person.userID];
    while ([res next]) {
        Car *car = [[Car alloc] init];
        car.carID = [res stringForColumn:@"carID"];
        car.ownID = [res stringForColumn:@"ownID"];
        car.brand = [res stringForColumn:@"brand"];
        car.price = [res stringForColumn:@"price"];
        [arr addObject:car];
    }
    return [NSArray arrayWithArray:arr];
}
/** 删除人的车 */
- (void)deleteAllCarFromPerson:(Person *)person {

}


@end
