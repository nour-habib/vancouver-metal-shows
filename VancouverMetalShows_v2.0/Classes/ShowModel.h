//
//  ShowModel.h
//  VancouverMetalShows_v2.0
//
//  Created by Nour Habib on 2021-05-02.
//  Copyright © 2021 Nour. All rights reserved.

#import <Foundation/Foundation.h>

@interface ShowModel : NSObject

@property (strong, nonatomic) NSString *artist;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *venue;
@property (strong, nonatomic) NSString *supportingArtists;
@property (strong, nonatomic) NSString *tickets;
@property (strong,nonatomic) NSString *artistImage;


//returns instance of a class; use in place of id
-(instancetype) initWithArtist:(NSString *)artist withDate: (NSString *)date withVenue:(NSString *)venue withSupportingArtists:(NSString *) supportingArtists withTickets:(NSString*) tickets withImage:(NSString*)artistImage;

@end
