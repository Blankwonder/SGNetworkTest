//
//  ResizeCell.h
//  Surge-iOS
//
//  Created by Blankwonder on 1/11/16.
//  Copyright © 2016 Yach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResizeCell : UITableViewCell

+ (ResizeCell *)cell;

@property (nonatomic) IBOutlet UILabel *label;

@end
