import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';

var thousandSepretor = NumberFormat('#,###');
const defaultContainerRadius = Radius.circular(30);

mixin AppColor {
  static const mainClr = Color.fromRGBO(37, 50, 55, 1);
  static const red = Color.fromRGBO(37, 50, 55, 1);
  static const orange = Color.fromRGBO(57, 175, 178, 1);
  static const white = Color.fromRGBO(255, 255, 255, 1);
  static const Color kalaAppAccentColor = Color(0xffc2e5de);
  static const Color kalaAppLightAccentColor =
      Color.fromARGB(255, 236, 255, 251);
  static const Color kalaAppMainColor = Color(0xff00966b);
  static const Color kalaAppSecondaryColor = Color(0xffeb5135);
  static const Color kalaAppSecondaryColor2 = Color.fromARGB(255, 252, 103, 77);
  static const Color facebookColor = Color(0xff0866ff);
}

dynamic addThousandSeparators(dynamic number) {
  return RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))')
      .allMatches(number.toString())
      .map((match) => '${match.group(1)},')
      .join()
      .toString();
}

mixin AppImages {
  static const logo = 'assets/images/kala_app_logo.png';
  static const placeHolder = 'assets/images/Placeholder.png';
  static const shoes = 'assets/images/shoes.png';
  static const bestSeller = 'assets/images/best_seller.jpg';
  static const splash = 'assets/images/splash.gif';
  static const clock = 'assets/icons/timer.png';
  static const piechart = 'assets/icons/piechart.png';
  static const complete = 'assets/icons/complete.png';
  static const noproduct = 'assets/icons/noProduct.gif';
  static const nocategory = 'assets/images/nocategory.png';
  static const noproductImage = 'assets/images/noproduct.png';
  static const String base = "assets/images";
  static const String kalaAppLogo = "$base/kala_app_logo.png";
}

mixin AppIcon {
  static const qr = 'assets/icons/qr.png';
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
  );
}

TextStyle get subtitleStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 14.5.sp,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
  );
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  );
}

// FOR Q & U Hongkong Furniture
// var baseUrl = "http://192.168.1.74:8000/api";
var baseUrl = "https://qandufurniture.com/api";

var url = "https://qandufurniture.com.np";

var khaltiurl = "https://khalti.com/api";
// "http://192.168.1.73:8000";

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}
