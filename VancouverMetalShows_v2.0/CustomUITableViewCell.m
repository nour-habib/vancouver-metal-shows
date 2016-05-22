//
//  CustomUITableViewCell.m
//  VancouverMetalShows_v2.0
//
//  Created by Nour on 2016-05-22.
//  Copyright © 2016 Nour. All rights reserved.
//

#import "CustomUITableViewCell.h"

@interface CustomUITableViewCell()
@property (strong, nonatomic) IBOutlet UILabel *artistLabel;
@property (strong, nonatomic) IBOutlet UILabel *supportArtistLabel;
@property (strong, nonatomic) IBOutlet UILabel *venueLabel;

@end

@implementation CustomUITableViewCell

- (void)awakeFromNib {
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

- (void)setup {
    self.artistLabel.text = self.showModel.artist;
    self.supportArtistLabel.text = self.showModel.supportingArtists;
    self.venueLabel.text = self.showModel.venue;
}

@end
