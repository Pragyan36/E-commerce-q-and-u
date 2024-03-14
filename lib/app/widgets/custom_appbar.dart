import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/modules/home/controllers/home_controller.dart';
import 'package:q_and_u_furniture/app/routes/app_pages.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  
  CustomAppbar({
    Key? key,
    required this.title,
    this.trailing,
    this.leading,
  }) : super(key: key);

  final String title;
  final Widget? trailing;
  final Widget? leading;
  final HomeController homecon = Get.put(
    HomeController(),
  );

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: 100,
      leading: leading ??
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18.sp,
              color: Colors.black,
            ),
          ),
      title: Text(
        title,
        style: titleStyle.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      actions: [
        trailing ??
            CircleAvatar(
              backgroundColor: AppColor.kalaAppMainColor,
              radius: 18,
              child: Center(
                child: Obx(
                  () => badges.Badge(
                    badgeContent: Text(
                      homecon.notifications.length.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    position: badges.BadgePosition.topEnd(
                      end: -5,
                      top: -5,
                    ),
                    showBadge: homecon.notifications.isEmpty ? false : true,
                    child: IconButton(
                      onPressed: () {
                        Get.toNamed(Routes.NOTIFICATION);
                      },
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Iconsax.notification,
                        color: Colors.white,
                        size: 18.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        const SizedBox(
          width: 20,
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
