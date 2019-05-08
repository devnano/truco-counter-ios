//
//  TrucoCounterView.m
//  TrucoCounter
//
//  Created by Mariano Heredia on 2/18/09.
//  Copyright 2009 Eglu. All rights reserved.
//

#import "TrucoCounterView.h"




@implementation TrucoCounterView
@synthesize lastTouch;
@dynamic horizontalSprite;
@dynamic verticalSprite;
@dynamic diagonalSprite;
@dynamic masterSprite;
@synthesize draggingSprite;
@synthesize redrawRect;
@synthesize touchOffset;
@synthesize aPoints;
@synthesize bPoints;
@dynamic aTeamPoints;
@dynamic spriteInitPoint;

//@synthesize spriteInitPoint;

+ (CGSize) getSizeWithShadow:(CGSize) size{
	
	NSInteger width =SHADOW_OFFSET_X;
	NSInteger height = SHADOW_OFFSET_Y;
	
	width = size.width + abs(width);
	height = size.height + abs(height);
	return CGSizeMake(width*1.5,height*1.5);
	
}

+ (CGPoint) getDrawPoint: (CGPoint) point offset:(CGPoint) offset{
	CGFloat horizontalOffset = offset.x;
	CGFloat verticalOffset = offset.y;
	
	CGPoint drawPoint = CGPointMake(point.x - horizontalOffset,
									point.y - verticalOffset);
	return drawPoint;
}

+ (CGRect) getDrawRect:(CGSize) size point: (CGPoint) point offset:(CGPoint) offset{
	CGPoint drawPoint = [TrucoCounterView getDrawPoint:point offset:offset];
	
	NSInteger shadow_offset_x = SHADOW_OFFSET_X;
	NSInteger shadow_offset_y = SHADOW_OFFSET_Y;

	
	CGSize sizeWithShadow = [TrucoCounterView getSizeWithShadow:size];
	
	return CGRectMake(drawPoint.x+shadow_offset_x*1.25, drawPoint.y-shadow_offset_y*1.25, sizeWithShadow.width, sizeWithShadow.height);
//	return CGRectMake(drawPoint.x, drawPoint.y, sizeWithShadow.width, sizeWithShadow.height);
}




- (UIImage *) masterSprite{
	if (masterSprite == nil){
		masterSprite = [[UIImage imageNamed:@"masterSprite.png"] retain];
	}
	return masterSprite;
}


- (UIImage *) horizontalSprite{
	if (horizontalSprite == nil){
		horizontalSprite = [[UIImage imageNamed:@"horizontal_pointSprite.png"] retain];
	}
	return horizontalSprite;
}
- (UIImage *) verticalSprite{
	if (verticalSprite == nil){
		verticalSprite = [[UIImage imageNamed:@"vertical_pointSprite.png"] retain];		
	}
	return verticalSprite;
}
- (UIImage *) diagonalSprite{
	if (diagonalSprite == nil){
		diagonalSprite = [UIImage imageNamed:@"diagonal_pointSprite.png"];		
	}
	return diagonalSprite;
}
- (CGPoint) spriteInitPoint{
	float x = [self bounds].size.width/2 - [self masterSprite].size.width/2;//MASTER_SPRITE_X;
	float y = MASTER_SPRITE_Y;	
	return CGPointMake(x, y);	
}

- (id) initWithCoder:(NSCoder*) coder
{
	if((self = [super initWithCoder:coder]))
	{
		//draggingSprite = NO;
/*		CGRect frame = CGRectMake(0, 0, 100, 100);
		FivePointsView *pointCount = [[FivePointsView alloc] initWithFrame:frame];
		[self insertSubview:pointCount atIndex:0];
		[self.aTeamPointsViews insertObject:pointCount atIndex:0];*/
	}
	return self;
}


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
    }
    return self;
}



- (void) began:(NSSet *) touches withEvent:(UIEvent *) event{
	UITouch *touch = [touches anyObject];
	lastTouch = [touch locationInView:self];
	draggingSprite = [self touchedInsideMasterSprite:lastTouch];
	if(draggingSprite){
		touchOffset = CGPointMake(lastTouch.x-self.spriteInitPoint.x, lastTouch.y-self.spriteInitPoint.y);
		redrawRect = [TrucoCounterView getDrawRect:masterSprite.size point:lastTouch offset:touchOffset];
	}
	//[self setNeedsDisplay];
}

- (void) moved:(NSSet *)touches withEvent:(UIEvent *) event{
	if(draggingSprite){
		UITouch *touch = [touches anyObject];
		lastTouch = [touch locationInView:self];
	
	
	
		//CGFloat horizontalOffset = drawImage.size.width / 2;
		//CGFloat verticalOffset = drawImage.size.height / 2;
		//redrawRect = CGRectUnion(redrawRect, CGRectMake(lastTouch.x - horizontalOffset, lastTouch.y - verticalOffset, drawImage.size.width, drawImage.size.height));
	
		redrawRect = CGRectUnion(redrawRect, [TrucoCounterView getDrawRect:masterSprite.size point:lastTouch offset:touchOffset]);
	
		[self setNeedsDisplayInRect:redrawRect];		
		
		redrawRect =  [TrucoCounterView getDrawRect:masterSprite.size point:lastTouch offset:touchOffset];
	}
	
}

//private
-(void) addPointATeam:(UIImage *) pointSprite{
	[aTeamPoints insertObject:pointSprite atIndex:0];
}


- (void) ended:(NSSet *)touches withEvent:(UIEvent *) event{
	if(draggingSprite){
		draggingSprite = NO;
		UITouch *touch = [touches anyObject];
		lastTouch = [touch locationInView:self];
		CGRect bounds = [self bounds];
		//maybe this can be made constant
		CGRect aZone = CGRectMake(0, 0, bounds.size.width/2, bounds.size.height);
		CGRect bZone = CGRectMake(bounds.size.width/2,0, bounds.size.width, bounds.size.height);
		
		

		if (CGRectContainsPoint(aZone, lastTouch )) {
			//[self addPointATeam: sprite];
			self.aPoints = self.aPoints+1; 
			//TODO: OPTIMZE DE REGIION TO REDRAW, ONLY ACTUAL POINTS
			aZone = CGRectUnion(aZone, [TrucoCounterView getDrawRect:masterSprite.size point:lastTouch offset:touchOffset]);
			[self setNeedsDisplayInRect:aZone];
			//[self setNeedsDisplay];
			
			
		} else if(CGRectContainsPoint(bZone, lastTouch )){
			self.bPoints = self.bPoints+1; 
			//TODO: OPTIMZE DE REGIION TO REDRAW
			bZone = CGRectUnion(bZone, [TrucoCounterView getDrawRect:masterSprite.size point:lastTouch offset:touchOffset]);
			[self setNeedsDisplayInRect:bZone];
	//		[self setNeedsDisplay];
			
		}
		
		
	}
	
}



- (BOOL) touchedInsideMasterSprite:(CGPoint) touchPoint{
//	CGPoint drawPoint = [TrucoCounterView getDrawPoint:sprite.size point:self.spriteInitPoint];
	CGRect spriteRect = CGRectMake(self.spriteInitPoint.x, self.spriteInitPoint.y, masterSprite.size.width, masterSprite.size.height);
	return CGRectContainsPoint(spriteRect, touchPoint);
}

- (void)drawTeamPoints:(NSInteger)points withXOrigin:(NSInteger) xOrigin{
	for(int i=0; i<points; i++){

		UIImage *point;
		NSInteger yOffset = (i/5 * 2 * horizontalSprite.size.height ) + ((i / 5) * verticalSprite.size.height)+10;
		yOffset += i >= 15 ? 10 : 0;
		
		
		NSInteger nPoint = i % 5;
		NSInteger x = xOrigin + [self bounds].size.width/8;
		NSInteger y = yOffset;
		switch (nPoint) {
			case 0:
				x += [self verticalSprite].size.width;
				point = [self horizontalSprite];
				break;
			case 1:
				point = [self verticalSprite];
				y += [self horizontalSprite].size.height;
				break;

			case 2:					
				point = [self horizontalSprite];
				y += [self verticalSprite].size.height + horizontalSprite.size.height;
				x += [self verticalSprite].size.width;
				break;
			case 3:					
				point = [self verticalSprite];
				x += [self horizontalSprite].size.width  + verticalSprite.size.width;				
				y += [self horizontalSprite].size.height;
				break;
			case 4:
				point = [self diagonalSprite];
				y += [self horizontalSprite].size.height*1.2;
				x += [self verticalSprite].size.width*1.5;
				break;
			default:
				break;
		}
		[point drawAtPoint:CGPointMake(x,y)];
		
	}
	
}

- (void)drawAPoints:(CGRect)rect{
	[self drawTeamPoints:aPoints withXOrigin:0];	
}

- (void)drawBPoints:(CGRect)rect{
	[self drawTeamPoints:bPoints withXOrigin:[self bounds].size.width/2];	
}



- (void)drawRect:(CGRect)rect {
	//[self sendSubviewToBack:	[aTeamPointsViews objectAtIndex:0]];
    // Drawing code
	//CGPoint drawPoint = getDrawPoint(sprite.size, lastTouch);
	
//	CGPoint drawPoint = [TrucoCounterView getDrawPoint:sprite.size point:self.spriteInitPoint];
	// background test THIS MUST BE A CLASS PROPERTY, AND RELEASED WHEN THE OBJECT IS DESTROYED
	UIImage *back = [UIImage imageNamed:@"back.tiff"];	
	CGPoint p = CGPointMake(0,0);
	[back drawAtPoint:p];
	NSInteger x_shadow = SHADOW_OFFSET_X;
	NSInteger y_shadow = SHADOW_OFFSET_Y;
	
	CGSize          myShadowOffset = CGSizeMake (x_shadow,  y_shadow);
	CGContextRef myContext = UIGraphicsGetCurrentContext();

	CGContextSaveGState(myContext);
	
	
	
    CGContextSetShadow (myContext, myShadowOffset, 2);
	
	[self.masterSprite drawAtPoint:self.spriteInitPoint];
	

	[self drawAPoints:rect];
	[self drawBPoints:rect];
	
	if (draggingSprite){
		CGPoint drawPoint = [TrucoCounterView getDrawPoint:lastTouch offset:touchOffset];
		[masterSprite drawAtPoint:drawPoint];
	}
	
	CGContextRestoreGState(myContext);
}



- (void)dealloc {
    [super dealloc];
}

@end
