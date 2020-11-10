//
//  AppDelegate.m
//  SERichTextEditor
//
//  Created by wenchang on 2020/11/9.
//  Copyright © 2020 seeEmil. All rights reserved.
//

#import "AppDelegate.h"
#import "SEViewController.h"
//#import "SERichTextEditorViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    SEViewController *mainViewController = [[SEViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    nav.navigationBar.translucent = NO;
    self.window.rootViewController = nav;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
