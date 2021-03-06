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
    
    if (self.text != nil) {
        dictionary[@"note"] = self.text;
    }
    
    if (self.color != nil) {
        NSData *colorData = [NSKeyedArchiver archivedDataWithRootObject:self.color];
        dictionary[@"color"] = colorData;
    }
    
    /*
    if (self.timeStamp != nil) {
        dictionary[@"timestamp"] = self.timeStamp;
    }
    */
    
    return dictionary.copy;
}


-(id)initWithDictionary:(NSDictionary *)dictionary{
    
    self = [super init];
    if (self != nil) {
        
        //self.title = dictionary[@"title"]; // alternative method
        
        
        self.title = [dictionary objectForKey:@"title"];
        self.text = [dictionary objectForKey:@"note"];
        
        NSData *colorData = [dictionary objectForKey:@"color"];
        self.color = [NSKeyedUnarchiver unarchiveObjectWithData:colorData];
        
        //self.timeStamp = [dictionary objectForKey:@"timestamp"];
        
    }
    return self;
    
}

@end
