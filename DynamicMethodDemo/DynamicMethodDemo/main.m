//
//  main.m
//  DynamicMethodDemo
//
//  Created by 李佳乐 on 2018/12/26.
//  Copyright © 2018 Jiale Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLAutoDictionary.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        LLAutoDictionary *dic = [LLAutoDictionary new];
        dic.string = @"dic string";
        NSLog(@"dic.string = %@", dic.string);
    }
    return 0;
}
