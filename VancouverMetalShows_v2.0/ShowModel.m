//
//  ShowModel.m
//  VancouverMetalShows_v2.0
//
//  Created by Nour on 2016-05-01.
//  Copyright © 2016 Nour. All rights reserved.
//

#import "ShowModel.h"

@implementation ShowModel

-(instancetype) initWithArtist:(NSString *)artist withDate:(NSString *)date withVenue:(NSString *)venue{
    self = [super init];
    if (self){
        _artist = artist;
        _date = date;
        _venue = venue;
    }
    
    return self;
}

@end
