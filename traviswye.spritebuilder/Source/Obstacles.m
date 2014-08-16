//
//  Obstacles.m
//  traviswye
//
//  Created by Travis Wye on 7/14/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Obstacles.h"

@implementation Obstacles {
    CCNode *_spikes;
    CCNode *_thrownT;
    CCNode *_sword;
    CCNode *_throwStroid;
}

#define ARC4RANDOM_MAX      0x100000000

// visibility on a 3,5-inch iPhone ends a 88 points and we want some meat
static const CGFloat minimumYPosition = 200.f;
// visibility ends at 480 and we want some meat
static const CGFloat maximumYPosition = 380.f;

- (void)didLoadFromCCB {
//    _topPipe.physicsBody.collisionType = @"level";
//    _topPipe.physicsBody.sensor = YES;
////    
//    _spikes.physicsBody.collisionType = @"spikes";
//    _spikes.physicsBody.sensor = YES;
//    
////    _thrownT.physicsBody.collisionType = @"barrell";
//    _thrownT.physicsBody.sensor = YES;
//    
//    _throwStroid.physicsBody.collisionType = @"stroid";
//    _throwStroid.physicsBody.sensor = YES;
//    
//    
//    _sword.physicsBody.collisionType = @"sword";
//    _sword.physicsBody.sensor =  YES;
//    self.physicsBody.collisionType = @"Obstacles";
//    
    
    
    
}

//- (void)setupRandomPos {
//    // value between 0.f and 1.f
//    CGFloat random = ((double)arc4random() / ARC4RANDOM_MAX);
//    CGFloat range = maximumYPosition - minimumYPosition;
//    self.position = ccp(self.position.x, minimumYPosition + (random * range));
//}

@end
