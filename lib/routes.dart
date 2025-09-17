import 'package:get/get.dart';
import 'package:project_manag_ite/bindings/nav%20bar/chats/chat_binding.dart';
import 'package:project_manag_ite/bindings/nav%20bar/chats/chats_list_binding.dart';
import 'package:project_manag_ite/bindings/nav%20bar/chats/new_chat_binding.dart';
import 'package:project_manag_ite/bindings/nav%20bar/groups/create_new_group_binding.dart';
import 'package:project_manag_ite/bindings/nav%20bar/groups/join_to_group_binding.dart';
import 'package:project_manag_ite/bindings/nav%20bar/groups/my_group_binding.dart';
import 'package:project_manag_ite/bindings/nav%20bar/home/adv/adv_img_binding.dart';
import 'package:project_manag_ite/bindings/nav%20bar/home/adv/adv_pdf_binding.dart';
import 'package:project_manag_ite/bindings/nav%20bar/home/form%201%20+%202/form_tow_binding.dart';
import 'package:project_manag_ite/bindings/nav%20bar/home/home_binding.dart';
import 'package:project_manag_ite/bindings/nav%20bar/home/form%201%20+%202/submit_idea_binding.dart';
import 'package:project_manag_ite/bindings/nav%20bar/home/invitation_binding.dart';
import 'package:project_manag_ite/bindings/nav%20bar/home/profile_binding.dart';
import 'package:project_manag_ite/bindings/nav%20bar/nav_bar_binding.dart';
import 'package:project_manag_ite/bindings/nav%20bar/search_binding.dart';
import 'package:project_manag_ite/bindings/onboarding_auth/auth_binding.dart';
import 'package:project_manag_ite/bindings/onboarding_auth/on_boarding_binding.dart';
import 'package:project_manag_ite/core/constant/route_name.dart';
import 'package:project_manag_ite/core/middleware/mymiddleware.dart';
import 'package:project_manag_ite/view/screen/nav%20bar/chats/chat_screen.dart';
import 'package:project_manag_ite/view/screen/nav%20bar/chats/new_chat_screen.dart';
import 'package:project_manag_ite/view/screen/nav%20bar/groups/create_new_group_screen.dart';
import 'package:project_manag_ite/view/screen/nav%20bar/groups/join_to_group_screen.dart';
import 'package:project_manag_ite/view/screen/nav%20bar/groups/my_group_screen.dart';
import 'package:project_manag_ite/view/screen/nav%20bar/home/advvv/adv_img_screen.dart';
import 'package:project_manag_ite/view/screen/nav%20bar/home/advvv/adv_pdf_screen.dart';
import 'package:project_manag_ite/view/screen/nav%20bar/home/form%201%20+%202/form_tow_screen.dart';
import 'package:project_manag_ite/view/screen/nav%20bar/home/form%201%20+%202/submit_idea_screen.dart';
import 'package:project_manag_ite/view/screen/nav%20bar/home/invitation_screen.dart';
import 'package:project_manag_ite/view/screen/nav%20bar/home/profile_screen.dart';
import 'package:project_manag_ite/view/screen/nav%20bar/search_screen.dart';
import 'package:project_manag_ite/view/screen/auth/forget%20password/forget_password.dart';
import 'package:project_manag_ite/view/screen/auth/forget%20password/verify_code_forget_password.dart';
import 'package:project_manag_ite/view/screen/auth/forget%20password/new_password.dart';
import 'package:project_manag_ite/view/screen/auth/login_register_switcher.dart';
import 'package:project_manag_ite/view/screen/auth/verificat_register_screen.dart';
import 'package:project_manag_ite/view/screen/auth/welcom_screen.dart';
import 'package:project_manag_ite/view/screen/nav%20bar/home/home_screen.dart';
import 'package:project_manag_ite/view/screen/nav%20bar/nav_bar.dart';
import 'package:project_manag_ite/view/screen/on_boarding/on_boarding_screen.dart';

List<GetPage> routes = [
//////////////////////////auth////////////////////////
  GetPage(
      name: "/",
      page: () => const OnBoardingScreen(),
      binding: OnBoardingBinding(),
      middlewares: [MyMiddleWare()]),
  GetPage(
    name: AppRoute.welccm,
    page: () => const WelcomScreen(),
    binding: WelcomAndSwitcherBinding(),
  ),
  GetPage(
    name: AppRoute.loginregister,
    page: () => const LoginRegisterSwitcher(),
    binding: WelcomAndSwitcherBinding(),
    transition: Transition.downToUp,
    transitionDuration: const Duration(milliseconds: 400),
  ),
  // GetPage(
  //   name: AppRoute.login,
  //   page: () => const LoginContains(),
  //   binding: LoginBinding(),
  // ),
  // GetPage(
  //   name: AppRoute.register,
  //   page: () => const RegisterContains(),
  //   binding: RegisterBinding(),
  // ),
  GetPage(
    name: AppRoute.verificationRegister,
    page: () => const VerificationRegisterScreeen(),
    binding: VerificatRegisterBinding(),
  ),
  GetPage(
    name: AppRoute.forgetPassword1,
    page: () => const ForgetPasswordScreen(),
    binding: ForgetPasswordBinding(),
  ),
  GetPage(
    name: AppRoute.forgetPassword2,
    page: () => const VerifyCodeForgetPasswordScreen(),
    binding: VerifyPasswordBinding(),
  ),
  GetPage(
    name: AppRoute.forgetPassword3,
    page: () => const NewPasswordScreen(),
    binding: NewPasswordBinding(),
  ),

  ////////////////////////// nav barrrr
  ///
  GetPage(
    name: AppRoute.navBar,
    page: () => const NavBar(),
    binding: NavBarBinding(),
  ),

  GetPage(
    name: AppRoute.home,
    page: () => const HomeScreen(),
    binding: HomeBinding(),
  ),

  GetPage(
    name: AppRoute.chatsList,
    page: () => const NavBar(),
    binding: ChatsListBinding(),
  ),

  GetPage(
    name: AppRoute.search,
    page: () => const SearchScreen(),
    binding: SearchScreenBinding(),
  ),

  GetPage(
    name: AppRoute.group,
    page: () => const JoinToGroupScreen(),
    binding: JoinToGroupBinding(),
  ),

  GetPage(
    name: AppRoute.creatNewGroup,
    page: () => const CreateNewGroupScreen(),
    binding: CreateNewGroupBinding(),
  ),

  GetPage(
    name: AppRoute.myGroup,
    page: () => const MyGroupScreen(),
    binding: MyGroupBinding(),
  ),

  GetPage(
    name: AppRoute.newChatScreen,
    page: () => const NewChatScreen(),
    binding: NewChatBinding(),
  ),

  GetPage(
    name: AppRoute.chatScreen,
    page: () => const ChatScreen(),
    binding: ChatBinding(),
  ),

  GetPage(
    name: AppRoute.submitIdeaScreen,
    page: () => const SubmitIdeaScreen(),
    binding: SubmitIdeaBinding(),
  ),

  GetPage(
    name: AppRoute.advImgScreen,
    page: () => const AdvImgScreen(),
    binding: AdvImgBinding(),
  ),

  GetPage(
    name: AppRoute.advPdfScreen,
    page: () => const AdvPdfScreen(),
    binding: AdvPdfBinding(),
  ),

  GetPage(
    name: AppRoute.formTowScreen,
    page: () => const FormTowScreen(),
    binding: FormTowBinding(),
  ),

  GetPage(
    name: AppRoute.profileScreen,
    page: () => const ProfileScreen(),
    binding: ProfileBinding(),
  ),

  GetPage(
    name: AppRoute.invitationScreen,
    page: () => const InvitationScreen(),
    binding: InvitationBinding(),
  ),
];
