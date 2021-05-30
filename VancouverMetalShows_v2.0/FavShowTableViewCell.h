//
//  FavShowTableViewCell.h
//  VancouverMetalShows_v2.0
//
//  Created by Nour Habib on 2021-05-21.
//  Copyright © 2021 Nour. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ShowModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FavShowTableViewCell : UITableViewCell

@property(strong,nonatomic) ShowModel *showModel;

@end

NS_ASSUME_NONNULL_END
