import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ongkir/app/modules/home/controllers/home_controller.dart';

class BeratBarang extends GetView<HomeController> {
  const BeratBarang({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            autocorrect: false,
            controller: controller.beratController,
            decoration: InputDecoration(
                hintText: "Berat Barang",
                labelText: "Berat Barang",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
            onChanged: (value) => controller.ubahBerat(value),
          )),
          SizedBox(
            width: 10,
          ),
          Container(
            width: 150,
            child: DropdownSearch<String>(
              selectedItem: "gram",
              mode: Mode.BOTTOM_SHEET,
              showSelectedItem: true,
              items: [
                "ton",
                "kwintal",
                "ons",
                "lbs",
                "pound",
                "kg",
                "hg",
                "dag",
                "gram",
                
              ],
              showSearchBox: true,
              searchBoxDecoration: InputDecoration(
                  hintText: "Cari satuan berat",
                  labelText: "Satuan Berat",
                  border: OutlineInputBorder()),
              label: "Satuan Berat",
              hint: "Satuan Berat",
              onChanged: (value) => controller.ubahSatuan(value!),
            ),
          )
        ],
      ),
    );
  }
}
