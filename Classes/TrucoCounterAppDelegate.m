//
//  TrucoCounterAppDelegate.m
//  TrucoCounter
//
//  Created by Mariano Heredia on 2/18/09.
//  Copyright Eglu 2009. All rights reserved.
//

#import "TrucoCounterAppDelegate.h"
#import "TrucoCounterViewController.h"

@implementation TrucoCounterAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch
    window.rootViewController = viewController;
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
