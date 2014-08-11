//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"
#import "Obstacles.h"
#import "gameplay.h"
#import "tutorial.h"


@implementation MainScene

//    
- (void)play {
    CCScene *gameplay = [CCBReader loadAsScene:@"gameplay"];
    CCTransition *transition = [CCTransition transitionCrossFadeWithDuration:1.0f];
    [[CCDirector sharedDirector]replaceScene:gameplay withTransition:transition];
 
    }

-(void)tutorial{
    tutorial *tutorPopover = (tutorial *)[CCBReader load:@"tutorial"];
    tutorPopover.positionType = CCPositionTypeNormalized;
    tutorPopover.position = ccp(0.5, 0.5);
    tutorPopover.zOrder = INT_MAX;
    [self addChild:tutorPopover];
}









@end
