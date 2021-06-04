//
//  DetailViewController.h
//  VancouverMetalShows_v2.0
//
//  Created by Nour Habib on 2021-05-02.
//  Copyright © 2021 Nour. All rights reserved.

#import <UIKit/UIKit.h>
#import "ShowModel.h"
@import Firebase;
#import <GoogleMaps/GoogleMaps.h>
#import "MainViewController.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) ShowModel *showModel;
@property (nonatomic, strong) IBOutlet UILabel *artistLabel;
@property (nonatomic, strong) IBOutlet UILabel *venueLabel;
@property (nonatomic, strong) IBOutlet UILabel *dateLabel;
@property (nonatomic,strong) IBOutlet UILabel *suppArtLabel;
@property (nonatomic, strong) IBOutlet UIImageView *artistImageview;
@property (nonatomic, strong) IBOutlet UIButton *addToFavsButton;
@property (nonatomic, strong) IBOutlet UIButton *shareButton;
@property(nonatomic,strong) IBOutlet UIButton *getTicketsButton;
@property (nonatomic,strong)IBOutlet UIView *buttonView;
@property (nonatomic, strong) IBOutlet UIView *headerView;

@property (nonatomic,strong) IBOutlet UILabel *lineupLabel;
@end

