//
//  ShowTableViewCell.h
//  VancouverMetalShows_v2.0
//
//  Created by Nour Habib on 2021-05-02.
//  Copyright © 2021 Nour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowModel.h"


@interface ShowTableViewCell : UITableViewCell

@property(strong,nonatomic) ShowModel *showModel;
@property (strong,nonatomic) IBOutlet UIImageView *artistImageView;
@end
