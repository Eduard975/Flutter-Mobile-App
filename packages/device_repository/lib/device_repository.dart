import 'package:flutter/material.dart';

class DeviceRepository {
  DeviceRepository();
  static double deviceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double deviceWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
}
