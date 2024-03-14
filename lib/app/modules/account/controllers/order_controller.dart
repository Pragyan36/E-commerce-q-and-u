import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:q_and_u_furniture/app/data/models/userorder_model.dart';
import 'package:q_and_u_furniture/app/data/services/order_service.dart';
import 'package:q_and_u_furniture/app/database/app_storage.dart';
import 'package:q_and_u_furniture/app/model/get_review.dart';
import 'package:q_and_u_furniture/app/model/location_track.dart';
import 'package:q_and_u_furniture/app/model/return_order.dart';
import 'package:q_and_u_furniture/app/model/return_order_view.dart';
import 'package:q_and_u_furniture/app/widgets/snackbar.dart';

class OrderController extends GetxController {
  // final storage = const FlutterSecureStorage();
  var savedToken = ''.obs;
  var loading = false.obs;

  // var locationEmail = ''.obs;
  // var refId = ''.obs;
  var locationTrack = <LocationTrackHeadingModel>[].obs;
  var select = "3";
  var selected = 0.obs;

  ///
  var orderList = <UserOrderData>[].obs;

  var loadingOrderList = false.obs;

  var getReview = <GetReviewHeadingModel>[].obs;

  var getReturnOrder = <ReturnOrderHeadingModel>[].obs;

  var returnOrder = <ReturnOrderViewHeadingModel>[].obs;

  var loadingReturnOrder = false.obs;

  @override
  void onInit() async {
    // savedToken.value = (await storage.read(key: "TOKEN"))!;
    getuserOrders();
    getReviewList();
    getCompleteOrder();
    returnOrders();
    // getLocationTrack();
    super.onInit();
  }

  setSelectedRadio(val) {
    select = val;
    update();
  }

  getuserOrders() async {
    loadingOrderList(true);
    var data = await OrderService().getUserOrder(AppStorage.readAccessToken);
    if (kDebugMode) {
      print(data.toString());
    }
    if (data != null) {
      loadingOrderList(false);

      if (data['error'] == false && data['data'] != null) {
        orderList.clear();
        data['data'].forEach((v) => orderList.add(UserOrderData.fromJson(v)));
      }
    }
  }

  Future getLocationTrack(locationEmail, refId) async {
    try {
      var data = await OrderService().getLocationTrack(
        AppStorage.readAccessToken,
        locationEmail,
        refId,
      );

      if (data != null) {
        if (kDebugMode) {
          print(data);
        }
        locationTrack.clear();
        data['data'].forEach((v) {
          locationTrack.add(LocationTrackHeadingModel.fromJson(v));
        });
      }
    } on Exception catch (e) {
      log(e.toString(), name: 'getLocationTrack Error');
    } finally {}
  }

  Future cancelOrder(
    orderId,
    reason,
    additionalreason,
    aggressive,
  ) async {
    try {
      var data = await OrderService().cancelOrder(AppStorage.readAccessToken,
          orderId, reason, additionalreason, aggressive);
      if (data != null) {
        getuserOrders();
        if (kDebugMode) {
          print(data);
        }
        if (data['error'] == false) {
          getSnackbar(message: data['msg']);
        } else {
          getSnackbar(
              message: 'Order was not cancel',
              bgColor: Colors.red,
              error: true);
        }
      }
    } on Exception catch (e) {
      log(e.toString(), name: 'cancelOrder Error');
    } finally {}
  }

  Future getReviewList() async {
    loading(true);
    try {
      var data = await OrderService().getAllReview(
        AppStorage.readAccessToken,
      );

      if (data != null) {
        loading.value = false;
        if (kDebugMode) {
          print(data);
        }
        getReview.clear();
        data.forEach((v) {
          getReview.add(GetReviewHeadingModel.fromJson(v));
        });
      }
    } on Exception catch (e) {
      log(e.toString());
    } finally {
      loading.value = false;
    }
  }

  Future addReview(
    productId,
    rating,
    message,
    List<XFile> reviewfile,
    responses,
  ) async {
    List<File> files = [];
    for (var i = 0; i < reviewfile.length; i++) {
      File file = File(reviewfile[i].path);
      files.add(file);
    }
    loading.value = true;
    try {
      var data = await OrderService().addReview(
        productId: productId,
        rating: rating,
        message: message,
        files: files,
        responses: responses,
      );

      if (data != null) {
        loading.value = false;
        if (kDebugMode) {
          print(data);
        }
        if (data['error'] == false) {
          getSnackbar(message: data['msg']);
        } else {
          getSnackbar(
              message: 'Order was not cancel',
              bgColor: Colors.red,
              error: true);
        }
      }
    } on Exception catch (e) {
      log(e.toString(), name: 'addReview Error');
    } finally {
      loading.value = false;
    }
  }

  Future addReviewfordelivery(
    productId,
    rating,
    message,
    List<XFile> reviewfile,
    // responses,
  ) async {
    List<File> files = [];
    for (var i = 0; i < reviewfile.length; i++) {
      File file = File(reviewfile[i].path);
      files.add(file);
    }
    loading.value = true;
    try {
      var data = await OrderService().addReviewForDelivery(
        productId: productId,
        rating: rating,
        message: message,
        files: files,
        // responses: responses,
      );

      if (data != null) {
        loading.value = false;
        if (kDebugMode) {
          print(data);
        }
        if (data['error'] == false) {
          getSnackbar(message: data['msg']);
        } else {
          getSnackbar(
              message: 'Order was not cancel',
              bgColor: Colors.red,
              error: true);
        }
      }
    } on Exception catch (e) {
      log(e.toString(), name: 'addReview Error');
    } finally {
      loading.value = false;
    }
  }

  Future getCompleteOrder() async {
    loading(true);
    try {
      var data = await OrderService().getCompletedOrder(
        AppStorage.readAccessToken,
      );

      if (data != null) {
        loading.value = false;
        if (kDebugMode) {
          print("data is $data");
        }
        getReturnOrder.clear();
        data['data'].forEach((v) {
          getReturnOrder.add(ReturnOrderHeadingModel.fromJson(v));
        });
      }
    } on Exception catch (e) {
      log(e.toString());
    } finally {
      loading.value = false;
    }
  }

  Future applyrefund(
      String orderID,
      String username,
      String returnType,
      String bankName,
      String branch,
      String accountNumber,
      String userID,
      String contactNumber,
      String accountType) async {
    try {
      var data = await OrderService().applyRefund(
          AppStorage.readAccessToken,
          orderID,
          username,
          returnType,
          bankName,
          branch,
          accountNumber,
          userID,
          contactNumber,
          accountType);

      if (data != null) {
        loading.value = false;

        if (kDebugMode) {
          print("data is $data");
        }
        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    } finally {
      loading.value = false;
    }
  }

  Future returnOrderProduct(
    id,
    itemCount,
    reason,
    comment,
    aggressive,
  ) async {
    try {
      loading(true);
      var data = await OrderService().returnOrderProduct(
        AppStorage.readAccessToken,
        id,
        itemCount,
        reason,
        comment,
        aggressive,
      );

      if (data != null) {
        loading(false);
        getCompleteOrder();
        if (kDebugMode) {
          print(data);
        }
        if (data['error'] == false) {
          getSnackbar(message: data['msg']);
        } else {
          getSnackbar(
              message: ' return order was cancel',
              bgColor: Colors.red,
              error: true);
        }
      }
    } on Exception catch (e) {
      log(e.toString(), name: 'returnOrderProduct Error');
    } finally {
      loading(false);
    }
  }

  Future cancelReason(id, context) async {
    try {
      var data = await OrderService().cancelReason(
        AppStorage.readAccessToken,
        id,
      );

      if (data != null) {
        if (kDebugMode) {
          print(data);
        }
        if (data['error'] == false) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: HtmlWidget(
                  data["data"],
                ),
              );
            },
          );
        } else {
          getSnackbar(
              message: ' return order was cancel',
              bgColor: Colors.red,
              error: true);
        }
      }
    } on Exception catch (e) {
      log(e.toString(), name: 'returnOrderProduct Error');
    } finally {}
  }

  Future returnOrders() async {
    try {
      loadingReturnOrder.value = true;
      var data = await OrderService().returnOrder(
        AppStorage.readAccessToken,
      );

      if (data != null) {
        if (kDebugMode) {
          print(data);
        }
        if (data['error'] == false) {
          loadingReturnOrder.value = false;
          returnOrder.clear();
          data['data'].forEach((v) {
            returnOrder.add(ReturnOrderViewHeadingModel.fromJson(v));
          });
        } else {}
      }
    } on Exception catch (e) {
      log(e.toString(), name: 'returnOrderProduct Error');
    } finally {
      loadingReturnOrder.value = false;
    }
  }

  Future esewaApplyRefund(name, contactNo, walletId, id, context) async {
    try {
      var data = await OrderService().esewaFundApply(
        AppStorage.readAccessToken,
        name,
        walletId,
        contactNo,
        id,
      );

      if (data != null) {
        if (kDebugMode) {
          print(data);
        }
        if (data['error'] == false) {
          returnOrders();
          getSnackbar(message: data['msg']);
          Navigator.pop(context);
        } else {}
      }
    } on Exception catch (e) {
      log(e.toString(), name: 'esewaApplyRefund Error');
    } finally {}
  }

  Future khaltiApplyRefund(name, contactNo, walletId, id, context) async {
    try {
      var data = await OrderService().khaltiFundApply(
        AppStorage.readAccessToken,
        name,
        walletId,
        contactNo,
        id,
      );

      if (data != null) {
        if (kDebugMode) {
          print(data);
        }
        if (data['error'] == false) {
          returnOrders();
          getSnackbar(message: data['msg']);
          Navigator.pop(context);
        } else {}
      }
    } on Exception catch (e) {
      log(e.toString(), name: 'khaltiApplyRefund Error');
    } finally {}
  }

  Future bankApplyRefund(id, name, var paymentmethod, branch, accountno,
      contactNo, accountType, context) async {
    try {
      var data = await OrderService().bankFundApply(AppStorage.readAccessToken,
          name, paymentmethod, branch, accountno, contactNo, accountType, id);

      if (data != null) {
        if (kDebugMode) {
          print(data);
        }
        if (data['error'] == false) {
          returnOrders();
          getSnackbar(message: data['msg']);
          Navigator.pop(context);
        } else {}
      }
    } on Exception catch (e) {
      log(e.toString(), name: 'bankApplyRefund Error');
    } finally {}
  }

  Future cashRefund(id, context) async {
    try {
      var data = await OrderService().cashApplyRefund(
        AppStorage.readAccessToken,
        id,
      );

      if (data != null) {
        if (kDebugMode) {
          print(data);
        }
        if (data['error'] == false) {
          returnOrders();
          getSnackbar(message: data['msg']);
          Navigator.pop(context);
        } else {}
      }
    } on Exception catch (e) {
      log(e.toString(), name: 'cashRefund Error');
    } finally {}
  }

  Future getOrderedRejectedReasons(id, context) async {
    try {
      var data = await OrderService().getOrderedRejectedReason(
        AppStorage.readAccessToken,
        id,
      );

      if (data != null) {
        if (kDebugMode) {
          print(data);
        }
        if (data['error'] == false) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(data['data']),
                );
              });
          // getSnackbar(message: data['data']);
        } else {
          // getSnackbar(
          //     message: 'order rejected w',
          //     bgColor: Colors.red,
          //     error: true);
        }
      }
    } on Exception catch (e) {
      log(e.toString(), name: 'returnOrderProduct Error');
    } finally {}
  }
}
