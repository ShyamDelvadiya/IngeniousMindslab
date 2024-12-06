import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ingenious_mindslab/utils/size_constant.dart';

class DialogUtils {
  static String appName = "Ingenious Mindslab";




  static void showSheet(BuildContext context, Widget child) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: child,
        ),
      ),
    );
  }

  static void showAlertDialog(
      BuildContext context, String message, Function()? callback,
      {List<Widget>? actions}) {
    // flutter defined function

    showDialog(
      context: context,
      builder: (context) {
        if (Platform.isIOS) {
          return _showCupertinoAlertDialog(context, message, actions: actions);
        } else {
          return _showMaterialAlertDialog(context, message, actions: actions);
        }
      },
    ).then(
          (value) {
        print(value);
        if (value == true) {
          callback?.call();
        }
      },
    );
  }

  static CupertinoAlertDialog _showCupertinoAlertDialog(
      BuildContext context, String message,
      {List<Widget>? actions}) {
    return CupertinoAlertDialog(
      title: Text(appName),
      content: Text(message),
      actions: actions ?? _actions(context),
    );
  }

  static AlertDialog _showMaterialAlertDialog(
      BuildContext context, String message,
      {List<Widget>? actions}) {
    return AlertDialog(
      title: Text(appName),
      content: Text(
        message,
        style: const TextStyle(color: Colors.black),
      ),
      actions: actions ?? _actions(context),
    );
  }

  static List<Widget> _actions(BuildContext context) {
    return <Widget>[
      Platform.isIOS
          ? Row(
        children: [
          Expanded(
            child: CupertinoDialogAction(
              child: const Text("Yes"),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ),
          Expanded(
            child: CupertinoDialogAction(
              child: const Text("No"),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
          ),
        ],
      )
          : Row(
        children: [
          Expanded(
            child: ElevatedButton(
              child: const Text("Yes"),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ),
          PaddingConstant.horizontalSpace(),
          Expanded(
            child: ElevatedButton(
              child: const Text("No"),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
          ),
        ],
      ),
    ];
  }
}
