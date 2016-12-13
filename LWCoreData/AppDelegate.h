//
//  AppDelegate.h
//  LWCoreData
//
//  Created by liwei on 16/11/9.
//  Copyright © 2016年 winchannel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

