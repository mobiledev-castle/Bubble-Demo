//
//  Macro.h
//  MySportalent
//
//  Created by Mountain on 5/11/13.
//  Copyright (c) 2013 Mountain. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SCRN_WIDTH		[[UIScreen mainScreen] bounds].size.width
#define SCRN_HEIGHT		[[UIScreen mainScreen] bounds].size.height
#define IS_PHONE5 SCRN_HEIGHT > 480 ? TRUE:FALSE
#define APPDELEGATE [AppDelegate sharedDelegate]
    
//#define SERVER_URL  @"http://192.168.150.90/instagram"
#define SERVER_URL  @"http://www.cpaticker.com/ticker/api"
#define AVATAR_URL  @"http://mysportalent.com/instagram/data/profile"

// Local Notification
#define kNotiDismissCam     @"DismissCam"
#define kNotiCloseCamGate   @"CloseCamGate"
#define kNotiOpenCamGate    @"OpenCamGate"
#define kNotiNewEventAdded  @"NewEventAdded"

#define kLangChn    1
#define kLangEng    2
#define kLangFrn    3

#define kAdmobUnitId  @"/6253334/dfp_example_ad"

#define kCateHappyhour          10001
#define kCateElectronic         10002
#define kCateClothes            10003
#define kCateBaby               10004
#define kCateHouse              10005
#define kCateSport              10006    
#define kCateNone               10000

#define VAL_CAMPAIGN             @"Campaign"
#define VAL_CLICKS             @"Clicks"
#define VAL_CONVERSIONS             @"Conversions"
#define VAL_COST             @"Cost"
#define VAL_PROFIT             @"Profit"

typedef enum{
	EPostCateRestaurant = 0,
	EPostCatePubs,
    EPostCateNews,
    EPostCateShops,
    EPostCateEvents
} EPostCategory;

@interface Macro : NSObject

@end
