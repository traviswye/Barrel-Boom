//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"
#import "Obstacles.h"


@implementation MainScene

//    
- (void)play {
    CCScene *gameplay = [CCBReader loadAsScene:@"gameplay"];
    CCTransition *transition = [CCTransition transitionCrossFadeWithDuration:1.0f];
    [[CCDirector sharedDirector]replaceScene:gameplay withTransition:transition];
    }

    
@end
