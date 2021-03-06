//
//  AppDelegate.m
//  APNSNotify
//
//  Created by vtec on 5/11/17.
//  Copyright © 2017 vtec. All rights reserved.
//

#import "AppDelegate.h"
#import <AWSSNS/AWSSNS.h>
#import <AWSCore/AWSCore.h>
#import <AWSCognito/AWSCognito.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
   if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * error) {
            if (!error){
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            }
        }];
    }else{
        UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
        //        [[UIApplication sharedApplication] registerForRemoteNotifications];
        //        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil]];
    }
    
    NSString *msg = [NSString stringWithFormat:@"%@", launchOptions];
    NSLog(@"lanch %@",msg);
    
//    AWSCognitoCredentialsProvider *credentialsProvider = [[AWSCognitoCredentialsProvider alloc]
//                                                          initWithRegionType:region
//                                                          identityPoolId:@"poolID"];
//    
//    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:region credentialsProvider:credentialsProvider];
//    
//    [AWSServiceManager defaultServiceManager].defaultServiceConfiguration = configuration;
    return YES;
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(nonnull NSData *)deviceToken{
    NSString *token = [NSString stringWithFormat:@"%@", deviceToken];
    
    NSLog(@"My token is:%@", token);
    
    NSString *arn = @"arn";
    AWSSNSCreatePlatformEndpointInput *platformEndpointRequest = [AWSSNSCreatePlatformEndpointInput new];
    platformEndpointRequest.customUserData = @"MyUserID";
    platformEndpointRequest.token = [self deviceTokenAsString:deviceToken];
    platformEndpointRequest.platformApplicationArn = arn;
    
    AWSSNS *sns = [AWSSNS defaultSNS];
    [[[sns createPlatformEndpoint:platformEndpointRequest] continueWithSuccessBlock:^id (AWSTask<AWSSNSCreateEndpointResponse *> *t) {
        AWSSNSCreateEndpointResponse *respose = t.result;
        NSLog(@"END POINT %@", respose.endpointArn);
        AWSSNS *sns = [AWSSNS defaultSNS];
    [[[sns createPlatformEndpoint:platformEndpointRequest] continueWithSuccessBlock:^id (AWSTask<AWSSNSCreateEndpointResponse *> *t) {
        AWSSNSCreateEndpointResponse *respose = t.result;
        NSLog(@"END POINT %@", respose.endpointArn);
        AWSSNSSubscribeInput *subscribeRequst = [AWSSNSSubscribeInput new];
        subscribeRequst.endpoint = respose.endpointArn;
        subscribeRequst.protocols = @"application";
        subscribeRequst.topicArn = @"arn";
        return [sns subscribe:subscribeRequst];
    }] continueWithBlock:^id (AWSTask * t) {
        if (t.cancelled) {
            NSLog(@"Task cancelled");
        }else if(t.error){
            NSLog(@"Error occurred: %@", t.error);
        }else{
            AWSSNSCreateEndpointResponse *respose = t.result;

            NSLog(@"Success");
        }
        return nil;
    }];

        return nil;
    }] continueWithBlock:^id (AWSTask * t) {
        if (t.cancelled) {
            NSLog(@"Task cancelled");
        }else if(t.error){
            NSLog(@"Error occurred: %@", t.error);
        }else{

            NSLog(@"Success");
        }
        return nil;
    }];

}

- (NSString *)deviceTokenAsString:(NSData*)deviceTokenData{
    NSString *rawDeviceString = [NSString stringWithFormat:@"%@", deviceTokenData];
    NSString *noSpaces = [rawDeviceString stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *tmp1 = [noSpaces stringByReplacingOccurrencesOfString:@"<" withString:@""];
    return [tmp1 stringByReplacingOccurrencesOfString:@">" withString:@""];
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error{
    NSLog(@"Failed to register with error : %@", error);
}

//< ios 8.0
//only can be notified when app is in background

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    NSLog(@"receive %@", userInfo[@"aps"][@"alert"]);
    
    completionHandler(UIBackgroundFetchResultNewData);
}

// > ios 8.0
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    NSLog(@"NO Response User Info: %@", response);
    NSLog(@"NO Response User Info: %@", response.notification.request.content.userInfo);
    completionHandler();
    [self handleRemoteNotification:[UIApplication sharedApplication] userInfo:response.notification.request.content.userInfo];
}

-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSLog(@"User Info: %@", notification.request.content);
    NSLog(@"User Info: %@", notification.request.content.userInfo);
    completionHandler(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge);
    [self handleRemoteNotification:[UIApplication sharedApplication] userInfo:notification.request.content.userInfo];
}

- (void) handleRemoteNotification:(UIApplication *)application userInfo:(NSDictionary *)remoteNotif{
    NSLog(@"Handle Remote Notification Dict: %@", remoteNotif);
    //hanle click of the push notification from here
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
