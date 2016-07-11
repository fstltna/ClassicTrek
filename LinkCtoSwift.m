//
//  LinkCtoSwift.m
//  Classic Trek
//
//  Created by Apple Guy on 7/9/16.
//  Copyright © 2016 Pocketfiction. All rights reserved.
//

#import "LinkCtoSwift.h"

@implementation LinkCtoSwift

- (void) hello:(NSString*)num {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"status" object:nil userInfo:@{@"value":num}];
}

@end
