//
//  TextViewController.m
//  SGAdmin
//
//  Created by Blankwonder on 2021/11/24.
//

#import "TestRunningViewController.h"

@interface TestRunningViewController () <TestObjectOutput>{
}

@end

@implementation TestRunningViewController

- (instancetype)initWithTestObj:(TestObject *)obj {
    self = [super init];
    
    _testObject = obj;
    obj.output = self;
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [_testObject start];
}

- (void)testObject:(TestObject *)obj hasNewOutput:(NSString *)line {
    [_textView.textStorage appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n", line] attributes:@{
        NSForegroundColorAttributeName: UIColor.labelColor,
#if TARGET_OS_MACCATALYST
        NSFontAttributeName: [UIFont fontWithName:@"SFMono-Regular" size:22]
#else
        NSFontAttributeName: [UIFont fontWithName:@"SFMono-Regular" size:15]
#endif
    }]];

    [self performSelector:@selector(scrollToBottom) withObject:nil afterDelay:0.1];
}

- (void)scrollToBottom {
    [_textView scrollRectToVisible:CGRectMake(0, _textView.contentSize.height - 1, 320, 1) animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
