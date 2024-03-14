import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';

class MyInputField extends StatelessWidget {
  final String labelText;
  final TextEditingController? controller;
  final Widget? widget;
  final bool? ismultiline;
  final bool? enabled;
  final bool? obscuretext;
  final Widget? suffix;
  final FormFieldValidator? validator;
  final ValueChanged<String>? onChanged;
  final VoidCallback? ontap;
  final TextInputType? inputType;
  final String? initValue;
  final bool? readOnly;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;

  const MyInputField({
    Key? key,
    required this.labelText,
    this.controller,
    this.readOnly,
    this.initValue,
    this.onChanged,
    this.widget,
    this.ismultiline = false,
    this.suffix,
    this.validator,
    this.enabled = true,
    this.inputType = TextInputType.multiline,
    this.obscuretext = false,
    this.ontap,
    this.textInputAction,
    this.focusNode,
    this.maxLength, this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                textInputAction: textInputAction,
                initialValue: initValue,
                keyboardType: inputType,
                readOnly: widget == null ? false : true,
                cursorColor:
                    Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
                controller: controller,
                style: subtitleStyle,
                validator: validator,
                onChanged: onChanged,
                inputFormatters: inputFormatters,
                minLines: ismultiline! ? 2 : 1,
                maxLines: ismultiline! ? 6 : 1,
                textAlignVertical: TextAlignVertical.center,
                obscureText: obscuretext!,
                onTap: ontap,
                maxLength: maxLength,
                decoration: InputDecoration(
                  label: Text(
                    labelText,
                    style: subtitleStyle.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  errorStyle: subtitleStyle.copyWith(
                    color: Colors.red,
                    fontSize: 10,
                  ),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 10,
                  ),
                  hintStyle: subtitleStyle.copyWith(
                    color: Colors.grey,
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColor.kalaAppMainColor,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColor.kalaAppMainColor,
                    ),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  suffixIcon: suffix,
                ),
              ),
            ),
            widget == null ? const SizedBox() : SizedBox(child: widget)
          ],
        )
      ],
    );
  }
}
