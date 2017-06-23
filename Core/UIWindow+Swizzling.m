//
//  UIWindow+Swizzling.m
//  HyperionCore
//
//  Created by Chris Mays on 6/23/17.
//  Copyright © 2017 WillowTree. All rights reserved.
//

#import "UIWindow+Swizzling.h"
#import <objc/runtime.h>

@implementation UIWindow (Swizzling)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];

        SEL originalSelector = @selector(makeKeyWindow);
        SEL swizzledSelector = @selector(xxx_makeKeyWindow);

        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);

        // When swizzling a class method, use the following:
        // Class class = object_getClass((id)self);
        // ...
        // Method originalMethod = class_getClassMethod(class, originalSelector);
        // Method swizzledMethod = class_getClassMethod(class, swizzledSelector);

        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));

        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

-(void)xxx_makeKeyWindow
{
    [self xxx_makeKeyWindow];

    HYPDebuggingWindow *window = [[HYPDebuggingWindow alloc] initWithFrame:[[[UIApplication sharedApplication] keyWindow] frame]];
    [[[UIApplication sharedApplication] keyWindow] addGestureRecognizer:window.panGesture];
    objc_setAssociatedObject(self, @selector(debugWindow), window, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(HYPDebuggingWindow *)debugWindow
{
    return objc_getAssociatedObject(self, @selector(debugWindow));
}

@end
