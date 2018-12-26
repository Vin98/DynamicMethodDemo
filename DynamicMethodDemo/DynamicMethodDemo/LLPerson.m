//
//  LLPerson.m
//  DynamicMethodDemo
//
//  Created by 李佳乐 on 2018/12/26.
//  Copyright © 2018 Jiale Li. All rights reserved.
//

#import "LLPerson.h"

@implementation LLPerson

- (NSDate *)date {
    if (!_date) {
        _date = [NSDate date];
    }
    return _date;
}

- (NSString *)string {
    if (!_string) {
        _string = @"default string";
    }
    return _string;
}

- (NSNumber *)number {
    if (_number) {
        _number = [NSNumber numberWithInteger:100];
    }
    return _number;
}

@end
