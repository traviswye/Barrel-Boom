//
//  Hero.m
//  traviswye
//
//  Created by Travis Wye on 7/15/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Hero.h"
#import "gameplay.h"

@implementation Hero



-(void) didLoadFromCCB{
    
//    self.position = ccp(30,70);
//    self.zOrder = DrawingOrderHero;
    self.physicsBody.collisionType = @"hero";
    
   
    
}



-(void) jump{
    [self.physicsBody applyImpulse:ccp(0,200.f)];
    
}

@end
