import 'package:flutter/material.dart';

import 'colors.dart';

double defaultVPadding = 8;

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: primaryColor, width: 2.0),
  ),
);

const primaryIconThemeColor = IconThemeData(color: kRichBlack);

ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
  padding: const EdgeInsets.all(18),
  elevation: 0,
  backgroundColor: primaryColor,
  foregroundColor: kWhiteColor,
  minimumSize: const Size.fromHeight(50),
);
ButtonStyle kOutlinedButtonStyle = OutlinedButton.styleFrom(
  foregroundColor: primaryColor,
  side: const BorderSide(color: primaryColor),
  minimumSize: const Size.fromHeight(50),
);

const kTextInputFieldDecoration = InputDecoration(
  prefixIcon: Icon(
    Icons.mail_outline,
    color: Colors.grey,
  ),
  labelText: 'Email',
  hintText: 'Email',
  labelStyle: TextStyle(
    color: Colors.grey,
  ),
  errorMaxLines: 2,
  border: OutlineInputBorder(),
  focusColor: primaryColor,
  hoverColor: primaryColor,
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: primaryColor,
    ),
  ),
);

const kRowTextFieldDecoration = InputDecoration(
  hintText: 'First name',
  focusColor: primaryColor,
  border: OutlineInputBorder(),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      style: BorderStyle.solid,
    ),
  ),
  errorStyle: TextStyle(color: Colors.red),
);
