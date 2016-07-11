//
//  ObjCCall.m
//  Classic Trek
//
//  Created by Apple Guy on 7/9/16.
//  Copyright © 2016 Pocketfiction. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "ObjCCall.h"
#import "LinkCtoSwift.h"

void ObjCCall::objectiveC_Call(const char *name)
{
//    //Objective C code calling.....
    LinkCtoSwift *obj=[[LinkCtoSwift alloc]init]; //Allocating the new object for the objective C   class we created
    NSString* log = [[NSString alloc] initWithCString:name encoding:NSUTF8StringEncoding];
    [obj hello:log];   //Calling the function we defined
}