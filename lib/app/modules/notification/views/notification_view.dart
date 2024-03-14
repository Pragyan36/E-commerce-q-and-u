import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/modules/home/controllers/home_controller.dart';
import 'package:q_and_u_furniture/app/modules/notification/controllers/notification_controller.dart';
import 'package:q_and_u_furniture/app/modules/notification/views/notification%20_detail_page.dart';
import 'package:q_and_u_furniture/app/widgets/nodata.dart';
import 'package:readmore/readmore.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NotificationView extends GetView<NotificationController> {
  NotificationView({Key? key}) : super(key: key);

  final homecon = Get.put(
    HomeController(),
  );

  @override
  Widget build(BuildContext context) {
    homecon.refreshNotification();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: Colors.white,
      ),
      floatingActionButton: Obx(
        () => homecon.notifications.isNotEmpty
            ? FloatingActionButton(
                backgroundColor: AppColor.kalaAppMainColor,
                onPressed: () {
                  homecon.deleteAllNotifications();
                },
                child: const Icon(
                  Icons.delete_forever,
                  color: Colors.white,
                ),
              )
            : const SizedBox(),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await homecon.refreshNotification();
        },
        child: SingleChildScrollView(
          child: Obx(
            () => homecon.notifications.isNotEmpty
                ? _buildNotificationList(homecon.notifications)
                : const NoDataView(text: 'Empty Notifications'),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationList(RxList<dynamic> notifications) {
    Map<String, List<Map<String, dynamic>>> groupedNotifications = {};

    // Group notifications by their titles
    for (var notification in notifications) {
      String title = notification['createdAt'];
      if (!groupedNotifications.containsKey(title)) {
        groupedNotifications[title] = [notification];
      } else {
        groupedNotifications[title]!.add(notification);
      }
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: groupedNotifications.length,
      itemBuilder: (context, index) {
        String title = groupedNotifications.keys.elementAt(index);
        List<Map<String, dynamic>> notificationsWithTitle =
            groupedNotifications[title]!;
        return _buildNotificationTile(
          title: notificationsWithTitle[0]['title'],
          body: title,
          date: notificationsWithTitle[0]['createdAt'],
          image: notificationsWithTitle[0]['image'],
          dialogontap: () {
            homecon.deleteItem(notificationsWithTitle[0]['createdAt']);
            Get.back();
          },
        );
      },
    );
  }

  Widget _buildNotificationTile({
    required String title,
    required String body,
    required String date,
    required String image,
    required void Function()? dialogontap,
  }) {
    return GestureDetector(
      onTap: () {
        print("pronting image{$image}");
        String myString = body;
        RegExp numberRegex = RegExp(r'\d+');
        Match numberMatch = numberRegex.allMatches(myString).last;
        String? orderID = numberMatch.group(0);
        if (myString.contains("Order Id")) {
          Get.to(
            () => NotificationDetailPage(
              orderID: orderID!,
            ),
          );
        }
      },
      child: Card(
        color: AppColor.kalaAppLightAccentColor,
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            contentPadding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
            title: Text(
              title,
              style: titleStyle.copyWith(
                  fontWeight: FontWeight.w600, fontSize: 16),
            ),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 8,
                ),
                ReadMoreText(
                  body,
                  trimLines: 2,
                  preDataTextStyle:
                      const TextStyle(fontWeight: FontWeight.w500),
                  style: const TextStyle(color: Colors.black),
                  colorClickableText: Colors.pink,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: '...Show more',
                  trimExpandedText: ' show less',
                ),
                image == ""
                    ? Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        height: Device.height / 6,
                        width: Device.width,
                        child: const Icon(
                          Icons.error,
                        ))
                    : Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        height: Device.height / 6,
                        width: Device.width,
                        child: Image.network(
                          image,
                          fit: BoxFit.fitWidth,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.error,
                            );
                          },
                        ),
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      date,
                      style: subtitleStyle.copyWith(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.defaultDialog(
                          radius: 10,
                          title: 'Delete notification?',
                          content: MaterialButton(
                            onPressed: dialogontap,
                            color: AppColor.kalaAppMainColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Delete',
                              style:
                                  subtitleStyle.copyWith(color: Colors.white),
                            ),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.more_horiz_rounded,
                        size: 20.sp,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
