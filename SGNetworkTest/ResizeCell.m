//
//  ResizeCell.m
//  Surge-iOS
//
//  Created by Blankwonder on 1/11/16.
//  Copyright © 2016 Yach. All rights reserved.
//

#import "ResizeCell.h"

@implementation ResizeCell

+ (ResizeCell *)cell {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ResizeCell class]) owner:nil options:nil].firstObject;
}

@end
