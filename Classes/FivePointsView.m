//
//  FivePointsView.m
//  TrucoCounter
//
//  Created by Mariano Heredia on 2/19/09.
//  Copyright 2009 Eglu. All rights reserved.
//

#import "FivePointsView.h"


@implementation FivePointsView


- (id) initWithCoder:(NSCoder*) coder
{
	if((self = [super initWithCoder:coder]))
	{
		self.backgroundColor = [UIColor redColor];
	}
	return self;
}


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		self.backgroundColor = [UIColor redColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
//	self.backgroundColor = [UIColor redColor];
}


- (void)dealloc {
    [super dealloc];
}


@end
