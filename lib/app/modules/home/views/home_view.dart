import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ongkir/app/modules/home/views/widgets/berat.dart';
import 'package:ongkir/app/modules/home/views/widgets/button_ongkir.dart';
import 'package:ongkir/app/modules/home/views/widgets/kurir.dart';
import '../controllers/home_controller.dart';
import 'widgets/kota.dart';
import 'widgets/provinsi.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[900],
          title: Text('HomeView'),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Provinsi(
              tipe: "asal",
            ),
            Obx(
              () => controller.hiddenKotaAsal.isTrue
                  ? SizedBox()
                  : Kota(
                      tipe: "asal",
                      provId: controller.provAsalId.value,
                    ),
            ),
            Provinsi(
              tipe: "tujuan",
            ),
            Obx(
              () => controller.hiddenKotaAsal.isTrue
                  ? SizedBox()
                  : Kota(
                      tipe: "tujuan",
                      provId: controller.provTujuanId.value,
                    ),
            ),
            BeratBarang(),
            Kurir(),
            CekOgkir()
          ],
        ));
  }
}
