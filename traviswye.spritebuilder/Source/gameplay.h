//
//  gameplay.h
//  traviswye
//
//  Created by Travis Wye on 7/14/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "Hero.h"

@interface gameplay : CCNode <CCPhysicsCollisionDelegate>
{
   
  }
 @property (weak) CCNode* cartNode;
@property (nonatomic, assign) NSInteger score;
@property (nonatomic, assign) NSInteger highscore;
-(void) initialize;
-(void) addObstacle;
-(void) throwM;
//-(void) depInCart;










@end
