//
//  TrucoCounterViewController.h
//  TrucoCounter
//
//  Created by Mariano Heredia on 2/18/09.
//  Copyright Eglu 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrucoCounterView.h"

@interface TrucoCounterViewController : UIViewController<UIAlertViewDelegate> {
//	IBOutlet UIImageView *pointSprite;
//	IBOutlet UILabel *messageLabel;
	IBOutlet UILabel *aPointsLabel;
	IBOutlet UILabel *bPointsLabel;
	TrucoCounterView *trucoCounterView;

}

//@property (nonatomic, retain) UIImageView *pointSprite;

@property(nonatomic, retain) TrucoCounterView *trucoCounterView;
//@property(nonatomic, retain) UILabel *messageLabel;
- (IBAction) decrementAPoints;
- (IBAction) decrementBPoints;
- (void) reset;

@end

