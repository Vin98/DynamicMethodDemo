//
//  LLAutoDictionary.h
//  DynamicMethodDemo
//
//  Created by 李佳乐 on 2018/12/26.
//  Copyright © 2018 Jiale Li. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLAutoDictionary : NSObject
@property (nonatomic, copy) NSString *string;
@property (nonatomic, strong) NSNumber *number;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) id opaqueObject;

@end

NS_ASSUME_NONNULL_END
