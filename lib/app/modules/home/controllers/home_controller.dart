import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class HomeController extends GetxController {
  var hiddenKotaAsal = true.obs;
  var hiddenKotaTujuan = true.obs;

  var provAsalId = 0.obs;
  var provTujuanId = 0.obs;

  var kotaAsalId = 0.obs;
  var kotaTujuan = 0.obs;

  double berat = 0.0;
  String satuan = "gram";

  var hiddenButton = true.obs;
  var kurir = "".obs;

  void showButton() {
    if (kotaAsalId.value != 0 && kotaTujuan.value != 0 && kurir.value != "") {
      hiddenButton.value = false;
    } else {
      hiddenButton.value = true;
    }
  }

  void ubahBerat(String value) {
    berat = double.tryParse(value) ?? 0.0;
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
        berat = berat * 2204.62;
        break;
      case "pound":
        berat = berat * 2204.62;
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
      case "dg":
        berat = berat / 10;
        break;
      case "cg":
        berat = berat / 100;
        break;
      case "mg":
        berat = berat / 1000;
        break;
      default:
        berat = berat;
    }

    print("$berat gram");
    debugPrint("$berat gram");
  }

  void ubahSatuan(String value) {
    berat = double.tryParse(beratController.text) ?? 0.0;
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
        berat = berat * 2204.62;
        break;
      case "pound":
        berat = berat * 2204.62;
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
      case "dg":
        berat = berat / 10;
        break;
      case "cg":
        berat = berat / 100;
        break;
      case "mg":
        berat = berat / 1000;
        break;
      default:
        berat = berat;
    }

    satuan = value;
    debugPrint("$berat gram");
  }

  late TextEditingController beratController;

  @override
  void onInit() {
    beratController = TextEditingController(text: "$berat");
    super.onInit();
  }
}
