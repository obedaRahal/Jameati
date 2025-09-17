class AppLink {
  //static const String server = "http://localhost/api" ;
  //static const String server = "http://10.0.2.2/api" ;
    static const String server = "http://192.168.155.44/api";

  // auth 
  static const String registerApi = "$server/student/register" ;
  static const String verifyRegisterApi = "$server/student/verifyOtp" ;
  static const String resendCodeVerifyAtRegisterApi = "$server/student/resendOtp" ;
  
  static const String loginApi = "$server/student/login" ;

  static const String forgetPasswordApi = "$server/student/forgetPassword/sendOtp" ;
  static const String verifyCodeforgetPasswordApi = "$server/student/forgetPassword/verifyOtp" ;
  static const String resendCodeVerifyAtForgetpasswordApi = "$server/student/forgetPassword/resendOtp" ;
  static const String newPasswordApi = "$server/student/forgetPassword/resetPassword" ;

  // home
    static const String getFormDates = "$server/student/home/showFormDates" ;
    static const String getStatisticsApi = "$server/student/home/showNumbersStatistics" ;
    static const String getNotificationCountApi = "$server/student/countNotifications" ;
    static const String getNotificationListApi = "$server/student/showNotifications" ;
    static const String postToGetTopProjectApi = "$server/student/groups/top-projects" ;
    static const String getNumberOfAdvApi = "$server/student/announcements/students/statistics" ;
    // sixth person
    static const String getListOfCompleteGroupApi = "$server/student/groups/five-members" ;
    static const String postToAskForSixthPerson = "$server/student/groups" ;
    // invitationnnnnnnnnn
    static const String getListOfInvitationApi = "$server/student/groups/invitations/user" ;
    static const String postToAcceptInvitationApi = "$server/student/invitations" ;
    static const String postToRejectInvitationApi = "$server/student/invitations" ;


    // group 
    // join to group
    static const String getGroupListToJpinApi = "$server/student/groups/incomplete/public" ;
    static const String askToJoinGroupApi = "$server/student" ;
    static const String cancelToJoinGroupApi = "$server/student/join-request/group" ;
    //create group
    static const String getStudentListToInviteApi = "$server/student/students-without-group" ;
    static const String createGroupApi = "$server/student/createGroup" ;
    // my group
    static const String showJoinRequestApi = "$server/student" ;
    static const String acceptJoinToMyGroupApi = "$server/student/join-request" ;
    static const String rejectJoinToMyGroupApi = "$server/student/join-request" ;
    static const String myGroupMembersApi = "$server/student/my-group-members" ;
    static const String myGroupPublicDeatilsApi = "$server/student/my-group-details" ;
    static const String changeLeaderApi = "$server/student/groups" ;
    static const String myGroupInfoApi = "$server/student/my-group" ;
    static const String updateGroupInfo = "$server/student/updateGroup" ;
    static const String getToDownloadFormOneApi = "$server/student/form-1" ;
    static const String getToDownloadFormTowApi = "$server/student/form-2" ;
    static const String postToSignatureFormOneApi = "$server/student/project-form-one" ;
    static const String myProjectAndFormDetailsApi = "$server/student/groups/my/project" ;
    static const String delToLeaveGroupApi = "$server/student/groups" ;
    static const String postToUpdateForm1Api = "$server/student/project-form-one" ;
    static const String postToResendForm1Api = "$server/student/project-form-one" ;


  //advvvvvvvvvv
  static const String getLatest5AdvImgApi = "$server/student/announcement/images/latest" ;
  static const String getListCurrentYearAdvImgApi = "$server/student/announcement/images" ;
  static const String getToDownloadAdvApi = "$server/student/announcement" ;
  static const String postToAddToFavApi = "$server/student/favorites" ;
  static const String deleteToRemoveFavApi = "$server/student/favorites" ;
  static const String getListLastYearAdvImgApi = "$server/student/announcement/last-year/images" ;
  //pdf
  static const String getLatest5AdvPdfApi = "$server/student/announcement/files/latest" ;
  static const String getListCurrentYearAdvPdfApi = "$server/student/announcement/files" ;
  static const String getListLastYearAdvPdfApi = "$server/student/announcement/last-year/files" ;
  // favorite pdffff
  static const String getListOfFavoriteAdvImgApi = "$server/student/favorites/images" ;
  static const String getListOfFavoriteAdvPdfApi = "$server/student/favorites/files" ;


  //form one submit idea
  static const String getMemberForFormOneApi = "$server/student/my-group/members" ;
  static const String getDoctorForFormOneApi = "$server/student/doctors" ;
  static const String createFormOneApi = "$server/student/project-form-one" ;
  //form towwww
  static const String createFormTowApi = "$server/student/project-form-two" ;


  //search 
  static const String getListOfSearchHistoryApi = "$server/student/getSearchHistory" ;
  static const String deleteSearchItemApi = "$server/student/deleteItem" ;
  static const String searchApi = "$server/student/searchStudent" ;



  //chatttttttttt
  static const String getListOfUsersToStartChatApi = "$server/student/showConversationOption" ;
  static const String getToCreateNewConversationApi = "$server/student/createConversation" ;
  static const String getAllChatApi = "$server/student/showConversations" ;
  static const String postToGetMessageAtChatApi = "$server/student/showMessages" ;
  static const String postToSendMessageApi = "$server/student/sentMessage" ;


  //profileeeeeeeee
  static const String grtMyProfileApi = "$server/student/profile" ;
  static const String updateProfileInfoApi = "$server/student/profile" ;
  static const String updateProfilePicApi = "$server/student/updateProfilePicture" ;
  static const String getToLogOutApi = "$server/student/logout" ;



}