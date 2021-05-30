//
//  ShowTableViewCell.m
//  VancouverMetalShows_v2.0
//
//  Created by Nour Habib on 2021-05-02.
//  Copyright © 2021 Nour. All rights reserved.
//

#import "ShowTableViewCell.h"


@interface ShowTableViewCell()

@property (strong, nonatomic) IBOutlet UILabel *artistLabel;
@property (strong, nonatomic) IBOutlet UILabel *venueLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
//@property (strong,nonatomic) IBOutlet UIImageView *artistImageView;
@property (strong,nonnull) IBOutlet UITextView *dateTextView;


@end

@implementation ShowTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //NSLog(@"setup");
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
    //self.dateLabel.text = self.showModel.date;
    self.venueLabel.text = self.showModel.venue;
    self.artistImageView.image = [UIImage imageNamed:self.showModel.artist];
    
   //self.artistImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",@"images/",self.showModel.artist]];
    self.dateTextView.text = self.showModel.date;
    
}

@end
