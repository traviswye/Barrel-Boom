//
//  Hero.h
//  traviswye
//
//  Created by Travis Wye on 7/15/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSprite.h"



@interface Hero : CCSprite

@property (weak) CCNode* throw;



-(void) jump;
@end
