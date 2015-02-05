//
//  PICoachmarkManager.m
//  NewPiki
//
//  Created by Pham Quy on 2/3/15.
//  Copyright (c) 2015 Pikicast Inc. All rights reserved.
//

#import "PICoachmarkManager.h"
#import "PICoachmark.h"


typedef NS_ENUM(NSInteger, PICoachmarkScreenType)
{
    PICoachmarkScreenType480h = 480, // ip 1,2,3,4,4s
    PICoachmarkScreenType568h = 568, // ip5 ,ip5s
    PICoachmarkScreenType667h = 667, // ip6
    PICoachmarkScreenType736h = 736, // ip6+
    PICoachmarkScreenTypeUnknown = 0
};

#define PICoachmarkScreenTypeSuffix480h @""
#define PICoachmarkScreenTypeSuffix568h @"-568h"
#define PICoachmarkScreenTypeSuffix667h @"-667h"
#define PICoachmarkScreenTypeSuffix736h @"-736h"

const NSString* PICoachmarkIdHomeNavigationTitle = @"coachmark.home.navigationTitle";
const NSString* PICoachmarkIdStoryCoverInfo = @"coachmark.story.cover.info";
const NSString* PICoachmarkIdStoryCoverBgm = @"coachmark.story.cover.bgm";
const NSString* PICoachmarkIdStoryCoverShare = @"coachmark.story.cover.share";
const NSString* PICoachmarkIdStoryCardList = @"coachmark.story.card.list";
const NSString* PICoachmarkIdStoryCardPanorama = @"coachmark.story.card.panorama";
const NSString* PICoachmarkIdStoryLastPageAction = @"coachmark.story.lastpage.action";
const NSString* PICoachmarkIdStoryLastPageBestComment = @"coachmark.story.lastpage.bestcomment";
const NSString* PICoachmarkIdStoryLastPageSeries = @"coachmark.story.lastpage.series";
const NSString* PICoachmarkIdBookmarkAction = @"coachmark.bookmark.action";


@implementation PICoachmarkManager


+ (void) showCoachmarkForGroupOfIds:(NSArray*) coachGroups
{
    if (![coachGroups isKindOfClass:[NSArray class]] || !coachGroups.count) {
        return;
    }

    
    NSMutableArray* screens = [NSMutableArray arrayWithCapacity:coachGroups.count];
    for (NSArray* coachGroup in coachGroups) {
        if (![coachGroup isKindOfClass:[NSArray class]]) {
            continue;
        }
        
        NSMutableArray* coachs = [NSMutableArray arrayWithCapacity:coachGroups.count];
        for (NSString* coachMarkId in coachGroup) {
            if ([self needShowCoachmarkForId:coachMarkId]) {

                id<PICoachmarkProtocol> coachMark = [self coachMarkForId:coachMarkId];
                [coachs addObject:coachMark];
                
                NSString* currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
                [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:coachMarkId];
                [[NSUserDefaults standardUserDefaults] synchronize];

            }
        }
        
        if (coachs.count) {
            PICoachmarkScreen* screen = [[PICoachmarkScreen alloc] initWithCoachMarks:coachs];
            [screens addObject:screen];
        }
    }
    
    if (screens.count) {
        UIWindow* window = [[UIApplication sharedApplication] keyWindow];
        PICoachmarkView *coachMarksView = [[PICoachmarkView alloc]
                                           initWithFrame:window.bounds];
        [window addSubview:coachMarksView];
        [coachMarksView setScreens:[NSArray arrayWithArray:screens]];
        [coachMarksView start];
    }
}

//------------------------------------------------------------------------------
+ (id<PICoachmarkProtocol>) coachMarkForId:(NSString*) coachMarkId
{
    
    // TODO: coach mark load dictionary with screen ratio variation
    // Ex: for ip 4, ip 5, ip 6 ...
    NSString* suffix = [self suffixForScreenType:[self currentScreenType]];
    
    NSString* fileWithSuffix = [NSString stringWithFormat:@"%@%@", coachMarkId, suffix];
    
    NSDictionary* coachMarkDict =
    [NSDictionary
     dictionaryWithContentsOfFile:[[NSBundle mainBundle]
                                   pathForResource:fileWithSuffix
                                   ofType:@"plist"]];
    
    // If there is no variation then try original
    if (!coachMarkDict) {
        coachMarkDict = [NSDictionary
                         dictionaryWithContentsOfFile:[[NSBundle mainBundle]
                                                       pathForResource:coachMarkId
                                                       ofType:@"plist"]];
        
    }
    
    // Still cannot load data, then give up
    if (!coachMarkDict) {
        return nil;
    }
    
    PIImageCoachmark* imageCoach = [[PIImageCoachmark alloc]
                                    initWithDictionary:coachMarkDict];
    return imageCoach;
}
//------------------------------------------------------------------------------
+ (BOOL) needShowCoachmarkForId:(NSString*)coachMarkId
{
    NSUserDefaults* userDefault = [NSUserDefaults standardUserDefaults];
    
    NSString* lastCoachedVersion = [userDefault objectForKey:coachMarkId];
    NSString* currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    if (!lastCoachedVersion || ![lastCoachedVersion isEqualToString:currentVersion]) {
        return YES;
    }
    return NO;
}
//------------------------------------------------------------------------------

+ (NSString*) suffixForScreenType:(PICoachmarkScreenType) screenType
{
    switch (screenType) {
        case PICoachmarkScreenType480h:
            return PICoachmarkScreenTypeSuffix480h;
            break;
        case PICoachmarkScreenType568h:
            return PICoachmarkScreenTypeSuffix568h;
            break;
        case PICoachmarkScreenType667h:
            return PICoachmarkScreenTypeSuffix667h;
            break;
            
        case PICoachmarkScreenType736h:
            return PICoachmarkScreenTypeSuffix736h;
            break;
            
        default:
            break;
    }
    return nil;
}
//------------------------------------------------------------------------------
+ (PICoachmarkScreenType) currentScreenType
{
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    if (screenBounds.size.height == PICoachmarkScreenType480h) return PICoachmarkScreenType480h;
    if (screenBounds.size.height == PICoachmarkScreenType568h) return PICoachmarkScreenType568h;
    if (screenBounds.size.height == PICoachmarkScreenType667h) return PICoachmarkScreenType667h;
    if (screenBounds.size.height == PICoachmarkScreenType736h) return PICoachmarkScreenType736h;
    return PICoachmarkScreenTypeUnknown;
}
@end
