//
//  CustomUITableViewCell.h
//  VancouverMetalShows_v2.0
//
//  Created by Nour on 2016-05-22.
//  Copyright © 2016 Nour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowModel.h"

@interface CustomUITableViewCell : UITableViewCell

@property (strong, nonatomic) ShowModel *showModel;

@end
