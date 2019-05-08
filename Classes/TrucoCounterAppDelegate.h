//
//  TrucoCounterAppDelegate.h
//  TrucoCounter
//
//  Created by Mariano Heredia on 2/18/09.
//  Copyright Eglu 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TrucoCounterViewController;

@interface TrucoCounterAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    TrucoCounterViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet TrucoCounterViewController *viewController;

@end

