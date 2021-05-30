//
//  FavShowTableViewCell.m
//  VancouverMetalShows_v2.0
//
//  Created by Nour Habib on 2021-05-21.
//  Copyright © 2021 Nour. All rights reserved.
//

#import "FavShowTableViewCell.h"

@interface FavShowTableViewCell()

@property (strong,nonatomic) IBOutlet UILabel *artLabel;
@property (strong,nonatomic)IBOutlet UILabel *venLabel;
@property (strong, nonatomic) IBOutlet UILabel *dtLabel;


@end

@implementation FavShowTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setShowModel:(ShowModel *)showModel {
    _showModel = showModel;
    [self setup];
}

-(void)setup
{
    self.artLabel.text = self.showModel.artist;
    self.dtLabel.text = self.showModel.date;
    self.venLabel.text = self.showModel.venue;
}

@end
