//
//  AppDelegate.m
//  MyApp
//
//  Created by Jinwoo Kim on 12/27/23.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    return YES;
}

- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    return [[[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role] autorelease];
}

@end
