//
//  Car.h
//  LWCoreData
//
//  Created by liwei on 16/11/9.
//  Copyright © 2016年 winchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject

/** 所有者ID */
@property (nonatomic, copy) NSString * ownID;
/** 车的ID */
@property (nonatomic, copy) NSString * carID;
/** 车的品牌 */
@property (nonatomic, copy) NSString * brand;
/** 车的价格 */
@property (nonatomic, copy) NSString * price;

@end
