import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/modules/cart/components/cart_tile.dart';
import 'package:q_and_u_furniture/app/modules/cart/controllers/cart_controller.dart';
import 'package:q_and_u_furniture/app/modules/product_detail/views/product_detail_view.dart';
import 'package:q_and_u_furniture/app/routes/app_pages.dart';
import 'package:q_and_u_furniture/app/widgets/custom_appbar.dart';
import 'package:q_and_u_furniture/app/widgets/custom_button.dart';
import 'package:q_and_u_furniture/app/widgets/custom_shimmer.dart';
import 'package:q_and_u_furniture/app/widgets/nodata.dart';
import 'package:q_and_u_furniture/app/widgets/snackbar.dart';

class CartView extends GetView<CartController> {
  CartView({Key? key}) : super(key: key);

  @override
  final loginController = Get.put(CartController());
  final NumberFormat formatter = NumberFormat('#,###');

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        loginController.fetchCart();
      },
    );

    return Obx(
      () => Scaffold(
        extendBody: true,
        appBar: CustomAppbar(
          title: 'My Cart (${loginController.cartAssetsList.length})',
          leading: Container(),
          trailing: TextButton(
            onPressed: () {
              loginController.deleteAllCart();
            },
            child: Text(
              'Delete All',
              style: subtitleStyle.copyWith(
                color: AppColor.kalaAppMainColor,
              ),
            ),
          ),
        ),
        body: RefreshIndicator(
          color: AppColor.kalaAppMainColor,
          onRefresh: () async {
            await Future.delayed(
              const Duration(
                seconds: 1,
              ),
            );
            loginController.fetchCart();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            child: Column(
              children: [
                Obx(
                  () => loginController.cartLoading.isTrue
                      ? ListView.builder(
                          itemCount: 5,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return CustomShimmer(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              widget: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 10,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                height: 100,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            );
                          },
                        )
                      : loginController.cartAssetsList.isNotEmpty
                          ? Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                ...List.generate(
                                  loginController.cartAssetsList.length,
                                  (index) => Obx(
                                    () => loginController
                                            .cartAssetsList.isNotEmpty
                                        ? GestureDetector(
                                            onTap: () {
                                              Get.to(
                                                ProductDetailView(
                                                  slug: loginController
                                                      .cartAssetsList[index]
                                                      .slug,
                                                ),
                                              );
                                            },
                                            child: CartTile(
                                              img: loginController
                                                  .cartAssetsList[index]
                                                  .productImage?[0]
                                                  .image
                                                  ?.replaceAll(
                                                RegExp(
                                                  r'http://127.0.0.1:8000',
                                                ),
                                                url,
                                              ),
                                              name: loginController
                                                  .cartAssetsList[index]
                                                  .productName,
                                              price: formatter.format(
                                                  loginController
                                                      .cartAssetsList[index]
                                                      .subTotalPrice),
                                              quantity: loginController
                                                  .cartAssetsList[index].qty,
                                              productid: loginController
                                                  .cartAssetsList[index]
                                                  .productId,
                                              index: index,
                                              data: loginController
                                                  .cartAssetsList[index],
                                              ontap: () async {
                                                await loginController
                                                    .removeCartitem(
                                                  loginController
                                                      .cartAssetsList[index].id,
                                                );
                                                loginController.cartAssetsList
                                                    .removeAt(index);
                                              },
                                            ),
                                          )
                                        : Text(
                                            'No item',
                                            style: subtitleStyle,
                                          ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      _buildAmountTile(
                                        'Sub-total',
                                        'Rs.${formatter.format(loginController.cartSummary.value.totalAmount)}',
                                      ),
                                      _buildAmountTile(
                                        'Vat(%)',
                                        'Rs.${formatter.format(loginController.cartSummary.value.vat)}',
                                      ),
                                      const Divider(
                                        thickness: 1.5,
                                        indent: 20,
                                        endIndent: 20,
                                      ),
                                      Obx(
                                        () => _buildAmountTile(
                                          'Total',
                                          'Rs.${formatter.format(loginController.cartSummary.value.grandTotal)}',
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                20,
                                        child: CustomButton(
                                          label: 'Proceed',
                                          btnClr: AppColor.kalaAppMainColor,
                                          txtClr: Colors.white,
                                          ontap: () {
                                            if (loginController.cartSummary
                                                    .value.grandTotal!
                                                    .toInt() <
                                                500) {
                                              getSnackbar(
                                                message:
                                                    'To Proceed Order should be more then Rs 500',
                                              );
                                            } else {
                                              Get.toNamed(
                                                Routes.SHIPPING,
                                                arguments: loginController
                                                    .cartdata.value.totalAmount,
                                              );
                                            }
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : const NoDataView(
                              text: 'Empty Cart',
                            ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildAmountTile(title, total) {
    return ListTile(
      dense: true,
      visualDensity: const VisualDensity(vertical: -3),
      title: Text(
        title,
        style: subtitleStyle.copyWith(color: Colors.grey),
      ),
      trailing: Text(
        total.toString(),
        style: subtitleStyle.copyWith(fontWeight: FontWeight.w500),
      ),
    );
  }
}
