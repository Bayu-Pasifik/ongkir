import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ongkir/app/modules/home/controllers/home_controller.dart';

class CekOgkir extends GetView<HomeController> {
  const CekOgkir({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.hiddenButton.isTrue
        ? SizedBox()
        : ElevatedButton(
            onPressed: () {},
            child: Text("CEK ONGKIR"),
            style: ElevatedButton.styleFrom(primary: Colors.red[900]),
          ));
  }
}
