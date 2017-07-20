//
//  DebuggingWindow.h
//  WhatIsThatFont
//
//  Created by Chris Mays on 5/2/17.
//  Copyright © 2017 Willow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYPDebuggingWindow : UIWindow

+(HYPDebuggingWindow *)sharedInstance;

@property (nonatomic) UIEvent *lastEvent;
@property (nonatomic) UIView *highlightView;
@property (nonatomic) UIView *lastSelectedView;
@property (nonatomic) UITapGestureRecognizer *tapGesture;
@property (nonatomic) CGPoint start;
@property (nonatomic) CGPoint end;

@end
