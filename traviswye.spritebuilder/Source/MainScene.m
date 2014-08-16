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
#import "hscores.h"


@implementation MainScene{
    CCNode *_sprite1;
    CCLayoutBox *_namebox;
    CCLayoutBox *_scorebox;
    CCScene *_gameplay;
    tutorial *_tutorPopover;
    CCNode *_settingsmenu;
    CCNode *_entername;
    CCNode *_credpop;
    
    CCTextField *_name;
    CCSlider *_musicslide;
    
    
    CCButton *_twit;
    CCButton *_credsbutton;
    CCButton *_settingsButton;
    CCButton *_moregames;
    CCButton *_hscores;
    CCButton *_playbut;
    CCButton *_tutbut;
}

-(void)changevol{
    [OALSimpleAudio sharedInstance].bgVolume = _musicslide.sliderValue;
}
//


- (void)play {
    _gameplay = [CCBReader loadAsScene:@"gameplay"];
    CCTransition *transition = [CCTransition transitionCrossFadeWithDuration:1.0f];
    [[CCDirector sharedDirector]replaceScene:_gameplay withTransition:transition];
 
    }

-(void)tutorial{
    _tutorPopover = (tutorial *)[CCBReader load:@"tutorial"];
    _tutorPopover.positionType = CCPositionTypeNormalized;
    _tutorPopover.position = ccp(0.5, 0.5);
    _tutorPopover.zOrder = INT_MAX;
    [self addChild:_tutorPopover];
    _credsbutton.enabled = false;
    _settingsButton.enabled = false;
    _playbut.enabled = false;
    _hscores.enabled = false;
    _moregames.enabled = false;
    _tutbut.enabled = false;
    
    
}

-(void)settingsButton{
//    Setting pop up tab
    _settingsmenu = (CCNode *)[CCBReader load:@"Settings" owner:self];
    _settingsmenu.positionType = CCPositionTypeNormalized;
    _settingsmenu.position = ccp(0.5, 0.5);
    _settingsmenu.zOrder = INT_MAX;
    [self addChild:_settingsmenu];
    _credsbutton.enabled = false;
    _settingsButton.enabled = false;
    _playbut.enabled = false;
    _hscores.enabled = false;
    _moregames.enabled = false;
    _tutbut.enabled = false;
}

-(void)credsbutton{
    //    Setting pop up tab
    _credpop = (CCNode *)[CCBReader load:@"credits" owner:self];
    _credpop.positionType = CCPositionTypeNormalized;
    _credpop.position = ccp(0.5, 0.5);
    _credpop.zOrder = INT_MAX;
    [self addChild:_credpop];
    _credsbutton.enabled = false;
    _settingsButton.enabled = false;
    _playbut.enabled = false;
    _hscores.enabled = false;
    _moregames.enabled = false;
    _tutbut.enabled = false;
}


-(void) menuB{
    CCScene * curscene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene: curscene];
}
-(void)moreGames{
    [MGWU displayCrossPromo];
}
-(void)onEnter{
   [[OALSimpleAudio sharedInstance] playBg:@"gameplayFinal1.m4a" loop: true];
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"username"] ==nil){
     _entername = (CCNode *)[CCBReader load:@"EnterName" owner:self];
    _entername.positionType = CCPositionTypeNormalized;
    _entername.position = ccp(0.5, 0.5);
    _entername.zOrder = INT_MAX;
    [self addChild:_entername];
    }
    else{
        
    }
    [super onEnter];
}
-(void)next{
    
    [[NSUserDefaults standardUserDefaults] setObject:_name.string forKey:@"username"];
    [_entername removeFromParent];
    
}



-(void)leaderBoard{
    [MGWU getHighScoresForLeaderboard:@"defaultLeaderboard1" withCallback:@selector(receivedScores:) onTarget:self];
    hscores *leaderboard = (hscores *)[CCBReader load:@"hscores" owner:self];
    leaderboard.positionType = CCPositionTypeNormalized;
    leaderboard.position = ccp(0.5, 0.5);
    leaderboard.zOrder = INT_MAX;
    [self addChild:leaderboard];
    _credsbutton.enabled = false;
    _settingsButton.enabled = false;
    _playbut.enabled = false;
    _hscores.enabled = false;
    _moregames.enabled = false;
    _tutbut.enabled = false;
}
- (void)receivedScores:(NSDictionary*)scores
{
    //Do stuff with scores in here! Display them!
    NSArray *scoreall = scores [@"all"];
    for (int i =scoreall.count-1; i>=0; i--){
        NSNumber *point = scoreall[i][@"score"];
        NSString *name = scoreall[i][@"name"];
        CCLabelTTF *nameslab = [CCLabelTTF labelWithString:name fontName:(@"Verdana-Bold") fontSize:(18.f)];
        CCLabelTTF *scorelab =[CCLabelTTF labelWithString: [NSString stringWithFormat:@"%d", point.intValue] fontName:(@"Verdana-Bold") fontSize:(18.f)];
        
        
        nameslab.color = [CCColor colorWithRed:1.f green:.753 blue:.3176];
        scorelab.color = [CCColor colorWithRed:1.f green:.753 blue:.3176];
        [_namebox addChild:nameslab];
        [_scorebox addChild:scorelab];
        
    }
    
}

-(void)close{
    [_settingsmenu removeFromParent];
    _credsbutton.enabled = true;
    _settingsButton.enabled = true;
    _playbut.enabled = true;
    _hscores.enabled = true;
    _moregames.enabled = true;
    _tutbut.enabled = true;
}

-(void)close2{
    [_credpop removeFromParent];
    _credsbutton.enabled = true;
    _settingsButton.enabled = true;
    _playbut.enabled = true;
    _hscores.enabled = true;
    _moregames.enabled = true;
    _tutbut.enabled = true;
}

-(void)twitterbutton{
    
}





@end
