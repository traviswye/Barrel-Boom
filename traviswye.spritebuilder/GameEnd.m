//
//  GameEnd.m
//  2048
//
//  Created by Travis Wye on 6/30/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GameEnd.h"


@implementation GameEnd {
    CCLabelTTF *_highscorelable2;
    CCLabelTTF *_scorelable2;
    NSInteger scoretest;
}
- (void)newGame {
    CCScene *mainScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:mainScene];
}

- (void)setMessage:(NSString *)message score:(NSString*)score {
    _highscorelable2.string = message;
//    scoretest =[NSString stringWithFormat:@"%d", score];
    _scorelable2.string = score;
}
-(void) resetM{
    CCScene * curscene = [CCBReader loadAsScene:@"gameplay"];
    [[CCDirector sharedDirector] replaceScene: curscene];
}
-(void) menuB{
    CCScene * curscene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene: curscene];
}

@end
