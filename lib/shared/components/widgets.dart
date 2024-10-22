import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class AppButtons {
  static Widget customElevatedButton({
    Color? color,
    Color? hoverColor,
    Color? textColor,
    double width = 250,
    double height = 47,
    double elevation = 5,
    required String text,
    double fontSize = 16,
    double borderRadius = 12,
    required Function()? onPressed,
    FontWeight fontWeight = FontWeight.normal,
  }) =>
      ElevatedButton(
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: hoverColor, backgroundColor: color, elevation: elevation,
          minimumSize: Size(width, height),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
        ),
      );

  static Widget customTextButton({
    required String text,
    double? fontSize = 12,
    Color color = Colors.orange,
    Color? hoverColor,
    double width = 40,
    double height = 49,
    required Function() onPressed,
    EdgeInsetsGeometry? padding,
    TextDecoration? decoration,
  }) =>
      TextButton(
        style: TextButton.styleFrom(
          foregroundColor: hoverColor, minimumSize: Size(width, height),
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            color: color,
            decoration: decoration,
          ),
        ),
        onPressed: onPressed,
      );

  static Widget customButtonBack(
    context,
  ) =>
      IconButton(
        icon: Icon(Icons.arrow_back_ios_new, size: 20.sp),
        onPressed: () => Navigator.pop(context),
      );

  static Widget customDropDownButtonFormField({
    String? value,
    double? itemHeight,
    TextStyle? hintStyle,
    Widget? hint,
    String? hintText = 'Select',
    Widget? disabledHint,
    double menuMaxHeight = 200,
    double? fontSize,
    required Function(Object?)? onChanged,
    required List<String> items,
    String? Function(dynamic)? validator,
    EdgeInsetsGeometry? contentPadding =
        const EdgeInsets.symmetric(horizontal: 10),
    EdgeInsetsGeometry? margin =
        const EdgeInsets.only(left: 20, right: 20, top: 5),
  }) =>
      Container(
        margin: margin,
        child: DropdownButtonFormField(
          focusColor: ConstColors.kPrimaryColor,
          itemHeight: itemHeight,
          menuMaxHeight: menuMaxHeight,
          disabledHint: disabledHint,
          value: value,
          onChanged: onChanged,
          validator: validator,
          hint: hint,
          iconEnabledColor: ConstColors.kPrimaryColor,
          iconDisabledColor: Colors.grey,
          decoration: InputDecoration(
            hintStyle: hintStyle,
            hintText: hintText,
            contentPadding: contentPadding,
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: ConstColors.kPrimaryColor, width: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: TextStyle(
                  fontSize: fontSize,
                ),
              ),
            );
          }).toList(),
        ),
      );

  static Widget customMultiSelectDialogField({
    required List<MultiSelectItem<dynamic>> items,
    required void Function(List<dynamic>) onConfirm,
  }) =>
      MultiSelectDialogField(
        title: const Text('Select'),
        dialogHeight: 200.sp,
        searchable: true,
        buttonIcon: Icon(
          Icons.keyboard_arrow_down,
          color: ConstColors.kPrimaryColor,
        ),
        buttonText: const Text('Your interest'),
        listType: MultiSelectListType.LIST,
        selectedColor: ConstColors.kPrimaryColor,
        chipDisplay: MultiSelectChipDisplay(
          chipColor: ConstColors.kPrimaryColor.withOpacity(0.5),
          scrollBar: HorizontalScrollBar(isAlwaysShown: true),
          scroll: true,
          textStyle: TextStyle(
            fontSize: 12.sp,
            color: Colors.white,
          ),
        ),
        validator: (value) {
          if (value == null) {
            return 'Your interest is required';
          }
          return null;
        },
        selectedItemsTextStyle: TextStyle(
          fontSize: 12.sp,
        ),
        itemsTextStyle: TextStyle(
          fontSize: 12.sp,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          border: Border.all(
            width: 1,
            color: Colors.grey.shade400,
          ),
        ),
        items: items,
        onConfirm: onConfirm,
      );
}

class AppItems {
  static Widget customAppLogo() => Image(
        width: 160.sp,
        height: 75.sp,
        fit: BoxFit.fill,
        image: AssetImage(ConstIcons.appLogo),
      );

  static Widget customText(
    String text, {
    int? maxLines,
    bool? softWrap,
    double? fontSize,
    Color? fontColor,
    FontWeight? fontWeight,
    TextOverflow? overflow,
    TextAlign? textAlign,
  }) =>
      Text(
        text,
        overflow: overflow,
        textAlign: textAlign,
        maxLines: maxLines,
        softWrap: softWrap,
        style: TextStyle(
          fontSize: fontSize,
          color: fontColor,
          fontWeight: fontWeight,
        ),
      );

  static Widget customTextField({
    String? hintText,
    String? initialValue,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    TextEditingController? controller,
    bool obscureText = false,
    bool enabled = true,
    bool readOnly = false,
    int maxLines = 1,
    double borderWidth = .5,
    double? hintFontSize,
    Color? hintColor,
    Function()? onTap,
    void Function(String)? onFieldSubmitted,
  }) =>
      TextFormField(
        onTap: onTap,
        readOnly: readOnly,
        onFieldSubmitted: onFieldSubmitted,
        keyboardType: keyboardType,
        validator: validator,
        controller: controller,
        obscureText: obscureText,
        cursorColor: ConstColors.kPrimaryColor,
        maxLines: maxLines,
        enabled: enabled,
        initialValue: initialValue,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: hintFontSize,
            color: hintColor,
          ),
          contentPadding: const EdgeInsets.all(10),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: ConstColors.kPrimaryColor,
              width: borderWidth,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.grey,
              width: borderWidth,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: ConstColors.kPrimaryColor,
              width: borderWidth,
            ),
          ),
        ),
      );

  static Widget customIndicator() {
    return CircularProgressIndicator(
      backgroundColor: Colors.white,
      color: ConstColors.kPrimaryColor,
    );
  }

  static customSnackBar(
    BuildContext context, {
    required String msg,
  }) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: AppItems.customText(msg, fontSize: 12.sp)),
      );
}

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(
  context,
  widget,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (route) {
        return false;
      },
    );
