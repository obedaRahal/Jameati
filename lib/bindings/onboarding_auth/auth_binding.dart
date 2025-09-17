import 'package:get/get.dart';
import 'package:project_manag_ite/controller/auth/forget%20password/forget_password_controller.dart';
import 'package:project_manag_ite/controller/auth/forget%20password/new_password_controller.dart';
import 'package:project_manag_ite/controller/auth/forget%20password/verify_code_forgetpassword_controller.dart';
import 'package:project_manag_ite/controller/auth/log_reg_switcher_controller.dart';
import 'package:project_manag_ite/controller/auth/login_controller.dart';
import 'package:project_manag_ite/controller/auth/register_controller.dart';
import 'package:project_manag_ite/controller/auth/verificat_register_controller.dart';

class WelcomAndSwitcherBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginRegisterSwitcherControllerImp>(
        () => LoginRegisterSwitcherControllerImp(),
        fenix: true);
    Get.lazyPut<LoginControllerImp>(() => LoginControllerImp(), fenix: true);
    Get.lazyPut<RegisterControllerImp>(() => RegisterControllerImp(),
        fenix: true);
  }
}

class VerificatRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerificatRegisterControllerImp>(
        () => VerificatRegisterControllerImp());
  }
}

// class LoginBinding extends Bindings {
//   @override
//   void dependencies() {
//   }
// }

// class RegisterBinding extends Bindings {
//   @override
//   void dependencies() {
//   }
// }

class ForgetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgetPasswordControllerImp>(
        () => ForgetPasswordControllerImp());
  }
}

class VerifyPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyCodeForgetPasswordControllerImp>(
        () => VerifyCodeForgetPasswordControllerImp());
  }
}

class NewPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewPasswordControllerImp>(() => NewPasswordControllerImp());
  }
}
