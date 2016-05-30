//
//  AppDelegate.m
//  TestAppShare
//
//  Created by lieyunye on 5/26/16.
//  Copyright © 2016 lieyunye. All rights reserved.
//

#import "AppDelegate.h"
#import "AppShareHelper.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark -
#pragma mark Image view

#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_9_0
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation
{
//    NSData *data = [NSData dataWithContentsOfURL:url];
//    
//    NSLog(@"data +++++++ %@",data);
    
    NSLog(@"sourceApplication ++++++++++++++");
    
    return YES;
}

#else
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(nonnull NSDictionary<NSString *,id> *)options
{
    NSString *fileName = url.absoluteString.lastPathComponent;
    NSLog(@"application ++++++++++++++ %@",fileName);
    if (fileName) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *cacheDir = [paths objectAtIndex:0];
        NSString *filePath = [NSString stringWithFormat:@"%@/%@/%@",cacheDir,@"Inbox",fileName];
        
        FileType fileType = [AppShareHelper fileTypeWithFilePath:filePath];
        switch (fileType) {
            case FileTypeText:
                
                break;
            case FileTypeImage:
                break;
            case FileTypeMovie:
            {
                BOOL ret = [AppShareHelper checkFileIsMp4VideoFileWithFilePath:filePath];
                if (ret) {
                    [[NSUserDefaults standardUserDefaults] setObject:url.absoluteString.lastPathComponent forKey:@"fileName"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }else {
                    NSLog(@"不支持该格式");
                }
            }
                break;
            default:
                break;
        }
        

    }
    return YES;
}
#endif
@end
