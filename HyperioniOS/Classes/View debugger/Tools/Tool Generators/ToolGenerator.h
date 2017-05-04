//
//  ToolGenerator.h
//  Hyperion
//
//  Created by Chris Mays on 5/3/17.
//  Copyright © 2017 WillowTree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToolGenerator : NSObject

@property (nonatomic) NSString *title;

-(instancetype)initWithTitle:(NSString *)title;

@end
