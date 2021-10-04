import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ongkir/app/data/models/province_model.dart';
import 'package:ongkir/app/modules/home/city_model.dart';

import '../controllers/home_controller.dart';
import 'package:http/http.dart' as http;

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('HomeView'),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Provinsi(),
            Obx(
              () => controller.isHidden.isTrue
                  ? SizedBox()
                  : Kota(
                      provId: controller.provId.value,
                    ),
            )
          ],
        ));
  }
}

class Provinsi extends GetView<HomeController> {
  const Provinsi({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownSearch<Province>(
        label: "Provinsi",
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
            print(value.province);
            controller.isHidden.value = false;
            controller.provId.value = int.parse(value.provinceId!);
          } else {
            print("Tidak memilih apapun");
            controller.isHidden.value = true;
            controller.provId.value = 0;
          }
        },
      ),
    );
  }
}

class Kota extends StatelessWidget {
  const Kota({
    required this.provId,
    Key? key,
  }) : super(key: key);

  final int provId;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownSearch<City>(
        label: "Kota / Kabupaten",
        showSearchBox: true,
        showClearButton: true,
        onFind: (String filter) async {
          Uri url = Uri.parse(
              "https://api.rajaongkir.com/starter/city?province=$provId");
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

            var listAllCity = data["rajaongkir"]["results"] as List<dynamic>;
            var models = City.fromJsonList(listAllCity);
            return models;
          } catch (err) {
            print(err);
            return List<City>.empty();
          }
        },
        popupItemBuilder: (context, item, isSelected) {
          return Container(
            padding: EdgeInsets.all(10),
            child: Text(
              "${item.type}" " " "${item.cityName}",
              style: TextStyle(fontSize: 18),
            ),
          );
        },
        itemAsString: (item) => "${item.type}" " " "${item.cityName}",
        searchBoxDecoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            hintText: "Cari kota / kabupaten"),
        onChanged: (value) {
          if (value != null) {
            print(value.cityName);
          } else {
            print("Tidak memilih apapun");
          }
        },
      ),
    );
  }
}
