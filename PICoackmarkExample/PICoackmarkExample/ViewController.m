//
//  ViewController.m
//  PICoackmarkExample
//
//  Created by Pham Quy on 2/6/15.
//  Copyright (c) 2015 Jkorp. All rights reserved.
//

#import "ViewController.h"
#import <PICoachmark/PICoachmark.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
   }

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSDictionary* coachMarkDict =
    [NSDictionary
     dictionaryWithContentsOfFile:[[NSBundle mainBundle]
                                   pathForResource:@"coachmark1"
                                   ofType:@"plist"]];
    PIImageCoachmark* coachmark1 = [[PIImageCoachmark alloc] initWithDictionary:coachMarkDict];
    
    coachMarkDict =[NSDictionary
     dictionaryWithContentsOfFile:[[NSBundle mainBundle]
                                   pathForResource:@"coachmark2"
                                   ofType:@"plist"]];
    PIImageCoachmark* coachmark2 = [[PIImageCoachmark alloc] initWithDictionary:coachMarkDict];

    coachMarkDict =[NSDictionary
                    dictionaryWithContentsOfFile:[[NSBundle mainBundle]
                                                  pathForResource:@"coachmark3"
                                                  ofType:@"plist"]];
    PIImageCoachmark* coachmark3 = [[PIImageCoachmark alloc] initWithDictionary:coachMarkDict];

    
    PICoachmarkScreen* screen1 = [[PICoachmarkScreen alloc] initWithCoachMarks:@[coachmark1]];
    PICoachmarkScreen* screen2 = [[PICoachmarkScreen alloc] initWithCoachMarks:@[coachmark2, coachmark3]];
    
    UIWindow* window = [[UIApplication sharedApplication] keyWindow];
    PICoachmarkView *coachMarksView = [[PICoachmarkView alloc]
                                       initWithFrame:window.bounds];
    [window addSubview:coachMarksView];
    [coachMarksView setScreens:@[screen2, screen1]];
    [coachMarksView start];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
