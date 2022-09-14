//
//  AppDelegate.m
//  KDIOSAppTemplate
//
//  Created by Blankwonder on 2021/11/10.
//

#import "AppDelegate.h"
#import "MainTableViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
#if TARGET_OS_MACCATALYST
    for (UIScene *scene in UIApplication.sharedApplication.connectedScenes) {
        if ([scene isKindOfClass:UIWindowScene.class]) {
            UIWindowScene *windowSecen = (id)scene;
            windowSecen.titlebar.titleVisibility = UITitlebarTitleVisibilityHidden;
        }
    }
#endif

    [[NSURLSession.sharedSession dataTaskWithURL:[NSURL URLWithString:@"https://www.apple.com"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    }] resume];

    MainTableViewController *vc = [[MainTableViewController alloc] init];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
