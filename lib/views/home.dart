import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kan_bagisi/app_consts.dart';
import 'package:kan_bagisi/components/app_popup_menu_button.dart';
import 'package:kan_bagisi/components/app_button.dart';
import 'package:kan_bagisi/components/blood_demand_info.dart';
import 'package:kan_bagisi/components/blood_need_list_view.dart';
import 'package:kan_bagisi/components/clippers/custom_profile_photo_painter.dart';
import 'package:kan_bagisi/components/clippers/custom_shape_clipper.dart';
import 'package:kan_bagisi/components/clippers/profile_photo_clipper.dart';
import 'package:kan_bagisi/components/rounded_chip.dart';
import 'package:kan_bagisi/controllers/authentication_controller.dart';
import 'package:kan_bagisi/controllers/home_controller.dart';
import 'package:kan_bagisi/models/blood_demand.dart';
import 'package:kan_bagisi/utils/app_icons.dart';
import 'package:kan_bagisi/utils/shortcuts.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.BLOOD_NEED_FORM);
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              appBar: AppBar(
                titleSpacing: 8,
                leading: Image.asset(
                  "assets/images/app_icon.png",
                  height: 20,
                  width: 20,
                  fit: BoxFit.fill,
                ),
                title: Text("Blood Donation"),
                elevation: 5.0,
                actions: [
                  AppPopupMenuButton(
                    color: Colors.black,
                    onAction: (String key) {
                      if (key == "contact") {
                        Get.toNamed(AppRoutes.CONTACT_FORM);
                      } else if (key == "example") {
                        Get.toNamed(AppRoutes.EXAMPLE_FORM);
                      } else if (key == "logout") {
                        Get.find<AuthenticationController>().signOut();
                      }
                    },
                    customPopupMenuItems: <AppPopupMenuItem>[
                      AppPopupMenuItem(
                          icon: Icons.forum, label: "Example", key: "example"),
                      AppPopupMenuItem(
                          icon: Icons.contact_phone,
                          label: "Contact",
                          key: "contact"),
                      AppPopupMenuItem(
                          icon: Icons.logout, label: "Logout", key: "logout"),
                    ],
                  )
                ],
              ),
              body: Column(
                children: [
                  _buildTopBody(controller),
                  _buildBottomBody(controller),
                ],
              ));
        });
  }

  Widget _buildTopBody(HomeController controller) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: WavyShapeClipper(),
          child: Container(
            height: Get.height * 0.40,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[Get.theme.primaryColor, Get.theme.primaryColor],
              ),
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[_bodyTopLeftSide(controller), _bodyTopRightSide()],
        ),
      ],
    );
  }

  Expanded _bodyTopRightSide() {
    return Expanded(
      flex: 6,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        height: Get.height * 0.40,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              children: <Widget>[
                Obx(
                  () => RoundedChip(
                    content: Get.auth.profile.value?.bloodGroup ?? "unknown",
                    iconData: AppIcons.water_drop,
                    color: Colors.red,
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Obx(
                  () => RoundedChip(
                    content: Get.auth.profile.value?.phone ?? "unknown",
                    iconData: Icons.phone,
                    color: Colors.red,
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                RoundedChip(
                  content: Get.auth.user.email,
                  iconData: Icons.mail,
                  color: Colors.red,
                ),
                SizedBox(
                  height: 12.0,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: AppButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.PROFILE_FORM);
                    },
                    icon: Icon(
                      Icons.edit,
                      size: 24,
                      color: Colors.white,
                    ),
                    text: Text(
                      "Edit",
                      style: Get.theme.textTheme.subtitle1
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Expanded _bodyTopLeftSide(HomeController controller) {
    return Expanded(
      flex: 5,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ClipPath(
          clipper: RibbonShapeClipper(),
          child: Container(
            height: Get.height * 0.35,
            child: CustomPaint(
              painter: CustomProfilePhotoPainter(),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Material(
                    elevation: 18,
                    clipBehavior: Clip.antiAlias,
                    shape: CircleBorder(
                        side: BorderSide(color: Colors.black54, width: 2.5)),
                    child: InkWell(
                      onTap: controller.doUploadPhoto,
                      child: Image.network(
                        Get.auth.user.photoURL ??
                            "https://image.shutterstock.com/image-vector/camera-upload-icon-260nw-1055528567.jpg",
                        height: Get.height * 0.18,
                        width: Get.height * 0.36,
                        color: Get.theme.primaryColor.withOpacity(0.2),
                        colorBlendMode: BlendMode.color,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    child: Obx(
                      () => RoundedChip(
                        color: Colors.red,
                        content: Get.auth.profile.value?.fullname ?? "unknown",
                        iconData: Icons.person,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Expanded _buildBottomBody(HomeController controller) {
    return Expanded(
      child: Container(
          height: Get.height * 0.65,
          child: Column(
            children: [
              Obx(() {
                return Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: ChoiceChip(
                          backgroundColor: Colors.white,
                          selectedColor: Get.theme.accentColor.withOpacity(.5),
                          shadowColor: Colors.transparent,
                          selected: controller.selectedNeeds.value == 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                          onSelected: (bool selected) {
                            controller.selectNeed(0);
                          },
                          label: Text(
                            "Blood Demands",
                            style: Get.theme.textTheme.bodyText1,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: ChoiceChip(
                          backgroundColor: Colors.white,
                          selectedColor: Get.theme.accentColor.withOpacity(.5),
                          shadowColor: Colors.transparent,
                          selected: controller.selectedNeeds.value == 1,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                          onSelected: (bool selected) {
                            controller.selectNeed(1);
                          },
                          label: Text(
                            "My Demands",
                            style: Get.theme.textTheme.bodyText1,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
              Expanded(
                child: PageView(
                  onPageChanged: (int index) {
                    controller.selectNeed(index);
                  },
                  controller: controller.pageViewController,
                  children: <Widget>[
                    controller.bloodDemands.value.isEmpty
                        ? Container(
                            child: Center(
                              child: Text("There is no blood demands"),
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: controller.fetchBloodDemands,
                            child: BloodDemandListView(
                              bloodDemandList: controller.bloodDemands.value,
                              onSeledted: (BloodDemand blodDemand) {
                                Get.defaultDialog(
                                    content: BloodDemandInfo(
                                      bloodDemand: blodDemand,
                                    ),
                                    title: "Blood Demand Info",
                                    titleStyle: Get.textTheme.headline6);
                              },
                            ),
                          ),
                    controller.myBloodDemands.value.isEmpty
                        ? Container(
                            child: Center(
                              child: Text("There is no your blood demands"),
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: controller.fetchMyBloodDemands,
                            child: BloodDemandListView(
                              bloodDemandList: controller.myBloodDemands.value,
                              onSeledted: (BloodDemand blodDemand) async {
                                await Get.toNamed(AppRoutes.BLOOD_NEED_FORM,
                                    arguments: blodDemand);
                                controller.fetchMyBloodDemands();
                              },
                            ),
                          ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
