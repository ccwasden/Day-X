//
//  ESEntry.m
//  Entries
//
//  Created by Zack Lounsbury on 9/20/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "ESEntry.h"

@implementation ESEntry

-(NSDictionary *)entryToDictionary {
    
    NSMutableDictionary * dictionary = [NSMutableDictionary new];
    
    if (self.title != nil) {
        //[dictionary setObject:self.title forKey:@"title"];
        dictionary[@"title"] = self.title;
    }
    
    if (self.note != nil) {
        dictionary[@"note"] = self.note;
    }
    
    if (self.timeStamp != nil) {
        dictionary[@"timestamp"] = self.timeStamp;
    }
    
    return dictionary;
}

-(id)initWithDictionary:(NSDictionary *)dictionary{
    
    self = [super init];
    if (self != nil) {
        
        //self.title = dictionary[@"title"];
        self.title = [dictionary objectForKey:@"title"];
        self.note = [dictionary objectForKey:@"note"];
        self.timeStamp = [dictionary objectForKey:@"timestamp"];
        
    }
    return self;
    
}

@end
