//
//  ESEntry.h
//  Entries
//
//  Created by Zack Lounsbury on 9/20/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ESEntry : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *note;
@property (nonatomic, strong) NSDate *timeStamp;

-(NSDictionary *)entryToDictionary;
-(id)initWithDictionary:(NSDictionary *)dictionary;

@end
