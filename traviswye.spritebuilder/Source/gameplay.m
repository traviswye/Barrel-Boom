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
#import "GameEnd.h"

@implementation gameplay{

    //hero/physics
    Hero* hero;
    CCPhysicsNode *_physicsNode;
    
    //update
    float timeSinceObstacle;
    float timeRotated;
    BOOL _HEROROTATED;
    int totcount;

    //background
    CCNode *_ground1;
    CCNode * _ground2;
    CCNode *_ground3;
    CCNode * _ground4;
    NSArray * _grounds;
    CCNode *_cloud1;
    CCNode *_cloud2;
    CCNode *_cloud3;
    NSArray *_clouds;
    
    //fix these groups
    NSMutableArray *_throwableObj;
    NSMutableArray *_obs;
    
    
    Obstacles *_thrownT;
    Obstacles *_throwStroid;
    CCNode *_throwableNode;
    CCSprite *_coin;
    
    
    CCNode *_platform;
    CCButton *_resetButt;
    CCButton *_menubutton;
    CCNode * _planted;
    
    //scoring
    CCLabelTTF *_scoreLab;
    CCLabelTTF *_topscoreLab;
    
    

    
}



- (void)didLoadFromCCB {
    int highScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"highscore1"];
    _topscoreLab.string = [NSString stringWithFormat:@"%i", highScore];
    
    
    _clouds = @[_cloud1, _cloud2];  //, _cloud3
    _grounds = @[_ground1, _ground2, _ground3, _ground4];
    _throwableObj = [[NSMutableArray alloc] init];
    _obs = [[NSMutableArray alloc] init];
    totcount = 0;
    hero = (Hero *)[CCBReader load: @"Hero" owner:self];
    
    
    self.score = 0;
    [_physicsNode addChild: hero];
    hero.position = ccp(107.f, 83.f);
//    [_cartNode addChild: hero];
//    hero.position = ccp(0.f, 0.f);
    
    //    COME REDO XAXIS
//        [self runAction:[CCActionFollow actionWithTarget:(hero) worldBoundary:CGRectMake(0,0,0,0)]];
//        CGRect worldBounds = CGRectMake(0, 0, [CCDirector sharedDirector].viewSize.width, [CCDirector sharedDirector].viewSize.height);
    //    // NOTE: the width of the worldBounds is ignored in a CCActionFollowAxisHorizontal -- only the height is important
    //
//        CCActionFollowAxisHorizontal* followHorizontal = [CCActionFollowHorizontal actionWithTarget:hero worldBoundary:worldBounds];
//        [gameplay runAction:followHorizontal];

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
//just stays at the start
- (void)swipeLeft {
    
    if (hero.throw.children.firstObject!= NULL && self.cartNode.children.count <1){
        Obstacles * obj =hero.throw.children[0];
        [obj removeFromParentAndCleanup:TRUE];
        [self.cartNode addChild:obj];
        obj.position = ccp(25.f,0.f);
    }
}




- (void)swipeRight {
    if (hero.throw.children.count<1 && self.cartNode.children.firstObject!=NULL){
        Obstacles * obj =self.cartNode.children[0];
        [obj removeFromParentAndCleanup:TRUE];
        [hero.throw addChild:obj];
        obj.position = ccp(0.f,0.f);
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
    //
    if (hero.position.y<150 && _HEROROTATED != true){
        [hero.physicsBody applyImpulse:ccp(0,145.f)];
    }
    
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
    CGPoint screenPosition = [self convertToWorldSpace:ccp(700, 130)];
    CGPoint worldPosition = [_physicsNode convertToNodeSpace:screenPosition];
    _thrownT.position = worldPosition;
    _thrownT.physicsBody.collisionGroup = _throwableObj;
    [_physicsNode addChild:_thrownT];
    
    
}
-(void)addThrowableStroid{
    _throwStroid = (Obstacles *)[CCBReader load: @"astroidthrow"];
    [_throwableObj addObject:_throwStroid];
    CGPoint screenPosition = [self convertToWorldSpace:ccp(520, 50)];
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

-(void) addCoins{
    _coin = (CCSprite*)[CCBReader load:@"coins"];
    
    int lowerBoundy = 60;
    int upperBoundy = 250;
    int rndValuey = lowerBoundy + arc4random() % (upperBoundy - lowerBoundy);
    
    CGPoint screenPosition = [self convertToWorldSpace:ccp(550, rndValuey)];
    CGPoint worldPosition = [_physicsNode convertToNodeSpace:screenPosition];
    _coin.position = worldPosition;
    _coin.physicsBody.collisionGroup = _throwableObj;
    _coin.physicsBody.sensor = false;
    [_physicsNode addChild:_coin];
   
}
-(void) addMonster{
    _planted = (Obstacles *)[CCBReader load:@"throw2"];
    [_throwableObj addObject:_planted];
    
    int lowerBoundy = 90;
    int upperBoundy = 250;
    int rndValuey = lowerBoundy + arc4random() % (upperBoundy - lowerBoundy);
 
    CGPoint screenPosition = [self convertToWorldSpace:ccp(550, rndValuey)];
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
    
    CGPoint screenPosition = [self convertToWorldSpace:ccp(550, rndValuey)];
    CGPoint worldPosition = [_physicsNode convertToNodeSpace:screenPosition];
    _planted.position = worldPosition;
    _planted.physicsBody.collisionGroup = _obs;
    //monster should not run into the spikes or the barrell fix
//    _planted.physicsBody.collisionGroup = _obs;
    [_physicsNode addChild:_planted];
    [_planted.physicsBody applyImpulse:ccp(-200.f, 20.f)];
    
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


 static const CGFloat scrollSpeed = 230.f;

-(void) update:(CCTime)delta{
    hero.position = ccp(hero.position.x + (delta * scrollSpeed), hero.position.y);
    _cartNode.position = ccp(_cartNode.position.x + (delta * scrollSpeed), _cartNode.position.y);
    
    _physicsNode.position = ccp(_physicsNode.position.x - (scrollSpeed *delta), _physicsNode.position.y);
    // Increment the time since the last obstacle was added
    timeSinceObstacle += delta; // delta is approximately 1/60th of a second

    if(_HEROROTATED ==TRUE){
        timeRotated +=delta;
        if (timeRotated>0.8f){
            hero.rotation = 0.f;
            _HEROROTATED =FALSE;
            timeRotated = 0;
        }
    }
    // Check to see if 8 seconds have passed
    if (timeSinceObstacle > 1.0f)
    {
        [self addCoins];
        totcount++;
        // Add a new obstacle
//        [self addPlatform];
        
        if (totcount %2==0){
            
            if (totcount %5==0){
                                [self addAstroidMonster];
            }else{
                [self addThrowable];
            }
        }
        if (totcount %4==0 && !totcount % 5==0){
            [self addObstacle];
            
            
        }if ( totcount % 3==0) {
//            [self addThrowable];
            if ((totcount%2 ==0)) {
                [self addMonster];
            }else{
                [self addThrowableStroid];

            }
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
            ground.position = ccp(ground.position.x + 6 * ground.contentSize.width, ground.position.y);
        }
    }
    // move and loop the clouds
    for (CCNode *cloud in _clouds) {
        // move the cloud
        cloud.position = ccp(cloud.position.x -(hero.physicsBody.velocity.x + delta*scrollSpeed), cloud.position.y);
        
        // if the left corner is one complete width off the screen,
        // move it to the right
        if (cloud.position.x <= (-1 * cloud.contentSize.width)) {
            cloud.position = ccp(cloud.position.x + 4 * cloud.contentSize.width, cloud.position.y);
        }
    }
    NSMutableArray *itemtomove =[[NSMutableArray alloc] init];
    for ( CCNode *pastthrow in _throwableObj){
        if (pastthrow.position.x < hero.position.x - 107.f){
            [pastthrow removeFromParent];
            [itemtomove addObject:pastthrow];
        }
    }
    for (CCNode *current in itemtomove){
        [_throwableObj removeObject:current];
        
    }
    [itemtomove removeAllObjects];
    for (CCNode* pastobs in _obs){
        if (pastobs.position.x < hero.position.x - 107.f){
            [pastobs removeFromParent];
            [itemtomove addObject:pastobs];
        }
    }
    for (CCNode *current in itemtomove){
        [_throwableObj removeObject:current];
        
    }
    [itemtomove removeAllObjects];
}






- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair hero:(CCNode *)nodeA barrell:(Obstacles *)nodeB { [[_physicsNode space]addPostStepBlock:^{
    if (hero.throw.children.count <1){
        [nodeB removeFromParentAndCleanup:true];
        nodeB.physicsBody.type = CCPhysicsBodyTypeKinematic;
        [hero.throw addChild:nodeB];
        nodeB.position = ccp(0.f,0.f);
        [_throwableObj removeObject:nodeB];
    }

    
     NSLog(@" hero got a barrell");
    
}key:nil];
    return false;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair hero:(CCNode *)nodeA stroid:(Obstacles *)nodeB { [[_physicsNode space]addPostStepBlock:^{
    if (hero.throw.children.count <1){
        [nodeB removeFromParentAndCleanup:true];
        nodeB.physicsBody.type = CCPhysicsBodyTypeKinematic;
        [hero.throw addChild:nodeB];
        nodeB.position = ccp(0.f,0.f);
         [_throwableObj removeObject:nodeB];
    }
    
    
    NSLog(@" hero picked up stroid");
    
}key:nil];
    return false;
    
}



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

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair hero:(CCNode *)nodeA coin:(CCNode *)nodeB {
    [[_physicsNode space]addPostStepBlock:^{
//    nodeB.physicsBody.sensor = false;
    [nodeB removeFromParentAndCleanup:true];
    self.score = self.score +5;
    _scoreLab.string = ([NSString stringWithFormat:@"%d", self.score]);
    NSLog(@"picked up a coin");
    
}key:nil];
    return false;
}


- (void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair barrell:(CCNode *)nodeA monster:(CCNode *)
nodeB {
    

    if( true == 0){
//       need velo check on barrel. if still do not do this
    }
    else{
    [[_physicsNode space]addPostStepBlock:^{
        [nodeA removeFromParent];
        CCParticleSystem *explosion = (CCParticleSystem *)[CCBReader load:@"dyingmonst"];
        explosion.autoRemoveOnFinish = TRUE;
        explosion.position = nodeB.position;
        [nodeB.parent addChild:explosion];
        [nodeB removeFromParent];
        
        self.score = self.score +100;
        _scoreLab.string = ([NSString stringWithFormat:@"%d", self.score]);
        
    NSLog(@"hit monster with barrell");
    
}key:nil];
    
    }
}
- (void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair stroid:(CCNode *)nodeA monster2:(CCNode *)
nodeB {
    
    if (!nodeA.position.y <100 ){
        [[_physicsNode space]addPostStepBlock:^{
            [nodeA removeFromParent];
            CCParticleSystem *explosion = (CCParticleSystem *)[CCBReader load:@"dyingmonst"];
            explosion.autoRemoveOnFinish = TRUE;
            explosion.position = nodeB.position;
            [nodeB.parent addChild:explosion];
            [nodeB removeFromParent];
            
            self.score = self.score +100;
            _scoreLab.string = ([NSString stringWithFormat:@"%d", self.score]);
        
            NSLog(@"hit monster2 with stroid");
        
        }key:nil];
    }
    
}

- (void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair stroid:(CCNode *)nodeA monster:(CCNode *)
nodeB {
    
    if (!nodeA.position.y <100 ){
        [[_physicsNode space]addPostStepBlock:^{
            [nodeA removeFromParent];
            CCParticleSystem *explosion = (CCParticleSystem *)[CCBReader load:@"dyingmonst"];
            explosion.autoRemoveOnFinish = TRUE;
            explosion.position = nodeB.position;
            [nodeB.parent addChild:explosion];
            [nodeB removeFromParent];
            
            self.score = self.score -50;
            _scoreLab.string = ([NSString stringWithFormat:@"%d", self.score]);
            
            NSLog(@"hit monster2 with stroid");
            
        }key:nil];
    }
    
}


- (void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair barrell:(CCNode *)nodeA monster2:(CCNode *)
nodeB {
    
    if (!nodeA.position.y <100 ){
        [[_physicsNode space]addPostStepBlock:^{
            [nodeA removeFromParent];
            CCParticleSystem *explosion = (CCParticleSystem *)[CCBReader load:@"dyingmonst"];
            explosion.autoRemoveOnFinish = TRUE;
            explosion.position = nodeB.position;
            [nodeB.parent addChild:explosion];
            [nodeB removeFromParent];
            
            self.score = self.score -50;
            _scoreLab.string = ([NSString stringWithFormat:@"%d", self.score]);
            
            NSLog(@"hit monster2 with stroid");
            
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

- (void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair stroid:(CCNode *)nodeA spikes:(CCNode *)
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
            
            NSLog(@"stroid wasted");
            
        }key:nil];
        
    }
}


-(void) resetM{
    CCScene * curscene = [CCBReader loadAsScene:@"gameplay"];
    [[CCDirector sharedDirector] replaceScene: curscene];
}
-(void) menuB{
    CCScene * curscene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene: curscene];
}



- (void)gameOver{
    //Create popup?
    self.paused = YES;
    _resetButt.visible = YES;
    int highScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"highscore1"];
    _scoreLab.string = [NSString stringWithFormat:@"%d", self.score];
    if (self.score > highScore) {
        // new highscore!
        [[NSUserDefaults standardUserDefaults] setInteger:self.score forKey:@"highscore1"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        int highScore2 = [[NSUserDefaults standardUserDefaults] integerForKey:@"highscore1"];
        ;
         _topscoreLab.string = [NSString stringWithFormat:@"%d", highScore2];
        highScore = highScore2;
    }
    
    GameEnd *gameEndPopover = (GameEnd *)[CCBReader load:@"GameEnd"];
    gameEndPopover.positionType = CCPositionTypeNormalized;
    gameEndPopover.position = ccp(0.5, 0.5);
    gameEndPopover.zOrder = INT_MAX;

    [gameEndPopover setMessage:_topscoreLab.string score:_scoreLab.string];

    [self addChild:gameEndPopover];
    
    
//    GameEnd *gameEndPopover = (GameEnd*)[CCBReader load:@"EndGame"];
//        gameEndPopover.positionType = CCPositionTypeNormalized;
//        gameEndPopover.position = ccp(0.5, 0.5);
//        gameEndPopover.zOrder = INT_MAX;
//        //set scores
//       [self addChild:gameEndPopover];
//    
    
}





@end
