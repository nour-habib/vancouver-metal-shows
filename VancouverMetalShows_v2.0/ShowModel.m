//
//  ShowModel.m
//  VancouverMetalShows_v2.0
//
//  Created by Nour on 2016-05-01.
//  Copyright © 2016 Nour. All rights reserved.
//

#import "ShowModel.h"

@implementation ShowModel

-(instancetype) initWithArtist:(NSString *)artist withDate: (NSString *)date withVenue:(NSString *)venue withSupportingArtists:(NSString *) supportingArtists withTickets:(NSString*) tickets {
    self = [super init];
    if (self){
        _artist = artist;
        _date = date;
        _venue = venue;
        _supportingArtists = supportingArtists;
        _tickets = tickets;
        
    }
    
    return self;
}

@end
