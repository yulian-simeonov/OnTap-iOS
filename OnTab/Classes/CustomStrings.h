//
//  CustomStrings.h
//  StyledFriend
//
//  Created by Jeon Jun-kyu on 8/14/12.
//  Copyright (c) 2012 orfeostory.inc. All rights reserved.
//

#pragma mark - Values

#define kMaxLengthEmail                         128
#define kMaxLengthPassword                      16
#define kMaxLengthUsername                      32
#define kMaxLengthTagline                       20
#define kMaxLengthFavBrand                      20
#define kMaxLengthTag                           20

#define kMinLengthEmail                         5
#define kMinLengthPassword                      4
#define kMinLengthUsername                      1
#define kMinLengthTagline                       1
#define kMinLengthFavBrand                      1


#pragma mark - Titles

#define kTitle_DONTTEATALONE                NSLocalizedString(@"DONT'T EAT ALONE", nil)
#define kTitle_CREATE                       NSLocalizedString(@"CREATE", nil)
#define kTitle_MESSAGE                      NSLocalizedString(@"MESSAGE", nil)
#define kTitle_SIGNUP                       NSLocalizedString(@"SIGN UP", nil)
#define kTitle_ME                           NSLocalizedString(@"ME", nil)
#define kTitle_SETTING                      NSLocalizedString(@"SETTING", nil)
#define kTitle_ACCOUNT                      NSLocalizedString(@"ACCOUNT", nil)
#define kTitle_PASSWORD                     NSLocalizedString(@"PASSWORD", nil)
#define kTitle_ABOUTUS                      NSLocalizedString(@"ABOUT US", nil)
#define kTitle_MAP                          NSLocalizedString(@"WHAT'S WHERE", nil)
#define kTitle_ADDLOCATION                  NSLocalizedString(@"ADD LOCATION", nil)
#define kTitle_SEARCHUSER                   NSLocalizedString(@"SEARCH USER", nil)

#define kTitle_Error                        NSLocalizedString(@"Error", nil)
#define kTitle_Complete                     NSLocalizedString(@"Complete", nil)


#pragma mark - Texts

#define kText_OKay                          NSLocalizedString(@"OK", nil)
#define kText_Confirm                       NSLocalizedString(@"Confirm", nil)
#define kText_Cancel                        NSLocalizedString(@"Cancel", nil)
#define kText_Camera                        NSLocalizedString(@"Camera", nil)
#define kText_Library                       NSLocalizedString(@"Library", nil)
#define kText_DeletePicture                 NSLocalizedString(@"Delete Picture", nil)
#define kText_StoryAlbum                    NSLocalizedString(@"Story Album", nil)


#pragma mark - Messages

#define kMessage_ChatReqMsg                 NSLocalizedString(@"I would like to chat with you now", nil)
#define kMessage_ChatReqSent                NSLocalizedString(@"Your request has been sent. Please wait until he accepts your request.", nil)
#define kMessage_PostingDone                NSLocalizedString(@"Successfully posted", nil)
#define kMessage_GotOutChat                 NSLocalizedString(@"Do you want to end this chat?", nil)



#define kMessage_NotSamePwd                 NSLocalizedString(@"Please confirm password", nil)
#define kMessage_NotCorrectOldPwd           NSLocalizedString(@"Old password is not correct", nil)
#define kMessage_NoPosts                    NSLocalizedString(@"There is no places now", nil)
#define kMessage_NoNewPosts                 NSLocalizedString(@"No new places more", nil)
#define kMessage_InputAllField              NSLocalizedString(@"Please input all fields", nil)
#define kMessage_NoComment                  NSLocalizedString(@"Please enter your comment", nil)
#define kMessage_Logout                     NSLocalizedString(@"Logout Successfully", nil)
#define kMessage_CreatedAccount             NSLocalizedString(@"Your account has successfully created", nil)
#define kMessage_UpdatedAccount             NSLocalizedString(@"Your account has successfully updated", nil)
#define kMessage_NoEmail                    NSLocalizedString(@"Please enter your email", nil)
#define kMessage_NoName                     NSLocalizedString(@"Please enter your name\n(Username min 1 max 32)", nil)
#define kMessage_NoPassword                 NSLocalizedString(@"Please enter your Password\n(password min 4 max 16)", nil)
#define kMessage_InvalidEmail               NSLocalizedString(@"Email is invalid", nil)
#define kMessage_EmailSent                  NSLocalizedString(@"Temporary password sent via your email", nil)
#define kMessage_WrongPassword              NSLocalizedString(@"Password is wrong", nil)
#define kMessage_InconsistencyPassword      NSLocalizedString(@"Password Inconsistency", nil)
#define kMessage_UnableTagline              NSLocalizedString(@"Unable to use your tag line\n(tag line min 1 max 20)", nil)
#define kMessage_UnableFavBrand             NSLocalizedString(@"Unable to use your favourite brand\n(favourite brand min 1 max 20)", nil)
#define kMessage_UnableTag                  NSLocalizedString(@"Unable to use your tag\n(tag min 1 max 20)", nil)

#define kMessage_ConfirmLogout              NSLocalizedString(@"Do you want to logout?", nil)
#define kMessage_ConfirmDelete              NSLocalizedString(@"Do you want to delete your account?", nil)
#define kMessage_SendTempPassword           NSLocalizedString(@"Temp password sent to your email", nil)
#define kMessage_ProfileEditDone            NSLocalizedString(@"Modification Complete", nil)
#define kMessage_DeletePost                 NSLocalizedString(@"Do you want to delete this post?", nil)
#define kMessage_DeleteComment              NSLocalizedString(@"Do you want to delete this comment?", nil)
#define kMessage_NoText                     NSLocalizedString(@"Please enter your text.", nil)
#define kMessage_NetworkFailed              NSLocalizedString(@"Network Connection Failed", nil) 
#define kMessage_Keywords                   NSLocalizedString(@"Keywords must be at least 4 characters.", nil)

#define kMessage_WeiboNeedLogin             NSLocalizedString(@"To sending your post to Weibo,\nyou need a Weibo account.\nPlease login Weibo on Settings tab.", nil)
#define kMessage_WeiboNotAuth               NSLocalizedString(@"No Weibo authorization.\nPlease try to login Weibo again.", nil)
#define kMessage_WeiboExpired               NSLocalizedString(@"Weibo authorization is expired.\nPlease try to login Weibo again.", nil)
#define kMessage_WeiboFailed                NSLocalizedString(@"Sending the post to Weibo is failed.\nPlease try again.", nil)

#define kMessage_LikePicutre                NSLocalizedString(@"likes your picture.", nil)
#define kMessage_CommentPicture             NSLocalizedString(@"comments on your picture.", nil)
#define kMessage_RequestFriend              NSLocalizedString(@"wants to be your friend.", nil)
#define kMessage_AcceptFriend               NSLocalizedString(@"accepts you as a friend.", nil)

#define kMessage_OverByte                   NSLocalizedString(@"Unable to upload the image which is over 1MB. Do you want to upload resized image?", nil)

#define kMessage_UnableMailing              NSLocalizedString(@"Please send your feedback to us : admin@styledfriend.com", nil)
#define kMessage_MailFailed                 NSLocalizedString(@"Sending the feedback is failed", nil)
#define kMessage_MailSaved                  NSLocalizedString(@"The feedback saved in the drafts folder in Mails", nil)
#define kMessage_MailSend                   NSLocalizedString(@"Thank you for sending a feedback. We'll reply it very soon.", nil)
#define kMessage_MailDefault                NSLocalizedString(@"The feedback not sent.", nil)


#pragma mark - Specific Datas

#define kPickerData_Beijing                 NSLocalizedString(@"Beijing", nil)
#define kPickerData_Shanghai                NSLocalizedString(@"Shanghai", nil)
#define kPickerData_Guangzhou               NSLocalizedString(@"Guangzhou", nil)
#define kPickerData_Shenzhen                NSLocalizedString(@"Shenzhen", nil)
#define kPickerData_Chengdu                 NSLocalizedString(@"Chengdu", nil)
#define kPickerData_Chongqing               NSLocalizedString(@"Chongqing", nil)
#define kPickerData_Nanjing                 NSLocalizedString(@"Nanjing", nil)
#define kPickerData_Tianjin                 NSLocalizedString(@"Tianjin", nil)
#define kPickerData_Hangzhou                NSLocalizedString(@"Hangzhou", nil)
#define kPickerData_Shenyang                NSLocalizedString(@"Shenyang", nil)
#define kPickerData_Qingdao                 NSLocalizedString(@"Qingdao", nil)
#define kPickerData_Fuzhou                  NSLocalizedString(@"Fuzhou", nil)
#define kPickerData_Wenzhou                 NSLocalizedString(@"Wenzhou", nil)
#define kPickerData_Xian                    NSLocalizedString(@"Xi'an", nil)
#define kPickerData_Harbin                  NSLocalizedString(@"Harbin", nil)
#define kPickerData_Weihai                  NSLocalizedString(@"Weihai", nil)
#define kPickerData_Taiyuan                 NSLocalizedString(@"Taiyuan", nil)
#define kPickerData_Zhengzhou               NSLocalizedString(@"Zhengzhou", nil)
#define kPickerData_Hefei                   NSLocalizedString(@"Hefei", nil)
#define kPickerData_Wuhan                   NSLocalizedString(@"Wuhan", nil)
#define kPickerData_Nanchang                NSLocalizedString(@"Nanchang", nil)
#define kPickerData_Changsha                NSLocalizedString(@"Changsha", nil)
#define kPickerData_Guiyang                 NSLocalizedString(@"Guiyang", nil)
#define kPickerData_Kunming                 NSLocalizedString(@"Kunming", nil)
#define kPickerData_Lanzhou                 NSLocalizedString(@"Lanzhou", nil)
#define kPickerData_Daqing                  NSLocalizedString(@"Daqing", nil)
#define kPickerData_Urimqi                  NSLocalizedString(@"Urimqi", nil)
#define kPickerData_OtherCitiesInChina      NSLocalizedString(@"Other cities in China", nil)
#define kPickerData_Taiwan                  NSLocalizedString(@"Taiwan", nil)
#define kPickerData_Hongkong                NSLocalizedString(@"Hongkong", nil)
#define kPickerData_Singapore               NSLocalizedString(@"Singapore", nil)
#define kPickerData_OtherOverseasContries   NSLocalizedString(@"Other overseas contries", nil)

#define kPickerDataCities       [[NSArray alloc] initWithObjects:kPickerData_Beijing, kPickerData_Shanghai, kPickerData_Guangzhou, kPickerData_Shenzhen, kPickerData_Chengdu, kPickerData_Chongqing, kPickerData_Nanjing, kPickerData_Tianjin, kPickerData_Hangzhou, kPickerData_Shenyang, kPickerData_Qingdao, kPickerData_Fuzhou, kPickerData_Wenzhou, kPickerData_Xian, kPickerData_Harbin, kPickerData_Weihai, kPickerData_Taiyuan, kPickerData_Zhengzhou, kPickerData_Hefei, kPickerData_Wuhan, kPickerData_Nanchang, kPickerData_Changsha, kPickerData_Guiyang, kPickerData_Kunming, kPickerData_Lanzhou, kPickerData_Daqing, kPickerData_Urimqi, kPickerData_OtherCitiesInChina, kPickerData_Taiwan, kPickerData_Hongkong, kPickerData_Singapore , kPickerData_OtherOverseasContries, nil];

#define kPickerData_incomeData_1            NSLocalizedString(@">RMB50000", nil)
#define kPickerData_incomeData_2            NSLocalizedString(@">RMB100000", nil)
#define kPickerData_incomeData_3            NSLocalizedString(@">RMB200000", nil)
#define kPickerData_incomeData_4            NSLocalizedString(@">RMB500000", nil)

#define kPickerDataIncomeRanges [[NSArray alloc] initWithObjects:kPickerData_incomeData_1, kPickerData_incomeData_2, kPickerData_incomeData_3, kPickerData_incomeData_4, nil];

#define kSegment_All                        NSLocalizedString(@"All", nil)
#define kSegment_MyFriends                  NSLocalizedString(@"My Friends", nil)
#define kSegment_Featured                   NSLocalizedString(@"Featured", nil)
#define kSegment_Friends                    NSLocalizedString(@"Friends", nil)
#define kSegment_Search                     NSLocalizedString(@"Search", nil)
#define kSegment_Request                    NSLocalizedString(@"Request", nil)

#define kCategory_Work                      NSLocalizedString(@"Work", nil)
#define kCategory_NightOut                  NSLocalizedString(@"Night Out", nil)
#define kCategory_Event                     NSLocalizedString(@"Event", nil)
#define kCategory_Vacation                  NSLocalizedString(@"Vacation", nil)
#define kCategory_Casual                    NSLocalizedString(@"Casual", nil)

#define kStatusText_PublicSetting_1         NSLocalizedString(@"* 'Open to Public' shows photo to everyone,", nil)
#define kStatusText_PublicSetting_2         NSLocalizedString(@"* 'Open to Friends' shows photo to only friends.", nil)
#define kStatusText_Public                  NSLocalizedString(@"Open to Public", nil)
#define kStatusText_Friends                 NSLocalizedString(@"Open to Friends", nil)

#define kCommonText_Notice1                 NSLocalizedString(@"Please enter your email", nil)
#define kCommonText_Notice2                 NSLocalizedString(@"* Email & Password are used for login", nil)
#define kCommonText_Notice3                 NSLocalizedString(@"Please enter your username", nil)
#define kCommonText_Notice4                 NSLocalizedString(@"Please enter your password", nil)
#define kCommonText_Notice4_1               NSLocalizedString(@"Please enter your new password", nil)
#define kCommonText_Notice5                 NSLocalizedString(@"Please confirm your password", nil)
#define kCommonText_Notice5_1               NSLocalizedString(@"Please confirm your new password", nil)
#define kCommonText_Notice6                 NSLocalizedString(@"* StyledFriend membership will provide you with more benefits", nil)
#define kCommonText_Notice7                 NSLocalizedString(@"* Below is not required for signing up, but for membership", nil)
#define kCommonText_Notice8                 NSLocalizedString(@"You'll get password from this email", nil)

#define kCommonText_Email                   NSLocalizedString(@"Email", nil)
#define kCommonText_UserName                NSLocalizedString(@"Username", nil)
#define kCommonText_Password                NSLocalizedString(@"Password", nil)
#define kCommonText_ConfirmPassword         NSLocalizedString(@"Confirm Password", nil)
#define kCommonText_Gender                  NSLocalizedString(@"Gender", nil)
#define kCommonText_Male                    NSLocalizedString(@"Male", nil)
#define kCommonText_Female                  NSLocalizedString(@"Female", nil)
#define kCommonText_Birthday                NSLocalizedString(@"Birthday", nil)
#define kCommonText_Occupation              NSLocalizedString(@"Occupation", nil)
#define kCommonText_AnnualIncome            NSLocalizedString(@"Annual Income", nil)
#define kCommonText_User                    NSLocalizedString(@"User", nil)
#define kCommonText_Tagline                 NSLocalizedString(@"Category", nil)
#define kCommonText_FavouriteBrands         NSLocalizedString(@"Favourite Brand", nil)
#define kCommonText_Location                NSLocalizedString(@"Location", nil)
#define kCommonText_Category                NSLocalizedString(@"Category", nil)
#define kCommonText_Brand                   NSLocalizedString(@"Brand", nil)
#define kCommonText_Points                  NSLocalizedString(@"points", nil)
#define kCommonText_Photos                  NSLocalizedString(@"photos", nil)
#define kCommonText_Friends                 NSLocalizedString(@"friends_s", nil)
#define kCommonText_Point                   NSLocalizedString(@"Point", nil)

#define kCommonText_Profile                 NSLocalizedString(@"Profile", nil)
#define kCommonText_Notice                  NSLocalizedString(@"Notice", nil)
#define kCommonText_HelpDesk                NSLocalizedString(@"Help Desk", nil)
#define kCommonText_Weibo                   NSLocalizedString(@"Weibo", nil)
#define kCommonText_Friends_L               NSLocalizedString(@"Friends", nil)
#define kCommonText_Account                 NSLocalizedString(@"Account", nil)
#define kCommonText_Notifications           NSLocalizedString(@"Notifications", nil)
#define kCommonText_Feedback                NSLocalizedString(@"Feedback", nil)
#define kCommonText_Version                 NSLocalizedString(@"Version", nil)

#define kCommonText_Logout                  NSLocalizedString(@"Logout", nil)
#define kCommonText_DeleteAccount           NSLocalizedString(@"Delete Account", nil)
#define kCommonText_TermsOfUse              NSLocalizedString(@"Terms of Use", nil)

#define kMessage_PullDownToRefresh          NSLocalizedString(@"Pull down to refresh...", nil)
#define kMessage_PullDownToRefreshStatus    NSLocalizedString(@"Pull down to refresh status", nil)
#define kMessage_ReleaseToRefresh           NSLocalizedString(@"Release to refresh", nil)
#define kMessage_LastUpdated                NSLocalizedString(@"Last updated: ", nil)

#define kTermsOfUse                         NSLocalizedString(@"1. GENERAL  By installing the Application (as defined below), you agree to be bound by these terms of use (“appterms”). Please review them carefully before installation and/or acceptance.\n\n2. DEFINITIONS The “Application” shall mean the software provided by Styledfriend to offer services related to Styledfriend, Styledfriend’s services and its partners’ services, to be used on Apple iOS device and any upgrades from time to time and any other software or documentation which enables the use of the Application.\n\n3. DATA PROTECTION Any personal information you supply to Styledfriend when using the Application will be used by Styledfriend in accordance with its Privacy Policy.\n\n4. User Terms Styledfriend, allows its registered members to create mobile photo albums by uploading image files to Styledfriend servers. As a Styledfriend member you agree to receive periodic emails from Styledfriend containing information about new features and service options and/or periodic information about special promotions.\n\nStyledfriend is not responsible for content posted by Styledfriend members. Styledfriend does not verify or endorse any content posted by its members. Styledfriend is not responsible for the delivery or quality of any goods or services that are advertised by its members on Styledfriend. If you believe that any of the content posted by Styledfriend members or visitors violates your proprietary rights including copyrights please report it by email.\n\nYou must be at least 13 years old to sign up as a Styledfriend member. As a Styledfriend member you are solely and fully responsible for any content posted by you to your Styledfriend account. Although we review member account content on a spot check basis we cannot establish nor guarantee the legal nature of any such content. We prohibit the posting of the following content in any member account:\n\n• Nudity, pornography, and sexual material of a lewd, lecherous or obscene nature or intent or that violates local, state or national laws.\n\n• Any material that violates or infringes in any way upon the proprietary rights of others including, without limitation, copyright or trademark rights.\n\n• Any material that is threatening, abusive, harassing, slanderous, defamatory, invasive of privacy or publicity rights, vulgar, obscene, profane, indecent, or otherwise objectionable including posting private information belonging to or about other individuals.\n\n• Content that promotes, encourages, or provides instructional information about illegal activities.\n\n• Hate propaganda or hate mongering, swearing, or fraudulent material or activity.\n\nBy submitting your photos to Styledfriend, you represent that the photos, titles and descriptions comply with the Terms and Conditions of Use set forth in this section. If any third party brings a claim, lawsuit or other proceeding against Styledfriend based on content you post on Styledfriend, you agree to compensate Styledfriend including its officers, directors, employees and agents for any and all losses, liabilities, damages or expenses including attorney's fees incurred by Styledfriend in connection with any such claim, lawsuit or proceeding.\n\nStyledfriend is the final arbiter of what is allowed and not allowed on the Styledfriend website. If a portion of the content in an account is found to be in violation of the Terms and Conditions of Use set forth in this section, the entire account may be removed. If the account is a paid membership account, there will be no refunds for accounts that have been deleted due to violation of the Styledfriend Terms and Conditions of Use set forth in this section.\n\nStyledfriend reserves the right to modify or remove any content in a member account or to delete a member account at any time without prior notice if that account violates the Terms and Conditions of Use set forth in this section.\n\nStyledfriend is not responsible for any financial or personal loss to members using their Styledfriend accounts for business or any other purpose for any reason including but not limited to server down situations and accidental or wilful deletion of member accounts and/or contents of said accounts.\n\nImages stored on Styledfriend servers are for online photo sharing purposes and not meant for permanent or temporary archival purposes. Therefore, Styledfriend is not obligated to maintain back-up copies of any material submitted or posted on Styledfriend; this policy applies to free basic accounts as well as to paid membership accounts.\n\nStyledfriend is not responsible or liable for any monetary losses incurred by members using their accounts for either personal or business, marketing or any other commercial purpose for any reason including but not limited to server malfunction, server crashes or software related problems.\n\n\n\n© David.Mich Pte.Ltd.-Styledfriend 2013 All Rights Reserved", nil)