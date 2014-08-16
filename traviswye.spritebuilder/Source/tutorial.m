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
    
    CCNode *_mons;
    CCNode *_ghost;
    CCNode *_coin;
    CCNode *_tomb;
    CCNode *_bar;
    CCNode *_star;
    
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
    NSString *d = @"             Swipe down \n to accelerate downwards";
    NSString *r= @"Swipe right to throw object";
    NSString *l = @"Swipe left to store object";
    NSString *Coin = @"       Avoid Obstacles while \n          collecting coins";
    NSString *Obj = @"            Objects can be \n         thrown to destroy \n  monsters for 25 or 10 points";
     _commands = @[d, r, l,Coin, Obj];
    i = 0;
    _mons.visible = false;
    _ghost.visible = false;
    _tomb.visible = false;
    _coin.visible = false;
    _bar.visible = false;
    _star.visible = false;
    
    self.userInteractionEnabled = true;
    
}

-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    
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

    }if(i==3){
        _right.visible = false;
        _left.visible = false;
        _tomb.visible = true;
        _coin.visible = true;
        
    }if(i ==4){
        _tomb.visible = false;
        _coin.visible = false;
        _left.visible = false;
        _nextButton.visible = false;
        _playButton.visible = TRUE;
        _mons.visible=true;
        _ghost.visible = true;
        _bar.visible = true;
        _star.visible = true;
        //add monsters
        //wrap text
    }if (i==5){
        _nextButton.visible = false;
        
    }
    
    
    
    _swipeInstruct.string = _commands[i];
    _swipeInstruct.color =  [CCColor colorWithRed:1.f green:.753 blue:.3176];
    _swipeInstruct.fontName = (@"Verdana-Bold");
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
