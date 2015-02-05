//
//  PICoachmarkManager.h
//  NewPiki
//
//  Created by Pham Quy on 2/3/15.
//  Copyright (c) 2015 Pikicast Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* PICoachmarkIdHomeNavigationTitle;
extern NSString* PICoachmarkIdStoryCoverInfo;
extern NSString* PICoachmarkIdStoryCoverBgm;
extern NSString* PICoachmarkIdStoryCoverShare;
extern NSString* PICoachmarkIdStoryCardList;
extern NSString* PICoachmarkIdStoryCardPanorama;
extern NSString* PICoachmarkIdStoryLastPageAction;
extern NSString* PICoachmarkIdStoryLastPageBestComment;
extern NSString* PICoachmarkIdStoryLastPageSeries;
extern NSString* PICoachmarkIdBookmarkAction;

@interface PICoachmarkManager : NSObject

/**
 Show coachmarks for list of coarch marks group
 
 @param coachGroups array of groups of coachmarks
 
 @discussion `coachGroups` contain a array of array. Each subarray contain coachmark ids, a group of coachmarks will be shown as in the same screen.
 
 @example [[leftBar, rightbar],[tabbar1, tabbar2, tabbar3]]
 */

+ (void) showCoachmarkForGroupOfIds:(NSArray*) coachGroups;

+ (BOOL) needShowCoachmarkForId:(NSString*)coachMarkId;
@end
