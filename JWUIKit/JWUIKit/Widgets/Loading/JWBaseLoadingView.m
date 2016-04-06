//
//  JWBaseLoadingView.m
//  JWUIKit
//
//  Created by Jerry on 16/4/5.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import "JWBaseLoadingView.h"
//Core
#import "JWUIKitMacro.h"

@implementation JWBaseLoadingView

JWUIKitInitialze {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillEnterForeground)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidEnterBackground)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
}

-(void)applicationWillEnterForeground {
    if (self.isAnimating) {
        [self resumeLayers];
    } else {
        [self pauseLayers];
    }
}

-(void)applicationDidEnterBackground {
    [self pauseLayers];
}

-(void)pauseLayers {
    CFTimeInterval pausedTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.layer.speed = 0.0;
    self.layer.timeOffset = pausedTime;
}

-(void)resumeLayers {
    CFTimeInterval pausedTime = [self.layer timeOffset];
    self.layer.speed = 1.0;
    self.layer.timeOffset = 0.0;
    self.layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.layer.beginTime = timeSincePause;
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)startAnimating {
    
}

- (void)stopAnimating {
    
}

@end
