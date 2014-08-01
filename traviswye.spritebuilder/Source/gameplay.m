//
//  gameplay.m
//  traviswye
//
//  Created by Travis Wye on 7/14/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//



// NEED TO ADD LOOPING BACKGROUND IN HERE
// ADD OBSTACLES ever ~8-12 seconds
// Finish Stopping Character
// ADD objects
// Object collision/ Obstacle collision
// Throw button
// Throw object physics
//


#import "gameplay.h"
#import "Hero.h"
#import "CCPhysics+ObjectiveChipmunk.h"
#import "Obstacles.h"

@implementation gameplay{

    
    Hero* hero;
    CCPhysicsNode *_physicsNode;
    float timeSinceObstacle;
    float timeRotated;
    BOOL _HEROROTATED;
    
    int totcount;

    CCNode *_ground1;
    CCNode * _ground2;
    NSArray * _grounds;
    CCNode *_cloud1;
    CCNode *_cloud2;
    CCNode *_cloud3;
    NSArray *_clouds;
    
    
    NSMutableArray *_throwableObj;
    NSMutableArray *_obs;
    
    
    Obstacles *_thrownT;
    Obstacles *_throwStroid;
    CCNode *_throwableNode;
    CCNode *_platform;
    CCButton *_resetButt;

    CCNode * _planted;
    
    
    CCLabelTTF *_scoreLab;
    CCLabelTTF *_topscoreLab;
    int _score;
    int _topscore;
    CCParticleSystem *_bar2mons;
    
}
-(void)addObstacle{
    Obstacles *obstacle = (Obstacles *)[CCBReader load:@"Obstacle"];
    CGPoint screenPosition = [self convertToWorldSpace:ccp(500, 60)];
    CGPoint worldPosition = [_physicsNode convertToNodeSpace:screenPosition];
    obstacle.position = worldPosition;
    [_physicsNode addChild:obstacle];
    obstacle.physicsBody.collisionGroup = _obs;
//    [Obstacles addObject:obstacle];
}
-(void)addThrowable{
    _thrownT = (Obstacles *)[CCBReader load: @"throw1"];
    [_throwableObj addObject:_thrownT];
    CGPoint screenPosition = [self convertToWorldSpace:ccp(520, 150)];
    CGPoint worldPosition = [_physicsNode convertToNodeSpace:screenPosition];
    _thrownT.position = worldPosition;
    _thrownT.physicsBody.collisionGroup = _throwableObj;
    [_physicsNode addChild:_thrownT];
    
    
}
-(void)addThrowableStroid{
    _throwStroid = (Obstacles *)[CCBReader load: @"pebble"];
    [_throwableObj addObject:_throwStroid];
    CGPoint screenPosition = [self convertToWorldSpace:ccp(520, 70)];
    CGPoint worldPosition = [_physicsNode convertToNodeSpace:screenPosition];
    _throwStroid.position = worldPosition;
    _throwStroid.physicsBody.collisionGroup = _throwableObj;
    [_physicsNode addChild:_throwStroid];
    
    
}
//-(void)addPlatform{
//    _platform = (Obstacles *)[CCBReader load: @"platforms"];
//    [_throwableObj addObject:_platform];
//    int lowerBound = 60;
//    int upperBound = 130;
//    int rndValue2 = lowerBound + arc4random() % (upperBound - lowerBound);
//    int lowerBoundx = 200;
//    int upperBoundx = 540;
//    int rndValuex = lowerBoundx + arc4random() % (upperBoundx - lowerBoundx);
//    
//    CGPoint screenPosition = [self convertToWorldSpace:ccp(rndValuex, rndValue2)];
//    CGPoint worldPosition = [_physicsNode convertToNodeSpace:screenPosition];
//    _platform.position = worldPosition;
//    _platform.physicsBody.collisionGroup = _obs;
//       _platform.physicsBody.collisionGroup = _throwableObj;
//    [_physicsNode addChild:_platform];
//    
//
//}
-(void) addMonster{
    _planted = (Obstacles *)[CCBReader load:@"throw2"];
    [_throwableObj addObject:_planted];
    
    int lowerBoundy = 60;
    int upperBoundy = 250;
    int rndValuey = lowerBoundy + arc4random() % (upperBoundy - lowerBoundy);
 
    CGPoint screenPosition = [self convertToWorldSpace:ccp(450, rndValuey)];
    CGPoint worldPosition = [_physicsNode convertToNodeSpace:screenPosition];
    _planted.position = worldPosition;
    _planted.physicsBody.collisionGroup = _obs;
    [_physicsNode addChild:_planted];
    [_planted.physicsBody applyImpulse:ccp(-200.f, 0)];
    
}

-(void) addAstroidMonster{
    _planted = (Obstacles *)[CCBReader load:@"monster2"];
    [_throwableObj addObject:_planted];
    
    int lowerBoundy = 60;
    int upperBoundy = 250;
    int rndValuey = lowerBoundy + arc4random() % (upperBoundy - lowerBoundy);
    
    CGPoint screenPosition = [self convertToWorldSpace:ccp(450, rndValuey)];
    CGPoint worldPosition = [_physicsNode convertToNodeSpace:screenPosition];
    _planted.position = worldPosition;
    _planted.physicsBody.collisionGroup = _obs;
    [_physicsNode addChild:_planted];
    [_planted.physicsBody applyImpulse:ccp(-200.f, 20.f)];
    
}

 static const CGFloat scrollSpeed = 200.f;

-(void) update:(CCTime)delta{
    hero.position = ccp(hero.position.x + (delta * scrollSpeed), hero.position.y);
    _physicsNode.position = ccp(_physicsNode.position.x - (scrollSpeed *delta), _physicsNode.position.y);
    // Increment the time since the last obstacle was added
    timeSinceObstacle += delta; // delta is approximately 1/60th of a second
    
    if(_HEROROTATED ==TRUE){
        timeRotated +=delta;
        if (timeRotated>1.0f){
            hero.rotation = 0.f;
            _HEROROTATED =FALSE;
            timeRotated = 0;
        }
    }

    // Check to see if 8 seconds have passed
    if (timeSinceObstacle > 1.0f)
    {
        totcount++;
        // Add a new obstacle
//        int tw = 1*random()%1000;
//        NSLog(@"random number = %i",tw);
//        [self addPlatform];
        [self addThrowableStroid];
        if (totcount %6==0){
            [self addThrowable];
        }
        if (totcount %4==0){
            [self addObstacle];
            
            
        }if ( totcount % 3==0) {
//            [self addThrowable];
            [self addMonster];
            [self addAstroidMonster];
            
//            THIS SHOULD BE ADD MONSTER< MOVE WEAPONS TO LESS FREQ
        }

        
        
        // Then reset the timer.
        
     timeSinceObstacle = 0.0f;
    }
    
    
    // move and loop the bushes
    for (CCNode *ground in _grounds) {
        // get the world position of the ground
        CGPoint groundWorldPosition = [_physicsNode convertToWorldSpace:ground.position];
        // get the screen position of the ground
        CGPoint groundScreenPosition = [self convertToNodeSpace:groundWorldPosition];
        // if the left corner is one complete width off the screen, move it to the right
        if (groundScreenPosition.x <= (-1 * ground.contentSize.width)) {
            ground.position = ccp(ground.position.x + 1 * ground.contentSize.width, ground.position.y);
        }
    }
    
    // move and loop the clouds
    for (CCNode *cloud in _clouds) {
        // move the cloud
        cloud.position = ccp(cloud.position.x -(hero.physicsBody.velocity.x + delta*scrollSpeed), cloud.position.y);
        
        // if the left corner is one complete width off the screen,
        // move it to the right
        if (cloud.position.x <= (-1 * cloud.contentSize.width)) {
            cloud.position = ccp(cloud.position.x + 3 * cloud.contentSize.width, cloud.position.y);
        }
    }

}

//- (void)onEnter {
//    [super onEnter];
//    
////    hero.physicsBody.body.body->velocity_func = playerUpdateVelocity;
//    CGRect worldBounds = CGRectMake(0, 0, [CCDirector sharedDirector].viewSize.width, [CCDirector sharedDirector].viewSize.height);
//    // NOTE: the width of the worldBounds is ignored in a CCActionFollowAxisHorizontal -- only the height is important
//    
//    CCActionFollowHorizontal* followHorizontal = [CCActionFollowHorizontal actionWithTarget:hero worldBoundary:worldBounds];
//    [gameplay runAction:followHorizontal];
//    
//
//}



- (void)didLoadFromCCB {
    _clouds = @[_cloud1, _cloud2, _cloud3];
    _grounds = @[_ground1, _ground2];
    _throwableObj = [[NSMutableArray alloc] init];
    _obs = [[NSMutableArray alloc] init];
    totcount = 0;
   hero = (Hero *)[CCBReader load: @"Hero" owner:self];
    
    
    _score = 0;
    [_physicsNode addChild: hero];
    hero.position = ccp(107.f, 83.f);
    
    
    //    COME REDO XAXIS
//    [self runAction:[CCActionFollow actionWithTarget:(hero) worldBoundary:CGRectMake(0,0,1050,350)]];
//    CGRect worldBounds = CGRectMake(0, 0, [CCDirector sharedDirector].viewSize.width, [CCDirector sharedDirector].viewSize.height);
//    // NOTE: the width of the worldBounds is ignored in a CCActionFollowAxisHorizontal -- only the height is important
//    
//    CCActionFollowAxisHorizontal* followHorizontal = [CCActionFollowHorizontal actionWithTarget:hero worldBoundary:worldBounds];
//    [gameplay runAction:followHorizontal];
//    
//    
    _physicsNode.collisionDelegate = self;
    self.userInteractionEnabled = TRUE;
    UISwipeGestureRecognizer *swipeLeft= [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeLeft)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [[[CCDirector sharedDirector]view]addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight= [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeRight)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [[[CCDirector sharedDirector]view]addGestureRecognizer:swipeRight];
    
    UISwipeGestureRecognizer *swipeUp= [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeUp)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [[[CCDirector sharedDirector]view]addGestureRecognizer:swipeUp];
    
    UISwipeGestureRecognizer *swipeDown= [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeDown)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [[[CCDirector sharedDirector]view]addGestureRecognizer:swipeDown];
    
  
}

- (void)swipeLeft {
    
    if (hero.throw.children.firstObject!= NULL && self.cartNode.children.count <1){
        Obstacles * obj =hero.throw.children[0];
        [obj removeFromParentAndCleanup:TRUE];
        [self.cartNode addChild:obj];
        obj.position = ccp(0.f,0.f);
    }
}

- (void)swipeRight {
    if (hero.throw.children.count<1 && self.cartNode.children.firstObject!=NULL){
        Obstacles * obj =self.cartNode.children[0];
        [obj removeFromParentAndCleanup:TRUE];
        [hero.throw addChild:obj];
    }else{
         [self throwM];
    }
   

}

- (void)swipeDown {
    if (hero.position.y >90){
    [hero.physicsBody applyImpulse:ccp(0,-120.f)];
    }
    if (hero.throw.children.firstObject ==NULL && hero.position.y <90){
        
        hero.rotation = -90.f;
        [hero.physicsBody applyImpulse:ccp(0,-120.f)];
        _HEROROTATED = TRUE;
    }
}

- (void)swipeUp {
//    hero.position = ccp(hero.position.x, hero.position.y+120);
    if (hero.position.y<140 && _HEROROTATED != true){
    [hero.physicsBody applyImpulse:ccp(0,145.f)];
    }
  
}


- (void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair hero:(CCNode *)nodeA barrell:(CCNode *)nodeB { [[_physicsNode space]addPostStepBlock:^{
    if (hero.throw.children.count <1){
        [nodeB removeFromParentAndCleanup:true];
        [hero.throw addChild:nodeB];
        nodeB.position = ccp(0.f,0.f);
    }

    
     NSLog(@" hero got a barrell");
    
}key:nil];
    
}

- (void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair hero:(CCNode *)nodeA stroid:(CCNode *)nodeB { [[_physicsNode space]addPostStepBlock:^{
    if (hero.throw.children.count <1){
        [nodeB removeFromParentAndCleanup:true];
        [hero.throw addChild:nodeB];
        nodeB.position = ccp(0.f,0.f);
    }
    
    
    NSLog(@" hero hit stroid");
    
}key:nil];
    
}

- (void)throwM{
    //Fix nill check so exception is not thrown.
    if (hero.throw.children.firstObject!= NULL){
    Obstacles *launch = hero.throw.children[0];
    CGPoint worldPosition = [launch.parent convertToWorldSpace:(launch.position)];
    CGPoint screenPosition = [_physicsNode convertToNodeSpace:worldPosition];
    [launch removeFromParentAndCleanup:YES];
    [_physicsNode addChild: launch];
    launch.position = screenPosition;
    launch.physicsBody.type = CCPhysicsBodyTypeDynamic;
    [launch.physicsBody applyImpulse:ccp(1400.f,0)];
    NSLog(@"Barrell has been THROWN");
    }else{
    
    }
    
}

//- (void)depInCart{
//    //Fix nill check so exception is not thrown.
//    if (self.cartNode.children.firstObject== NULL || self.cartNode.children.count >0){
//        Hero* subhero = hero;
//        CGPoint worldPosition = [subhero convertToWorldSpace:ccp(0.f,0.f)];
//        CGPoint screenPosition = [_physicsNode convertToNodeSpace:worldPosition];
//        [hero removeFromParent];
//        [self.cartNode addChild: subhero];
//        subhero.position = screenPosition;
//        subhero.physicsBody.type = CCPhysicsBodyTypeStatic;
//        NSLog(@"Barrell has been STORED");
//    }else{
//        //        _throwbutton.visible = false;
//    }
//    
//}

- (void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair hero:(CCNode *)nodeA monster:(CCNode *)nodeB{ [[_physicsNode space]addPostStepBlock:^{
    [self gameOver];
    
    NSLog(@"collision with spikes");
    
}key:nil];
    
    
}

- (void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair hero:(CCNode *)nodeA monster2:(CCNode *)nodeB{ [[_physicsNode space]addPostStepBlock:^{
    [self gameOver];
    
    NSLog(@"collision with spikes");
    
}key:nil];
    
    
}

- (void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair hero:(CCNode *)nodeA spikes:(CCNode *)nodeB { [[_physicsNode space]addPostStepBlock:^{
    [self gameOver];
    
    NSLog(@"hero collision with spikes");
    
}key:nil];
}
- (void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair barrell:(CCNode *)nodeA monster:(CCNode *)
nodeB {
    

    if( true == 0){
       
    }
    else{
    [[_physicsNode space]addPostStepBlock:^{
        [nodeA removeFromParent];
        CCParticleSystem *explosion = (CCParticleSystem *)[CCBReader load:@"dyingmonst"];
        explosion.autoRemoveOnFinish = TRUE;
        explosion.position = nodeB.position;
        [nodeB.parent addChild:explosion];
        [nodeB removeFromParent];
        
        _score = _score +100;
        _scoreLab.string = ([NSString stringWithFormat:@"%d", _score]);
//        if (_score > _topscore){
//            _topscoreLab.string = ([NSString stringWithFormat:@"%d", _score]);
//        }
        
        
    NSLog(@"hit monster with barrell");
    
}key:nil];
    
    }
}




- (void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair barrell:(CCNode *)nodeA spikes:(CCNode *)
nodeB {
    CGPoint energy = [nodeA.physicsBody velocity];
    if( energy.x == 0){
        
    }
    else{
        [[_physicsNode space]addPostStepBlock:^{
            CCParticleSystem *explosion = (CCParticleSystem *)[CCBReader load:@"barrellbang"];
            explosion.autoRemoveOnFinish = TRUE;
            explosion.position = nodeA.position;
            [nodeA.parent addChild:explosion];
            [nodeA removeFromParent];
            
            NSLog(@"barrell wasted");
            
        }key:nil];
        
    }
}

    


-(void) resetM{
//      _topscoreLab.string = ([NSString stringWithFormat:@"%d", _score]);
    CCScene * curscene = [CCBReader loadAsScene:@"gameplay"];
    [[CCDirector sharedDirector] replaceScene: curscene];
    
}


- (void)gameOver{
    self.paused = YES;
    _resetButt.visible = YES;

    
    
    
}


@end
