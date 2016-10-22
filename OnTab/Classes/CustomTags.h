//
//  CustomTags.h
//  StyledFriend
//
//  Created by Jeon Jun-kyu on 8/14/12.
//  Copyright (c) 2012 orfeostory.inc. All rights reserved.
//

//  GUIDE LINE
//
//  1000 - Local components
//  100 - Common components
//  200 - AlertViews

#pragma mark - Common Component Tags

#define kTagNaviBarView                 100
#define kTagNaviBarItemLeft             101
#define kTagNaviBarItemRight            102
#define kTagNaviBarTitleLabel           103



#pragma mark - UIAlertView Tags

#define kTagAlertViewNoEmail            200
#define kTagAlertViewNoPassword         201


#define kBtnStatusCellLeft              301
#define kBtnStatusCellRight             302
#define kViewStatusCellLeft             303
#define kViewStatusCellRight            304


// ----------------------------------------- Remote Notification Id ----------------------------------------------//

#define kRemoteNotiGotChatReq               1991
#define kRemoteNotiGotReqAccepted           1992
#define kRemoteNotiGotChatMsg               1993
#define kRemoteNotiGotQuitChat              1994


// ---------------------------------------------------------------------------------------------------------------//

#define APPDELEGATE [AppDelegate sharedAppDelegate]
#define SHAREDMANAGER [SharedManager sharedManager]

#define kClientId                           @"39627c2e844143a5f2e0538be018cd3e1693ac8e1a10d299bfe738b3f54a40cc"
#define kSecretId                           @"6dc9443a62e57875c6858242971a5fa183c78fa89ba2d349b61100f2ebac5298"

#define kBaseUrl                            @"http://50.22.168.74/DontEatAlone/"
//#define kBaseUrl                          @"http://localhost:8080/StyledFriendWeb/api/"
#define kAPI_Login                          @"/api/index.php?action=login"
#define kAPI_Register                       @"/api/index.php?action=register"
#define kAPI_Updateprofile                  @"/api/index.php?action=update_profile"
#define kAPI_Getfeed                        @"/api/index.php?action=get_feed"
#define kAPI_PostPlace                      @"/api/index.php?action=post_place"
#define kAPI_GetProfile                     @"/api/index.php?action=user_detail"
#define kAPI_GetUser                        @"/api/index.php?action=get_user"
#define kAPI_RequireChat                    @"/api/index.php?action=require_chat"
#define kAPI_GetChatReqs                    @"/api/index.php?action=recieve_requirements"
#define kAPI_SetReadToReq                   @"/api/index.php?action=set_read_to_requirement"
#define kAPI_SendChat                       @"/api/index.php?action=send_chat"
#define kAPI_QuitChat                       @"/api/index.php?action=quit_chat"


//-----------------------------------------  New App Development ----------------------------------------------//

#define kNotiAddPostImage               @"kNotiAddPostImage"
#define kNotiSignout                    @"kNotiSignout"
#define kNotiLoggedIn                   @"kNotiLoggedIn"
#define kNotiGotDeviceToken             @"kNotiGotDeviceToken"
#define kNotiFailedDeviceToken          @"kNotiFailedDeviceToken"
#define kNotiGotChatMsg                 @"kNotiGotChatMsg"
#define kNotiGotQuitChat                @"kNotiGotQuitChat"

#define SCRN_WIDTH		[[UIScreen mainScreen] bounds].size.width
#define SCRN_HEIGHT		[[UIScreen mainScreen] bounds].size.height
#define IS_PHONE5 SCRN_HEIGHT > 480 ? TRUE:FALSE
#define APPDELEGATE [AppDelegate sharedAppDelegate]

//-----------------------------------------------------------------------------------------------------------------//

typedef enum {
    StatusCategoryWork = 0,
    StatusCategoryNightOut,
    StatusCategoryVacation,
    StatusCategoryEvent,
    StatusCategoryCasual,
    StatusCategoryCount
} StatusCategory;
