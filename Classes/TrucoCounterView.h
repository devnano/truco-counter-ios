//
//  TrucoCounterView.h
//  TrucoCounter
//
//  Created by Mariano Heredia on 2/18/09.
//  Copyright 2009 Eglu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FivePointsView.h"
#define MASTER_SPRITE_X 250.0;
#define MASTER_SPRITE_Y 350.0;
#define SHADOW_OFFSET_X -3;
#define SHADOW_OFFSET_Y 3;





@interface TrucoCounterView : UIView {
	CGPoint lastTouch;
	UIImage *horizontalSprite;
	UIImage *verticalSprite;
	UIImage *diagonalSprite;
	UIImage *masterSprite;
//	CGPoint spriteInitPoint;
	BOOL draggingSprite;
	CGRect redrawRect;
	CGPoint touchOffset;
	//NSInteger aTeamPoints;
	NSMutableArray *aTeamPoints;
	NSInteger aPoints;
	NSInteger bPoints;
//	FivePointsView *view;
	//FivePointsView   *aTeamPoints;
}

@property CGPoint lastTouch;
@property CGRect redrawRect;
@property (nonatomic, retain) UIImage *horizontalSprite;
@property (nonatomic, retain) UIImage *verticalSprite;
@property (nonatomic, retain) UIImage *diagonalSprite;
@property (nonatomic, retain) UIImage *masterSprite;
@property (readonly) CGPoint spriteInitPoint;
@property BOOL draggingSprite;
@property CGPoint touchOffset;
@property NSInteger aPoints;
@property NSInteger bPoints;
@property (readonly) NSMutableArray *aTeamPoints;



//+ (CGPoint) getDrawPoint:(CGSize) size  point: (CGPoint) point;
- (BOOL) touchedInsideMasterSprite:(CGPoint) touchPoint;


@end
