import 'dart:developer';

import 'package:change_case/change_case.dart';
import 'package:dado_vendor/database/database.dart';
import 'package:dado_vendor/dependency/get_it.dart';
import 'package:dado_vendor/dependency/navigation/navigator_routes.dart';
import 'package:dado_vendor/utils/size_config.dart';
import 'package:dado_vendor/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pinput/pinput.dart';

import '../dependency/navigation/global_router_exports.dart';
import 'colors.dart';

void globalToast(String message) => Fluttertoast.showToast(
    msg: message.toUpperFirstCase(),
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 15);

void globaLog(String topic, message) => log('$topic $message');

bool isValidEmail(String email) {
  bool emailValid = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\'
          r's@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.'
          r'[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.'
          r')+[a-zA-Z]{2,}))$')
      .hasMatch(email);
  if (emailValid) {
    return true;
  } else {
    return false;
  }
}

Future<XFile?> imagePicker() async {
  XFile? imageFile;
  try {
    imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  } catch (_) {}
  return imageFile;
}

void copyToClipboard({required String toastText, required String text}) async {
  await Clipboard.setData(ClipboardData(text: text));
  globalToast('$toastText copied');
}

Gap globalGap(double gap) => Gap(gap.heightAdjusted);

String convertDate(
    {required DateTime? selectedDateTime, required String placeHolder}) {
  final dateFormat = DateFormat('MMM d, ' 'yyyy');
  return selectedDateTime == null
      ? placeHolder
      : dateFormat.format(selectedDateTime);
}

PinTheme pinTheme() {
  return PinTheme(
    width: 56,
    height: 56,
    textStyle: GlobalTextStyles.regularText(fontSize: 16, color: Colors.black),
    decoration: BoxDecoration(
        border: Border.all(color: kTextFieldStroke),
        borderRadius: BorderRadius.circular(8)),
  );
}


void checkStatus() async {
  try {
    await getItInstance<TempDatabaseImpl>().getUserToken().then((userToken) {
      if (userToken.isNotEmpty) {
        globalNavigateTo(route: Routes.getStartedScreen);
      } else {
        globalNavigateUntil(route: Routes.getStartedScreen);
      }
    });
  } catch (_) {}
}
