//
//  Constant.h
//  FamilyRecipe
//
//  Created by Tnu on 5/30/16.
//  Copyright © 2016 perceptionsystem. All rights reserved.
//

#ifndef Constant_h
#define Constant_h
//=====DEVICE CONSTANT DEFINE=====//
#define isRetinaDisplay [[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] >= 2.0
#define TEXT_NORMAL_FONTSIZE [UIFont systemFontOfSize:20.0]
#define TEXT_NORMAL_FONTSIZE_BOLD [UIFont boldSystemFontOfSize:20.0]
#define COLOR_GRAY [UIColor grayColor]
#define COLOR_BORDER_NAME @"DFDFDF"
#define COLOR_BACKGROUND_NAME @"f4f4f4"
//================================//
#define APP_NAME @"MyPlate"
#define GOOGLE_PLUS_CLIENT_ID @"1058137937069-kf3gskfr0j6daqn5521qvg3r0pij1dog.apps.googleusercontent.com"
#define kBaseURL @"http://khaosatdiachat.com:8887/api/"  //Live URL

#define kNoInternetConnection  @"Please check your internet connection."
#define kServerUnavailableMessage @"Well this is embarrassing. There was an error processing your request. Please try again later."
#define kTypeUnavailableMessage @"There is problem in fetching Recipe list"
#define kLoginRequiredMessagee @"Ooops, you need to be logged in to access this feature."
#define appFbId @"1724210554508396"

#define ALERT_LOADING @"Loading..."
#define ALERT_SAVING @"Saving..."
#define ALERT_VERIFY @"We have sent an email to the email address provided please click on the link in the email provided to verify your account."
#define ALERT_RESET_PASSWORD @"Ooops. The plate with your password on it seems to have broken. We will send you a link to create a new plate. Please check your email and follow the recipe to reset your password."
#define ALERT_UPDATE_OKE @"Your account is updated successfully"
#define ALERT_CONFIRM_LOGOUT @"Do you want to log out?"
#define ALERT_CONFIRM_LEAVE_GROUP @"Do you want to leave this group?"
#define ALERT_CHANGE_PASSWORD_SUCCESSFULLY @"Your Password was Changed Successfully."
#define ALERTVIEW_TITLE @"MyPlate"
#define ALERTVIEW_ERROR @"Error"
#define ALERT_UPDATE_CIRCLE @"Update circle successfully"
#define ALERT_ADD_NON_FRIEND_IN_GROUP @"Please select Friends!"
#define ALERT_EMPTY_GROUP_NAME @"Please enter a Group Name!"
#define ALERT_EMPTY_MY_NAME_IN_GROUP @"Please enter a My name in Group!"
#define kOther @"others"
#define kRecipe @"Recipe"
#define kTitleEmail @"MyPlate Recipe for you:"
#define kContentEmail1 @"<p>Hello,</p><p>I found this great recipe that I thought you might like. Click on the link below to download the MyPlate app to view it.</p>"
#define kContentEmail2 @"<p>I think you will like it.</p>"


#define REMEMBER_ME @"Remember_me"
#define LOGGED_IN @"Logged_in"
#define OK_BUTTON @"OK"
#define FILE_IMAGE_EXTENSION @"png"
#define USER_TOKEN "user_token"


#pragma mark - table name 

#define TABLE_USER @"EnUser"
#define TABLE_RECIPE @"EnRecipe"
#define TABLE_RECIPE_VOS @"EnRecipeVos"
#define TABLE_INGREDIENT_VOS @"EnIngredienVos"
#define TABLE_DIRECTION_VOS @"EnDirectionVos"
#define TABLE_RECIPE_TYPE @"EnRecipeType"
#define TABLE_RECIPE_STEP @"EnRecipeStep"
#define TABLE_RECIPE_INGREDIENT @"EnRecipeIngredient"
#define TABLE_RECIPE_OPTIONAL_INGREDIENT @"EnRecipeOptinalIngredient"
#define TABLE_RECIPE_CATEGORY @"EnRecipeCategory"

#pragma size

#define kSIZE_STANDARD_BAR 64


#pragma mark - segue

#define SEGUE_ADD_FRIEND @"GoToAddFriendVC"
#define kSEGUE_MANAGE_CIRCLE @"GoToManageCircleVC"
#define kSEGUE_CIRCLE_SEARCH @"GoToCircleSearchVC"


#pragma mark - gender

#define GENDER_MALE_VALUE @"M"
#define GENDER_FEMALE_VALUE @"F"
#define ITEM_DONE @"Done"


#pragma mark - error

#define ERROR_EMPTY_EMAIL @"Please enter email address."
#define ERROR_EMPTY_PASSWORD @"Please enter password."
#define ERROR_EMPTY_VALID_EMAIL @"Please enter valid email address."
#define ERROR_EMPTY_FIRSTNAME @"Please enter first name."
#define ERROR_EMPTY_LASTNAME @"Please enter last name."
#define ERROR_EMPTY_BIRTH_DATE @"Please enter birth date."
#define ERROR_EMPTY_HOMWTOWN @"Please enter home town."
#define ERROR_PASSWORD_NUBER_CHARACTERS @"Password should be at least 6 characters long."
#define ERROR_INTERNET @"Well this is embarrassing. There was an error processing your request. Please try again later."
#define ERROR_RESET_PASSWORD @"Well this is embarrassing. There was an error processing your request. Please try again later."
#define ERROR_PROCESS_JOIN @"Well this is embarrassing. There was an error processing your request. Please try again later."
#define ERROR_AURHORIZED @"You are not autorized to access the application."
#define ERROR_CHANGE_PASSWORD_EMPTY_CURRENT_PASSWORD @"Please enter current password."
#define ERROR_CHANGE_PASSWORD_EMPTY_NEW_PASSWORD @"Please enter new password."
#define ERROR_CHANGE_PASSWORD_EMPTY_CONFIRM_PASSWORD @"Please enter confirm password."
#define ERROR_CHANGE_PASSWORD_NOT_MATCH @"New password and repeat password do not match."
#define ERROR_NO_CAMERA @"No camera available"
#define ERROR_SERVER @"Server error"
#define PROGRESS_SAVING @"Saving......"
#define PROGRESS_LOADING @"Loading......"


#pragma mark - uri

#define URI_SIGN_UP @"user/signup"
#define URI_LOG_IN @"%@user/login"
#define URI_RESET_PASSWORD @"user/resetPassword"
#define URI_CHECK_FB_ID @"%@user/checkfbID"
#define URI_LOGIN_FACEBOOK @"%@user/loginwithFB"
#define URI_GET_FILTERED_RECIPE @"%@/category/getFilteredRecipe"
#define URI_GET_SUB_CATEGORY @"%@/category/getSubCategoryList"
#define URI_CHANGE_PASSWORD @"user/changePassword"
#define kURI_SHARE_RECIPE @"%@share/updateRecipeShare"
#define kURI_SHARE_POST @"%@shareP/updatePostShare"
#define URI_UPDATE_PROFILE @"user/editUserProfile"
#define URI_UPDATE_AVATA @"image/uploadImage"
#define kURI_ADD_NEW_COMMENT @"comment/add"
#define kURI_GET_LIST_FRIEND_USER @"relationship/getListFriends"
#define kURI_ADD_NEW_FRIEND @"relationship/add"
#define kURI_ADD_MULTIPLE_FRIEND @"relationship/saveMultiple"
#define kURI_GET_USER_BY_NAME @"relationship/getUserByName"
#define kURI_SEARCH_USER_BY_NAME @"relationship/searchFriend"
#define kURI_SEARCH_USER_TO_ADD @"relationship/getUserNotFriend"
#define kURI_GET_GROUP_BY_USER @"circle/getAllGroup"
#define kURI_GET_USER_TO_ADD_GROUP @"relationship/getUserToGroup"
#define kURI_SAVE_MULTIPLE_GROUP @"group/addMultipleUser"
#define kURI_ADD_MULTIPLE_FRIENDS @"relationship/addMultipleFriend"
#define kURI_GET_CIRCLE_BY_ID @"circle/getGroupDetails"
#define kURI_CREATE_CIRCLE @"circle/createGroup"
#define kURI_UPDATE_GROUP_NAME @"circle/updateGroup"
#define kURI_UPDATE_GROUP @"group/updateInfoInGroup"
#define kURI_LEAVE_GROUP @"group/leaveGroup"
#define kURI_COUNT_NOTICES @"notify/countNotices"
#define kURI_GET_ALL_NOTICES @"notify/getAllNotices"
#define kURI_GET_NOTICE @"notify/getNoticeDetail"
#define kURI_GET_ALL_COMMENTS @"comment/getAllComments"
#define kURI_GET_ALL_POST_COMMENTS @"postComment/getAllComments"
#define kURI_DELETE_COMMENT @"comment/remove"
#define kURI_LIKE_RECIPE @"like/add"
#define kURI_GET_ALL_RECIPES @"recipe/getRecipesUserwise"
#define kURI_GET_ALL_SHOPPING_LIST @"shopping/getShoppingLists"
#define kURI_ADD_SHOPPING_LIST @"shopping/add"
#define kURI_GET_DETAIL_SHOPPING_LIST @"shopping/getItemDetail"
#define kURI_ADD_INGREDIENT_ITEM @"shopMapping/addItem"
#define kURI_DELETE_INGREDIENT_ITEM @"shopMapping/delete"
#define kURI_DELETE_MUTIPLE_SHOPPINGS @"shopping/multipledelete" 
#define kURI_UPDATE_SHOPPING_MAPPING @"shopMapping/update"
#define kURI_UPDATE_PRIVACY @"user/editUserProfile"
#define kURI_LIKE_COMMENT @"comment/like"
#define kURI_LIKE_POST_COMMENT @"postComment/like"
#define kURI_GET_USER_DETAIL @"user/getUserById"
#define kURI_GET_NEW_FEED_HOME @"home/getNewFeeds"
#define kURI_GET_COUNT_HOME @"home/refreshCountHome"
#define kURI_GET_POPULAR_HOME @"home/refreshListPopular"
#define kURI_GET_LATEST_HOME @"home/refreshListLatest"
#define kURI_GET_LATEST_AGAIN_HOME @"home/loadListLatest"


#pragma mark - PARAM

#define PARAM_NAME_EMAIL @"email"
#define PARAM_NAME_PASSWORD @"password"
#define PARAM_FIRSTNAME @"firstname"
#define PARAM_LASTNAME @"lastname"
#define PARAM_DATE @"date"
#define PARAM_GENDER @"gender"
#define PARAM_HOMETOWN @"hometown"
#define PARAM_PROFILE_PIC @"profilepic"
#define PARAM_FACEBOOK_ID @"facebookId"
#define PARAM_DATE @"date"
#define PARAM_RESPONSE @"responseVo"
#define PARAM_USER_RESPONSE @"userVo"
#define PARAM_COMMENT_RESPONSE @"recipeCommentVos"
#define PARAM_ERROR @"error"
#define PARAM_USER_ID @"userId"
#define PARAM_MESSAGE @"message"
#define PARAM_ERROR @"error"
#define PARAM_AVATA @"imageValue"
#define PARAM_GENDER @"gender"
#define PARAM_UPDATE_IMAGE_USER_ID @"userId"


#pragma mark - me

#define TITLE_ME_UPDATE_AVATA @"Update avatar"
#define OPTION_CHOOSE_CAMERA @"Camera"
#define OPTION_CHOOSE_GALERY @"Gallery"
#define OPTION_CHOOSE_YES @"YES"
#define OPTION_CHOOSE_NO @"NO"


#pragma mark - login param

#define LOGIN_PARAM_USER_VO @"userVo"
#define LOGIN_PARAM_USER_ID @"userId"
#define LOGIN_PARAM_FACEBOOK_ID @"facebookId"
#define LOGIN_PARAM_FIRST_NAME @"firstname"
#define LOGIN_PARAM_LAST_NAME @"lastname"
#define LOGIN_PARAM_EMAIL @"email"
#define LOGIN_PARAM_DATE @"date"
#define LOGIN_PARAM_GENDER @"gender"
#define LOGIN_PARAM_HOMETOWN @"hometown"
#define LOGIN_PARAM_PROFILE_PIC @"profilepic"
#define LOGIN_PARAM_PASSWORD @"password"
#define LOGIN_PARAM_USER_INFOR @"userinfo"
#define LOGIN_PARAM_PRIVACY @"privacy"
#define LOGIN_PARAM_FILE_NAME @"fileName"
#define LOGIN_REMEMBER_EMAIL @"Remember_email"
#define LOGIN_REMEMBER_PASSWORD @"Remember_password"


#pragma mark - facebook param

#define FACEBOOK_PARAM_FIELD @"fields"
#define FACEBOOK_FIELD_LIST @"id, name,email,gender,birthday,location,first_name,last_name,hometown,friends"
#define FACEBOOK_PARAM_RESPONSE @"responseVo"
#define FACEBOOK_PARAM_ID @"id"
#define FACEBOOK_PARAM_EMAIL @"email"
#define FACEBOOK_PARAM_FIRST_NAME @"first_name"
#define FACEBOOK_PARAM_LAST_NAME @"last_name"
#define FACEBOOK_PARAM_BIRTHDAY @"birthday"
#define FACEBOOK_PARAM_GENDER @"gender"
#define FACEBOOK_PARAM_HOMETOWN @"hometown"


#pragma mark - change password params
#define CHANGE_PASSWORD_PARAM_USER_ID @"userid"
#define CHANGE_PASSWORD_PARAM_NEW_PASSWORD @"newpassword"
#define CHANGE_PASSWORD_PARAM_PASSWORD @"password"


#pragma mark - search param

#define kSEARCH_PARAM_NAME @"name"
#define kSEARCH_PARAM_USER_ID @"userId"
#define kSEARCH_PARAM_USER_DISPLAYS @"userDisplays"
#define kSEARCH_PARAM_FIRSTNAME @"firstname"
#define kSEARCH_PARAM_LASTNAME @"lastname"
#define kSEARCH_PARAM_PROFILEPIC @"profilepic"
#define kSEARCH_PARAM_HOMETOWN @"hometown"


#pragma mark - friend list param

#define kPARAM_FRIEND_LIST_USER_ID @"userId"
#define kPARAM_FRIEND_LIST_USER_DISPLAYS @"userDisplays"
#define kPARAM_FRIEND_LIST_FRIEND_USER_ID @"userId"
#define kPARAM_FRIEND_LIST_FRIEND_FIRSTNAME @"firstname"
#define kPARAM_FRIEND_LIST_FRIEND_LASTNAME @"lastname"
#define kPARAM_FRIEND_LIST_FRIEND_NAME @"name"
#define kPARAM_FRIEND_LIST_FRIEND_PROFILE_PIC @"profilepic"
#define kPARAM_FRIEND_LIST_FRIEND_HOMETOWN @"hometown"
#define kPARAM_GET_ALL_CIRCLES_USER_ID @"userId"
#define kPARAM_GET_ALL_CIRCLES_GROUP_ID @"groupId"
#define kPARAM_RECIPE_ID @"recipeId"
#define kPARAM_POST_ID @"postId"
#define kPARAM_SHARE_TYPE @"typeRecipeShare"
#define kPARAM_SHARE_POST_TYPE @"typePostShare"
#define kPARAM_SHARE_LISTUSER @"userVos"
#define kPARAM_SHARE_LISTCIRCLE @"circleVos"

#pragma mark - circle friend param

#define kPARAM_CIRCLE_FRIEND_RESPONSEVO @"responseVo"
#define kPARAM_CIRCLE_FRIEND_ERROR @"error"
#define kPARAM_CIRCLE_FRIEND_MESSAGE @"message"
#define kPARAM_CIRCLE_FRIEND_ISUSER @"isUser"
#define kPARAM_CIRCLE_FRIEND_CIRCLEVOS @"cricleVos"
#define kPARAM_CIRCLE_FRIEND_ID @"id"
#define kPARAM_CIRCLE_FRIEND_NAME @"name"
#define kPARAM_CIRCLE_FRIEND_USER_DISPLAY @"userDisplays"
#define kPARAM_CIRCLE_FRIEND_USER_ID @"userId"
#define kPARAM_CIRCLE_FRIEND_FIRSTNAME @"firstname"
#define kPARAM_CIRCLE_FRIEND_LASTNAME @"lastname"
#define kPARAM_CIRCLE_FRIEND_PROFILEPIC @"profilepic"
#define kPARAM_CIRCLE_FRIEND_HOMETOWN @"hometown"
#define kPARAM_CIRCLE_NOTICE_DETAIL_ID @"id"
#define kPARAM_CIRCLE_COMMENT_RECIPE_ID @"recipeId"
#define kPARAM_CIRCLE_COMMENT_POST_ID @"postId"
#define kPARAM_CIRCLE_COMMENT_USER_ID @"userId"
#define kPARAM_CIRCLE_COMMENT_TEXT @"commentText"
#define kPARAM_CIRCLE_COMMENT_MENTION_USERS @"lstMention"

#pragma mark - add friend param

#define kPARAM_ADD_FRIEND_USERID1 @"userId1"
#define kPARAM_ADD_FRIEND_USERID2 @"userId2"
#define kPARAM_ADD_FRIEND_STATUS @"status"


#pragma mark - table user

#define USER_ID @"userID"
#define USER_DOB @"dob"
#define USER_EMAIL @"email"
#define USER_FACEBOOK_ID @"facebookID"
#define USER_FIRST_NAME @"firstName"
#define USER_LAST_NAME @"lastName"
#define USER_GENDER @"gender"
#define USER_HOMETOWN @"hometown"
#define USER_PASSWORD @"password"
#define USER_PROFILE_IMAGE @"profileUrl"
#define USER_INFOR @"userInfor"
#define USER_CLASS @"UserMO"
#define SEARCH_PARAM_RECIPE_TYPE @"recipeTypeVos"
#define SEARCH_PARAM_RECIPE @"recipeVos"


#pragma mark - table user friend

#define TABLE_USER_FRIEND @"EnUserFriend"
#define TABLE_FRIEND @"EnFriend"
#define kUSER_FRIEND_DOB @"dob"
#define kUSER_FRIEND_EMAIL @"email"
#define kUSER_FRIEND_FACEBOOK_ID @"facebookID"
#define kUSER_FRIEND_FIRSTNAME @"firstName"
#define kUSER_FRIEND_LASTNAME @"lastName"
#define kUSER_FRIEND_GENDER @"gender"
#define kUSER_FRIEND_HOMETOWN @"hometown"
#define kUSER_FRIEND_PASSWORD @"password"
#define kUSER_FRIEND_PROFILE_IMAGE @"profileImage"
#define kUSER_FRIEND_NAME @"name"
#define kUSER_FRIEND_USER_ID @"userID"
#define kUSER_FRIEND_USER_INFOR @"userInfor"


#pragma mark - setting cell name

#define SETTING_EMAIL_ID @"Email ID"
#define SETTING_DISPLAY_NAME @"Display Name"
#define SETTING_PROFILE_PHOTO @"Profile Photo"
#define SETTING_HOMETOWN @"Hometown"
#define SETTING_PASSWORD @"Password"
#define SETTING_ABOUT @"About"
#define SETTING_GENDER @"Gender"
#define SETTING_NOTIFICATION @"Notifications"
#define SETTING_PROFILE_PRIVACY @"Profile Privacy"
#define SETTING_LOCATION @"Enable Location Services"
#define SETTING_LOGOUT @"Log Out"
#define SETTING_ABOUT_COPPYRIGHT @"MyPlate™ is a trademark of CGS, LLC. © 2016"
#define SETTING_ABOUT_VERSION @"Version 1.0.0, 64-BitBuild iOS 9"
#define SETTING_ABOUT_TERM_OF_USE @"Terms of Use >>"
#define SETTING_ABOUT_PRIVACY_POLICY @"Privacy Policy >>"
#define SETTING_ABOUT_INFO @"<p>MyPlate was launched in 2016 to solve a surprising gap in food related apps, the social interaction and natural conversation that occurs when two or more people discuss and share food.  MyPlate’s mission is to be <b><u>the</u></b> social networking platform for food, family and friends.  In one simple app you can save, manage and share your own recipes, stories and other content that is important to you. You can follow and view the content of others and create groups of people for collaboration and sharing.</p>"


#pragma mark - Constant in CircleViewController

#define kHEIGHT_ROW_TABLE_CICLE 80
#define kHEIGHT_SESSION_TITLE_TABLE_CIRCLE 25
#define OPTION_ADD_FRIEND @"Add a Friend"
#define OPTION_ADD_GROUP @"Form a Circle"
#define OPTION_START_A_CHAT @"Start a Chat"
#define OPTION_SHARE_THIS_POST @"Send to Connections"
#define OPTION_ADD_TO_MY_RECIPE @"Add to Recipes Box"

#pragma mark - Constant in ManageCircleViewController

#define kMANAGE_CIRCLE_GROUP_NAME @"Group Name"
#define kMANAGE_CIRCLE_MEMBERS @"Members"
#define kMANAGE_CIRCLE_NAME_IN_GROUP @"My name in Group"
#define kMANAGE_CIRCLE_MUTE_NOTIFI @"Mute Notifications"
#define kMANAGE_CIRCLE_CLEAR_CHAT @"Clear Chat History"
#define kMANAGE_LEAVE_GROUP @"Delete/Leave Group"
#define kTITLE_SEARCH @"Search Friends"
#define kTITLE_ADD_FRIENDS @"Add Friends"
#define kHEIGH_CELL_ADD_TO_GROUP 44


#pragma mark - Constant in PostRecipeViewController

#define kAddContentOptionDelete @"Delete"
#define kAddContentOptionSaveDraft @"Save Draft"
#define kAddContentOptionPublish @"Publish"

#pragma mark - Constant in share shopping list viewController

#define kContentEmailShareShoppingList @"Thanks for using Myplate. Here is your shopping list. This list contains ingredients for the following recipe(s):"

#pragma mark - image name
#define IMG_MALE_DEFAULT @"male_avtar"
#define IMG_FEMALE_DEFAULT @"female_avtar"


#pragma mark - Notification shopping

#define kNotificationReloadCollectionShopping @"NotificationReloadCollectionShopping"
#define kNotificationReloadRecipeShopping @"NotificationReloadRecipeShopping"
#define kNotificationSyncData @"NotificationSyncData"
#define kNotificationReloadHome @"NotificationReloadHome"


#pragma mark - Constant for home page

#define kWelcomeMessageFromAuthor @"Hi, I am George McNulty, the creator of MyPlate. Yep, I am a real person. I work in technology but have a passion for food, particularly the social aspects of sharing recipes, ideas and tips with my friends and family. I created MyPlate to fill the surprising gap of recipe-only apps, recognizing our need to connect with food and people. Please get started today connecting and don't forget to let me know how we can make it even better."
#define kWelcomeMessageIntroduce @"You are currently in browsing mode. To access all the content and begin connecting with friends and family, Log in with your account ot Join Now to get started."

#define BASED_LOGIN_URL @"users/login/dungdv/123456"
//congdt1 - begin
#define kSTEP_NUMBER @"kSTEP_NUMBER"
//congdt1 - end

typedef enum {
    CONNECTED = 1,
    NOTCONNECTED = 0
}InternetStatus;

typedef enum {
    ADDED = 2,
    NOTADDED = 3,
    REMOVED = 4,
    UPDATED = 5
} Action;

typedef enum {
    CHECKED = 1,
    UNCHECKED = 0
} OptionalIngredientStatus;

typedef enum {
    ONLINE = 1,
    OFFLINE = 0
}ChattingStatus;


#endif /* Constant_h */
