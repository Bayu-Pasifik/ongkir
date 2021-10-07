import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ongkir/app/modules/home/controllers/home_controller.dart';

class Kurir extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
        mode: Mode.MENU,
        showSelectedItem: true,
        items: ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'],
        label: "Menu mode",
        hint: "country in menu mode",
        popupItemDisabled: (String s) => s.startsWith('I'),
        onChanged: print,
        selectedItem: "Brazil");
  }
}
