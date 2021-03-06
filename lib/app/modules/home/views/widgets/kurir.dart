import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ongkir/app/modules/home/controllers/home_controller.dart';

class Kurir extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownSearch<Map<String, dynamic>>(
        mode: Mode.MENU,
        showClearButton: true,
        items: [
          {"code": "JNE", "name": "Jasa Nugraha Ekakurir(JNE)"},
          {"code": "Tiki", "name": "Titipan Kilat (TIKI)"},
          {"code": "Pos", "name": "Purusahaan Optional Surat(POS)"},
        ],
        label: "Pilih Kurir",
        hint: "Pilih Kurir",
        //popupItemDisabled: ,
        onChanged: (value) {
          if (value != null) {
            controller.kurir.value = value['code'];
            controller.showButton();
          } else {
            controller.hiddenButton.value = true;
            controller.kurir.value = "";
          }
        },
        itemAsString: (item) => "${item['name']}",
        popupItemBuilder: (context, item, isSelected) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              child: Text(
                "${item['name']}",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          );
        },
      ),
    );
  }
}
