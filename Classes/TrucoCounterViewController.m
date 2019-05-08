//
//  TrucoCounterViewController.m
//  TrucoCounter
//
//  Created by Mariano Heredia on 2/18/09.
//  Copyright Eglu 2009. All rights reserved.
//

#import "TrucoCounterViewController.h"

@implementation TrucoCounterViewController
//@synthesize pointSprite;

//@synthesize messageLabel;
@dynamic trucoCounterView;

- (TrucoCounterView*) trucoCounterView{
	return (TrucoCounterView *) [super view];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}


- (void)dealloc {
	//[messageLabel release];	
	[super dealloc];
}
#pragma mark -
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self trucoCounterView] began:touches withEvent:event];
	//messageLabel.text = @"Touches Began";	
	//[self updateLabelsFromTouches:touches];
	
}

- (void) refreshPointsLabels{
	aPointsLabel.text = [NSString stringWithFormat:@"%d", [self trucoCounterView].aPoints];
	bPointsLabel.text = [NSString stringWithFormat:@"%d", [self trucoCounterView].bPoints];
	
}

/*- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [[self trucoCounterView] touchesB:touches withEvent:event];	
	messageLabel.text = @"Touches Cancelled";
	//[self updateLabelsFromTouches:touches];
	
}*/
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[[self trucoCounterView] ended:touches withEvent:event];
	//messageLabel.text = @"Touches Stopped.";
	[self refreshPointsLabels];	
	NSString *msg = nil;
	if(self.trucoCounterView.aPoints == 30){		
		msg = @"Team A wins!!!";					
	} else if(self.trucoCounterView.bPoints == 30){		
		msg = @"Team B wins!!!";					
	}
	if(msg != nil){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Winner!!!"
														message: msg 
													   delegate: self
											  cancelButtonTitle:@"ok"
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
		[msg release];	
	}
	//[self updateLabelsFromTouches:touches];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	[self reset];
}
- (void) reset{
	self.trucoCounterView.aPoints = 0;
	self.trucoCounterView.bPoints = 0;
	//	self.bPoints = 0;
	[self.trucoCounterView setNeedsDisplay];
	[self refreshPointsLabels];
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self trucoCounterView] moved:touches withEvent:event];	
	//messageLabel.text = @"Drag Detected";
//[self updateLabelsFromTouches:touches];	
	
}

- (IBAction) decrementAPoints{
	if(	[self trucoCounterView].aPoints > 0){
		[self trucoCounterView].aPoints -= 1;
		[[self trucoCounterView] setNeedsDisplay];	
		aPointsLabel.text = [NSString stringWithFormat:@"%d", [self trucoCounterView].aPoints];
	}
}
- (IBAction) decrementBPoints{
	if(	[self trucoCounterView].bPoints > 0){
		[self trucoCounterView].bPoints -= 1;
		[[self trucoCounterView] setNeedsDisplay];	
		bPointsLabel.text = [NSString stringWithFormat:@"%d", [self trucoCounterView].bPoints];
	}
}
@end