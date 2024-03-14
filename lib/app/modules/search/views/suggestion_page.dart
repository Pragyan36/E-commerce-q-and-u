import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/modules/cart/controllers/cart_controller.dart';
import 'package:q_and_u_furniture/app/modules/login/controllers/login_controller.dart';
import 'package:q_and_u_furniture/app/modules/search/controllers/search_controller.dart';
import 'package:q_and_u_furniture/app/modules/search/views/search_items.dart';
import 'package:q_and_u_furniture/app/modules/wishlist/controllers/wishlist_controller.dart';

class SuggestionList extends StatefulWidget {
  const SuggestionList({Key? key}) : super(key: key);

  @override
  State<SuggestionList> createState() => _SuggestionListState();
}

class _SuggestionListState extends State<SuggestionList> {
  final CustomSearchController controller = Get.put(
    CustomSearchController(),
  );
  final WishlistController wishlistcontroller = Get.put(
    WishlistController(),
  );
  final LoginController logcon = Get.put(
    LoginController(),
  );
  final CartController cartController = Get.put(
    CartController(),
  );

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: controller.searchList.length,
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 10,
        );
      },
      itemBuilder: (context, index) {
        var data = controller.searchList[index];
        var img = data.images?[0].image?.replaceAll(
          RegExp(r'http://127.0.0.1:8000'),
          url,
        );
        return ListTile(
          onTap: () async {
            controller.searchList.clear();
            controller.searchtxt.text = data.name.toString();
            controller.fetchSearch();
            await Get.to(
              () => const SearchItems(),
            );
          },
          leading: SizedBox(
            height: 100,
            width: 100,
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              height: 100,
              imageUrl: img.toString(),
              placeholder: (context, url) => Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                ),
                padding: const EdgeInsets.all(50),
                child: Image.asset("assets/images/Placeholder.png"),
              ),
              errorWidget: (context, a, s) {
                return Image.asset(
                  "assets/images/Placeholder.png",
                  height: 50,
                );
              },
            ),
          ),
          title: Text(
            data.name ?? "N/A",
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        );
      },
    );
  }
}
