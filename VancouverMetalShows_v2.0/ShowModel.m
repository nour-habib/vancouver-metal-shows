//
//  ShowModel.m
//  VancouverMetalShows_v2.0
//
//  Created by Nour on 2016-05-01.
//  Copyright © 2016 Nour. All rights reserved.
//

#import "ShowModel.h"

@implementation ShowModel

-(instancetype) initWithArtist:(NSString *)artist withDate: (NSString *)date withVenue:(NSString *)venue withSupportingArtists:(NSString *) supportingArtists withTickets:(NSString*) tickets withImage:(NSString*)artistImage {
    self = [super init];
    if (self){
        _artist = artist;
        _date = date;
        _venue = venue;
        _supportingArtists = supportingArtists;
        _tickets = tickets;
        _artistImage = artistImage;
        
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.artist forKey:@"ARTIST"];
    [aCoder encodeObject:self.date forKey:@"DATE"];
    [aCoder encodeObject:self.venue forKey:@"VENUE"];
    [aCoder encodeObject:self.supportingArtists forKey:@"SUP_ARTISTS"];
    [aCoder encodeObject:self.tickets forKey:@"TICKETS"];
    [aCoder encodeObject:self.artistImage forKey:@"IMAGE"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        self.artist = [aDecoder decodeObjectForKey:@"ARTIST"];
        self.date = [aDecoder decodeObjectForKey:@"DATE"];
        self.venue = [aDecoder decodeObjectForKey:@"VENUE"];
        self.supportingArtists = [aDecoder decodeObjectForKey:@"SUP_ARTISTS"];
        self.tickets = [aDecoder decodeObjectForKey:@"TICKETS"];
        self.artistImage = [aDecoder decodeObjectForKey:@"IMAGE"];
    }
    return self;
}

@end
