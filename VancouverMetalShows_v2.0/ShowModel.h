//
//  ShowModel.h
//  VancouverMetalShows_v2.0
//
//  Created by Nour on 2016-05-01.
//  Copyright © 2016 Nour. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowModel : NSObject

@property (strong, nonatomic) NSString *artist;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *venue;
@property (strong, nonatomic) NSString *supporting_artists;
@property (strong, nonatomic) NSString *tickets;


//returns instance of a class; use in place of id
-(instancetype) initWithArtist:(NSString *)artist withDate: (NSString *)date withVenue:(NSString *)venue withSupportingArtists:(NSString *) supporting_artists withTickets:(NSString*) tickets;

@end
