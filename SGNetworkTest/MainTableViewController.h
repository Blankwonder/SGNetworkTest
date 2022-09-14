//
//  MainTableViewController.h
//  Surge-Admin
//
//  Created by Blankwonder on 2021/11/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDActionCell : UITableViewCell

@property (nonatomic, copy) void (^action)(KDActionCell *cell, NSIndexPath *indexPath);
@property (nonatomic, copy) void (^deleteAction)(KDActionCell *cell, NSIndexPath *indexPath);
@property (nonatomic, copy) UIContextMenuActionProvider menuActionProvider;

@end

@interface MainTableViewController : UIViewController

@end

NS_ASSUME_NONNULL_END
