//
//  LLAutoDictionary.m
//  DynamicMethodDemo
//
//  Created by 李佳乐 on 2018/12/26.
//  Copyright © 2018 Jiale Li. All rights reserved.
//

#import "LLAutoDictionary.h"
#import "LLPerson.h"
#import <objc/runtime.h>

@interface LLAutoDictionary()

@property (nonatomic, strong) NSMutableDictionary *backingStore;
@end

@implementation LLAutoDictionary

@dynamic string, number, date, opaqueObject;

- (instancetype)init
{
    self = [super init];
    if (self) {
        _backingStore = [NSMutableDictionary new];
    }
    return self;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSString *selectorString = NSStringFromSelector(sel);
    if ([selectorString hasPrefix:@"set"]) {
        class_addMethod(self, sel, (IMP)autoDictionarySetter, "v@:@");
        //return YES;
    } else {
        //class_addMethod(self, sel, (IMP)autoDictionaryGetter, "@@:");
        //return NO;
    }
    return NO;
}

id autoDictionaryGetter(id self, SEL _cmd) {
    //get the backing store from the object
    LLAutoDictionary *typedSelf = (LLAutoDictionary *)self;
    NSMutableDictionary *backingStore = typedSelf.backingStore;
    
    //the key is simply the selector name
    NSString *key = NSStringFromSelector(_cmd);
    
    //return the value
    return [backingStore objectForKey:key];
}

void autoDictionarySetter(id self, SEL _cmd, id value) {
    LLAutoDictionary *typedSelf = (LLAutoDictionary *)self;
    NSMutableDictionary *backingStore = typedSelf.backingStore;
    
    //处理_cmd来得到key:例如_cmd为:"setString:"则要得到"string"
    NSString *selectorString = NSStringFromSelector(_cmd);
    
    //去掉结尾:
    NSMutableString *key = [selectorString mutableCopy];
    [key deleteCharactersInRange:NSMakeRange(key.length - 1, 1)];
    
    //去掉前缀set
    [key deleteCharactersInRange:NSMakeRange(0, 3)];
    
    //将key首字母转为小写
    NSString *lowercaseFirstChar = [[key substringToIndex:1] lowercaseString];
    [key replaceCharactersInRange:NSMakeRange(0, 1) withString:lowercaseFirstChar];
    
    if (value) {
        [backingStore setObject:value forKey:key];
    } else {
        [backingStore removeObjectForKey:key];
    }
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    //return nil;
    return [LLPerson new];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    //判断aSelector是否为需要转发的，如果是则手动生成签名并返回
    NSString *selectorString = NSStringFromSelector(aSelector);
    if ([selectorString hasPrefix:@"set"]) {
        // setter方法需要转发
        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    } else {
        //getter方法不做处理
        
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSString *selectorString = NSStringFromSelector(anInvocation.selector);
    if ([selectorString hasPrefix:@"set"]) {
        NSLog(@"setter 方法被转发");
        void *argBuf = NULL;
        NSUInteger numberOfArguments = anInvocation.methodSignature.numberOfArguments;
        for (int idx = 0; idx < numberOfArguments; idx++) {
            const char * type = [anInvocation.methodSignature getArgumentTypeAtIndex:idx];
            NSUInteger argSize;
            NSGetSizeAndAlignment(type, &argSize, NULL);
            if (!(argBuf = reallocf(argBuf, argSize))) {
                NSLog(@"Failed to allocate memory for block invocation.");
                return ;
            }
            [anInvocation getArgument:argBuf atIndex:idx];
        }
        //可对参数进行处理
    } else {
        //不做处理
    }
}

@end
