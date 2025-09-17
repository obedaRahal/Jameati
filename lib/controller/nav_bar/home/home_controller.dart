import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:project_manag_ite/core/class/status_request.dart';
import 'package:project_manag_ite/core/functions/handling_data.dart';
import 'package:project_manag_ite/core/functions/validation.dart';
import 'package:project_manag_ite/data/datasource/remote/home/home_data.dart';
import 'package:project_manag_ite/data/model/home/form_dates_model.dart';
import 'package:project_manag_ite/data/model/home/notification_model.dart';
import 'package:project_manag_ite/data/model/home/number_of_avd_model.dart';
import 'package:project_manag_ite/data/model/home/sixth%20person/complete_group_model.dart';
import 'package:project_manag_ite/data/model/home/statistic_model.dart';
import 'package:project_manag_ite/data/model/home/top_project_model.dart';

abstract class HomeController extends GetxController {
  getFormDates();
  getStatistics();
}

class HomeControllerImp extends HomeController {
  late PageController pageController;

  late TextEditingController description;

  late CarouselSliderController carouselController = CarouselSliderController();
  RxInt carouselCurrentIndex = 0.obs;

  RxInt selectedYear = 2024.obs;

  StatusRequest statusRequest = StatusRequest.none;

  FormDatesModel? formDatesModel;
  HomeData homeData = HomeData(Get.find());

  StatisticsModel? statisticsModel;

  @override
  getFormDates() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await homeData.getFormDates();
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response["statusCode"] == 200 || response["statusCode"] == 201) {
        try {
          formDatesModel = FormDatesModel.fromJson(response);
          debugPrint("✅ تم جلب بيانات الاستمارات بنجاح");
        } catch (e) {
          debugPrint("❌ خطأ أثناء تحويل البيانات إلى FormDatesModel: $e");
          statusRequest = StatusRequest.failure;
        }
      } else if (response.containsKey("title") &&
          response.containsKey("body")) {
        debugPrint("⚠️ خطأ فاليديشن - cooooooooooooooode ");
        statusRequest = StatusRequest.failure;
      } else {
        debugPrint("❌ استجابة غير متوقعة أو خطأ سيرفر - code ");
        showCustomSnackbar(
          title: "خطأ في الخادم",
          message: "حدث خطأ غير متوقع، الرجاء المحاولة لاحقًا",
          isSuccess: false,
        );
        statusRequest = StatusRequest.serverfaliure;
      }
    }

    update();
  }

  @override
  getStatistics() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await homeData.getStatistics();
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response["statusCode"] == 200 || response["statusCode"] == 201) {
        try {
          statisticsModel = StatisticsModel.fromJson(response);
          debugPrint("✅ تم جلب بيانات الاحصائيات  بنجاح");
        } catch (e) {
          debugPrint("❌ خطأ أثناء تحويل البيانات إلى FormDatesModel: $e");
          statusRequest = StatusRequest.failure;
        }
      } else if (response.containsKey("title") &&
          response.containsKey("body")) {
        debugPrint("⚠️ خطأ فاليديشن - cooooooooooooooode ");
        statusRequest = StatusRequest.failure;
      } else {
        debugPrint("❌ استجابة غير متوقعة أو خطأ سيرفر - code ");
        showCustomSnackbar(
          title: "خطأ في الخادم",
          message: "حدث خطأ غير متوقع، الرجاء المحاولة لاحقًا",
          isSuccess: false,
        );
        statusRequest = StatusRequest.serverfaliure;
      }
    }

    update();
  }

  final RxInt notificationCount = 0.obs;

  Future<void> getNotificationCount() async {
    statusRequest = StatusRequest.loading;
    update();

    final response = await homeData.getNotificationCount();
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if ((response["statusCode"] == 200 || response["statusCode"] == 201) ||
          response.containsKey("count")) {
        try {
          final raw = response["count"];
          notificationCount.value =
              (raw is int) ? raw : int.tryParse("$raw") ?? 0;
          debugPrint("noti count is ${notificationCount.value}");
        } catch (e) {
          debugPrint("❌ خطأ أثناء تحويل البيانات إلى getNotificationCount: $e");
          statusRequest = StatusRequest.failure;
        }
      } else if (response.containsKey("title") &&
          response.containsKey("body")) {
        statusRequest = StatusRequest.failure;
      } else {
        showCustomSnackbar(
          title: "خطأ في الخادم",
          message: "حدث خطأ غير متوقع، الرجاء المحاولة لاحقًا",
          isSuccess: false,
        );
        statusRequest = StatusRequest.serverfaliure;
      }
    }

    update();
  }

  NotificationModel? notificationModel;
  List<NotificationData> notificationList = [];

  getListOfNotification() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await homeData.getNotificationList();
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response["statusCode"] == 200 || response["statusCode"] == 201) {
        try {
          final parsed = NotificationModel.fromJson(response);

          notificationList.assignAll(parsed.data ?? []);
          getNotificationCount();
          debugPrint(
              "✅ تم جلب بيانات advvvv بنجاح: ${notificationList.length} جروب");
        } catch (e) {
          debugPrint(
              "❌ خطأ أثناء تحويل البيانات إلى getListOfNotification: $e");
          statusRequest = StatusRequest.failure;
        }
      } else if (response.containsKey("title") &&
          response.containsKey("body")) {
        debugPrint("⚠️ خطأ فاليديشن - تحقق من محتوى الطلب");
        statusRequest = StatusRequest.failure;
      } else {
        debugPrint("❌ استجابة غير متوقعة أو خطأ سيرفر");
        statusRequest = StatusRequest.serverfaliure;
      }
    }
    update();
  }

  CompleteGroupModel? completeGroupModel;
  final RxList<FullGroupsModel> fullGroupsList = <FullGroupsModel>[].obs;
  final RxnInt selectedGroupId = RxnInt(); 
  final RxString selectedGroupName = ''.obs;

  void setSelectedGroup(FullGroupsModel g) {
    selectedGroupId.value = g.id;
    selectedGroupName.value = g.name ?? '';
  }

  getListCompleteGroup() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await homeData.getListOfFullGroups();
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response["statusCode"] == 200 || response["statusCode"] == 201) {
        try {
          final parsed = CompleteGroupModel.fromJson(response);

          fullGroupsList.assignAll(parsed.groups ?? []);
          getNotificationCount();
          debugPrint(
              "✅ تم جلب بيانات getListCompleteGroup بنجاح: ${notificationList.length} ");
        } catch (e) {
          debugPrint("❌ خطأ أثناء تحويل البيانات إلى getListCompleteGroup: $e");
          statusRequest = StatusRequest.failure;
        }
      } else if (response.containsKey("title") &&
          response.containsKey("body")) {
        debugPrint("⚠️ خطأ فاليديشن - تحقق من محتوى الطلب");
        statusRequest = StatusRequest.failure;
      } else {
        debugPrint("❌ استجابة غير متوقعة أو خطأ سيرفر");
        statusRequest = StatusRequest.serverfaliure;
      }
    }
    update();
  }

  sendRequestToJoinSithPerson() async {
    statusRequest = StatusRequest.loading;
    debugPrint("\\\\\\\\sendRequestToJoinSithPerson is $statusRequest");
    update();
    var response = await homeData.postToSendRequestSixthPerson(
        selectedGroupId.value ?? 0, description.text);
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      debugPrint(
          "//////im at sendRequestToJoinSithPerson: handling success response");
      final code = response["statusCode"];

      if (code == 200 || code == 201) {
        debugPrint('  ناجح - code $code');
        showCustomSnackbar(
          title: response["title"] ?? "نجاح",
          message: response["body"] ?? "تم بنجاح",
          isSuccess: true,
        );
      } else if (response.containsKey("title") &&
          response.containsKey("body")) {
        debugPrint("⚠️ خطأ فاليديشن - code $code");
        showCustomSnackbar(
          title: response["title"] ?? "خطأ",
          message: response["body"] ?? "تحقق من البيانات المدخلة",
          isSuccess: false,
        );
        statusRequest = StatusRequest.failure;
      } else {
        debugPrint("❌ استجابة غير متوقعة أو خطأ سيرفر - code $code");
        showCustomSnackbar(
          title: "خطأ في الخادم",
          message: "حدث خطأ غير متوقع، الرجاء المحاولة لاحقًا",
          isSuccess: false,
        );
        statusRequest = StatusRequest.serverfaliure;
      }
    }

    update();
  }

  TopProjectModel? topProjectModel;
  List<TopProjectData> listTopPRoject = [];

  Future<void> getTheTopProjectByYear(int year) async {
    statusRequest = StatusRequest.loading;
    update(["topProject"]);

    final response = await homeData.postToGetTopProject(year);
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response["data"] is List) {
        try {
          final parsed = TopProjectModel.fromJson(response);
          listTopPRoject = parsed.data ?? [];
          debugPrint("✅ تمand year $year الجلب: ${listTopPRoject.length}");
        } catch (e) {
          debugPrint("❌ خطأ أثناء التحويل: $e");
          statusRequest = StatusRequest.failure;
        }
      } else if (response.containsKey("title") &&
          response.containsKey("body")) {
        debugPrint("⚠️ خطأ فاليديشن");
        statusRequest = StatusRequest.failure;
      } else {
        debugPrint("❌ استجابة غير متوقعة");
        statusRequest = StatusRequest.serverfaliure; 
      }
    }
    update(["topProject"]);
  }

  
  
  NumberOfAdvModel? numberOfAdvModel ;
  getAdvsNumber() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await homeData.gettheNumberOfAdvs();
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response["statusCode"] == 200 || response["statusCode"] == 201) {
        try {
          numberOfAdvModel = NumberOfAdvModel.fromJson(response);
          debugPrint("✅ تم جلب بيانات getAdvsNumber getAdvsNumberالاحصائيات  بنجاح");
        } catch (e) {
          debugPrint("❌ خطأ أثناء تحويل البيانات إلى NumberOfAdvModel: $e");
          statusRequest = StatusRequest.failure;
        }
      } else if (response.containsKey("title") &&
          response.containsKey("body")) {
        debugPrint("⚠️ خطأ فاليديشن - cooooooooooooooode ");
        statusRequest = StatusRequest.failure;
      } else {
        debugPrint("❌ استجابة غير متوقعة أو خطأ سيرفر - code ");
        showCustomSnackbar(
          title: "خطأ في الخادم",
          message: "حدث خطأ غير متوقع، الرجاء المحاولة لاحقًا",
          isSuccess: false,
        );
        statusRequest = StatusRequest.serverfaliure;
      }
    }

    update();
  }

  void injectDummyTopProjects() {
    listTopPRoject = <TopProjectData>[
      TopProjectData(
        groupId: 1,
        name: "فريق المبرمجين",
        groupImage: "https://picsum.photos/seed/team1/400/400",
        ideaTitle: "منصّة تتبّع حضور الطلاب بالـ NFC",
        grades: Grades(presentationGrade: 48, projectGrade: 50, total: 98),
        members: [
          Members(
              id: 1,
              name: "أحمد",
              universityNumber: "2020111",
              profileImage: "https://i.pravatar.cc/150?img=1"),
          Members(
              id: 2,
              name: "سارة",
              universityNumber: "2020112",
              profileImage: "https://i.pravatar.cc/150?img=2"),
          Members(
              id: 3,
              name: "ليث",
              universityNumber: "2020113",
              profileImage: "https://i.pravatar.cc/150?img=3"),
        ],
      ),
      TopProjectData(
        groupId: 2,
        name: "فريق الرؤية",
        groupImage: "https://picsum.photos/seed/team2/400/400",
        ideaTitle: "كشف العيوب بالذكاء الاصطناعي لخط إنتاج",
        grades: Grades(presentationGrade: 47, projectGrade: 49, total: 96),
        members: [
          Members(
              id: 4,
              name: "نور",
              universityNumber: "2020121",
              profileImage: "https://i.pravatar.cc/150?img=4"),
          Members(
              id: 5,
              name: "خالد",
              universityNumber: "2020122",
              profileImage: "https://i.pravatar.cc/150?img=5"),
          Members(
              id: 6,
              name: "مها",
              universityNumber: "2020123",
              profileImage: "https://i.pravatar.cc/150?img=6"),
          Members(
              id: 7,
              name: "زيد",
              universityNumber: "2020124",
              profileImage: "https://i.pravatar.cc/150?img=7"),
        ],
      ),
      TopProjectData(
        groupId: 3,
        name: "فريق سمارت هوم",
        groupImage: "https://picsum.photos/seed/team3/400/400",
        ideaTitle: "نظام منزل ذكي بالطاقة الشمسية",
        grades: Grades(presentationGrade: 45, projectGrade: 50, total: 95),
        members: [
          Members(
              id: 8,
              name: "هدى",
              universityNumber: "2020131",
              profileImage: "https://i.pravatar.cc/150?img=8"),
          Members(
              id: 9,
              name: "عبدالله",
              universityNumber: "2020132",
              profileImage: "https://i.pravatar.cc/150?img=9"),
        ],
      ),
      TopProjectData(
        groupId: 4,
        name: "فريق الصحة",
        groupImage: "https://picsum.photos/seed/team4/400/400",
        ideaTitle: "تطبيق متابعة مرضى السكري مع إنذارات",
        grades: Grades(presentationGrade: 46, projectGrade: 47, total: 93),
        members: [
          Members(
              id: 10,
              name: "رحاب",
              universityNumber: "2020141",
              profileImage: "https://i.pravatar.cc/150?img=10"),
          Members(
              id: 11,
              name: "طارق",
              universityNumber: "2020142",
              profileImage: "https://i.pravatar.cc/150?img=11"),
          Members(
              id: 12,
              name: "ديما",
              universityNumber: "2020143",
              profileImage: "https://i.pravatar.cc/150?img=12"),
        ],
      ),
      TopProjectData(
        groupId: 5,
        name: "فريق الأمن السيبراني",
        groupImage: "https://picsum.photos/seed/team5/400/400",
        ideaTitle: "كشف محاولات الاختراق في الوقت الفعلي",
        grades: Grades(presentationGrade: 44, projectGrade: 48, total: 92),
        members: [
          Members(
              id: 13,
              name: "جود",
              universityNumber: "2020151",
              profileImage: "https://i.pravatar.cc/150?img=13"),
          Members(
              id: 14,
              name: "أدهم",
              universityNumber: "2020152",
              profileImage: "https://i.pravatar.cc/150?img=14"),
          Members(
              id: 15,
              name: "ليان",
              universityNumber: "2020153",
              profileImage: "https://i.pravatar.cc/150?img=15"),
          Members(
              id: 16,
              name: "غيث",
              universityNumber: "2020154",
              profileImage: "https://i.pravatar.cc/150?img=16"),
        ],
      ),
    ];

    statusRequest = StatusRequest.success;
    update();
  }

  @override
  void onInit() {
    description = TextEditingController();
    pageController = PageController(
      initialPage: 2,
    );

    carouselController = CarouselSliderController();
    getFormDates();
    getStatistics();
    getNotificationCount();
    getTheTopProjectByYear(selectedYear.value);
    //injectDummyTopProjects();
    getAdvsNumber();
    super.onInit();
  }

  @override
  void dispose() {
    description.dispose();
    super.dispose();
  }
}
