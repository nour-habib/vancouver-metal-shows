//
//  MapView.m
//  VancouverMetalShows_v2.0
//
//  Created by Nour Habib on 2021-07-08.
//  Copyright © 2021 Nour. All rights reserved.
//

#import "MapView.h"
@import MapKit;

@interface MapView ()

@property (nonatomic, strong) MKMapView *mapView;

@end

@implementation MapView


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    //self.backgroundColor = [UIColor redColor];
    self.mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
  
    
    return self;
}

- (id)initWithCoder:(NSCoder*)aDecoder
{
    self = [super initWithCoder:aDecoder];

    return self;
}

- (void) showMap:(NSString *) venue
{
    if (self.mapView == nil)
    {
        NSLog(@"mapvie nil");
    }
    NSLog(@"location: %@",venue);
    CLGeocoder *clg = [[CLGeocoder alloc]init];
    [clg geocodeAddressString:venue completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error)
    {
        if(placemarks.count >0)
        {
            CLPlacemark *result = [placemarks firstObject];
            NSLog(@"clp name: %@",result.name);
            NSLog(@"clp first: %@",result.postalAddress);
            MKPlacemark *placemark = [[MKPlacemark alloc]initWithPlacemark:result];
            MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(placemark.coordinate, 5000, 5000);
            NSLog(@"coord: %f", placemark.coordinate.latitude);
           
            [self.mapView setRegion: region animated: NO];
            [self.mapView addAnnotation:placemark];
            
        }
    }];
}

@end
