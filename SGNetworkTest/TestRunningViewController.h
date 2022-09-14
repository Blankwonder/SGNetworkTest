//
//  TextViewController.h
//  SGAdmin
//
//  Created by Blankwonder on 2021/11/24.
//

#import <UIKit/UIKit.h>
#import "TestObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestRunningViewController : UIViewController {
    IBOutlet UITextView *_textView;
}

- (instancetype)initWithTestObj:(TestObject *)obj;

@property (nonatomic, readonly) TestObject *testObject;

@end

NS_ASSUME_NONNULL_END
