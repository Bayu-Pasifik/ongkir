import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ongkir/app/modules/courier_model.dart';

class HomeController extends GetxController {
  var hiddenKotaAsal = true.obs;
  var hiddenKotaTujuan = true.obs;

  var provAsalId = 0.obs;
  var provTujuanId = 0.obs;

  var kotaAsalId = 0.obs;
  var kotaTujuan = 0.obs;

  int berat = 0;
  String satuan = "gram";

  var hiddenButton = true.obs;
  var kurir = "".obs;

  void showButton() {
    if (kotaAsalId.value != 0 &&
        kotaTujuan.value != 0 &&
        kurir.value != "" &&
        berat > 0 &&
        provAsalId.value != 0 &&
        provTujuanId.value != 0) {
      hiddenButton.value = false;
    } else {
      hiddenButton.value = true;
    }
  }

  void ubahBerat(String value) {
    berat = int.tryParse(value) ?? 0;
    String cekSatuan = satuan;

    switch (cekSatuan) {
      case "ton":
        berat = berat * 1000000;
        break;
      case "kwintal":
        berat = berat * 100000;
        break;
      case "ons":
        berat = berat * 100;
        break;
      case "lbs":
        berat = berat * 2204;
        break;
      case "pound":
        berat = berat * 2204;
        break;
      case "kg":
        berat = berat * 1000;
        break;
      case "hg":
        berat = berat * 100;
        break;
      case "dag":
        berat = berat * 10;
        break;
      case "gram":
        berat = berat;
        break;
      
      default:
        berat = berat;
    }

    print("$berat gram");
    showButton();
  }

  void ubahSatuan(String value) {
    berat = int.tryParse(beratController.text) ?? 0;
    switch (value) {
      case "ton":
        berat = berat * 1000000;
        break;
      case "kwintal":
        berat = berat * 100000;
        break;
      case "ons":
        berat = berat * 100;
        break;
      case "lbs":
        berat = berat * 2204;
        break;
      case "pound":
        berat = berat * 2204;
        break;
      case "kg":
        berat = berat * 1000;
        break;
      case "hg":
        berat = berat * 100;
        break;
      case "dag":
        berat = berat * 10;
        break;
      case "gram":
        berat = berat;
        break;
      
      default:
        berat = berat;
    }

    satuan = value;
    debugPrint("$berat gram");
    showButton();
  }

  void ongkosKirim() async {
    Uri url = Uri.parse("https://api.rajaongkir.com/starter/cost");
    try {
      final response = await http.post(url, body: {
        "origin": "$kotaAsalId",
        "destination": "$kotaTujuan",
        "weight": "$berat",
        "courier": "$kurir",
      }, headers: {
        "key": "6ad5c787375f05ff69fb31cfd255ec09",
        "content-type": "application/x-www-form-urlencoded",
      });
      var data = json.decode(response.body) as Map<String, dynamic>;
      var result = data["rajaongkir"]["results"] as List<dynamic>;

      var listAllCourier = CourierModel.fromJsonList(result);
      var courier = listAllCourier[0];
      print(courier);
      Get.defaultDialog(
          title: courier.name!,
          content: Column(
            children: courier.costs!
                .map((e) => ListTile(
                      title: Text("${e.service}"),
                      subtitle: Text("${e.cost![0].value}"),
                      trailing: Text(courier.code == "pos"
                          ? "${e.cost![0].etd}"
                          : "${e.cost![0].etd} HARI"),
                    ))
                .toList(),
          ));
    } catch (e) {
      print(e);
      Get.defaultDialog(title: "Terjadi kesalahan", middleText: e.toString());
    }
  }

  late TextEditingController beratController;

  @override
  void onInit() {
    beratController = TextEditingController(text: "$berat");
    super.onInit();
  }

  @override
  void onClose() {
    beratController.dispose();
    super.onClose();
  }
}
