//
//  tutorial.m
//  traviswye
//
//  Created by Travis Wye on 8/7/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "tutorial.h"



@implementation tutorial {
    CCLabelTTF *_swipeInstruct;
    CCLabelTTF *_swipePic;
    CCNode *_up;
    CCNode *_down;
    CCNode *_left;
    CCNode *_right;
    CCNode *_curNode;
    
    CCButton *_nextButton;
    CCButton *_playButton;
    
    BOOL up;
    bool down;
    bool left;
    bool right;
    int i;
    
    NSArray *_swipes;
    NSEnumerator *_swipes1;
    NSArray *_commands;
    NSEnumerator *_commands1;
}

-(void) didLoadFromCCB{
    NSString *u = @"Swipe up to Jump";
    NSString *d = @"Swipe down to accelerate downwards";
    NSString *r= @"Swipe right to throw object";
    NSString *l = @"Swipe left to store object";
    NSString *Coin = @"Pickup coins for 5 points each";
    NSString *Obj = @"Objects can be thrown to destroy monsters for 100 points";
     _commands = @[d, r, l, Obj];
    i = 0;
}



- (void)next1{
    _up.visible = false;
    if (i==0){
    _down.visible= TRUE;
    }if(i==1){
        _down.visible = false;
        _right.visible = true;
    }if(i==2){
        _right.visible = false;
        _left.visible = true;

    }if(i ==3){
        _left.visible = false;
        _nextButton.visible = false;
        _playButton.visible = TRUE;
        //add monsters
        //wrap text
    }
    
    _swipeInstruct.string = _commands[i];
    i++;

}

-(void)back2menu{
    CCScene * curscene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene: curscene];
}

- (void)play {
    CCScene *gameplay = [CCBReader loadAsScene:@"gameplay"];
    CCTransition *transition = [CCTransition transitionCrossFadeWithDuration:1.0f];
    [[CCDirector sharedDirector]replaceScene:gameplay withTransition:transition];
    
}
@end
