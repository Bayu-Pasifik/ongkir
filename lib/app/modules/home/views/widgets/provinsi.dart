import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ongkir/app/data/models/province_model.dart';
import 'package:ongkir/app/modules/home/controllers/home_controller.dart';
import 'package:http/http.dart' as http;

class Provinsi extends GetView<HomeController> {
  const Provinsi({Key? key, required this.tipe}) : super(key: key);

  final String tipe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownSearch<Province>(
        label: tipe == "asal" ? "Provinsi Asal" : "Provinsi Tujuan",
        showSearchBox: true,
        showClearButton: true,
        onFind: (String filter) async {
          Uri url = Uri.parse("https://api.rajaongkir.com/starter/province");
          try {
            final response = await http.get(
              url,
              headers: {
                "key": "6ad5c787375f05ff69fb31cfd255ec09",
              },
            );
            var data = json.decode(response.body) as Map<String, dynamic>;

            var statusCode = data["rajaongkir"]["status"]["code"];
            if (statusCode != 200) {
              throw data["rajaongkir"]["status"]["description"];
            }

            var listAllProvince =
                data["rajaongkir"]["results"] as List<dynamic>;
            var models = Province.fromJsonList(listAllProvince);
            return models;
          } catch (err) {
            print(err);
            return List<Province>.empty();
          }
        },
        popupItemBuilder: (context, item, isSelected) {
          return Container(
            padding: EdgeInsets.all(10),
            child: Text(
              "${item.province}",
              style: TextStyle(fontSize: 18),
            ),
          );
        },
        itemAsString: (item) => item.province!,
        searchBoxDecoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            hintText: "Cari Provinsi"),
        onChanged: (value) {
          if (value != null) {
            if (tipe == "asal") {
              print(value.province);
              controller.hiddenKotaAsal.value = false;
              controller.provAsalId.value = int.parse(value.provinceId!);
            } else {
              print(value.province);
              controller.hiddenKotaTujuan.value = false;
              controller.provTujuanId.value = int.parse(value.provinceId!);
            }
          } else {
            if (tipe == "asal") {
              controller.hiddenKotaAsal.value = true;
              controller.provAsalId.value = 0;
            } else {
              controller.hiddenKotaTujuan.value = true;
              controller.provTujuanId.value = 0;
            }
          }
        },
      ),
    );
  }
}
