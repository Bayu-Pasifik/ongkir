import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ongkir/app/modules/courier_model.dart';

void main() async {
  Uri url = Uri.parse("https://api.rajaongkir.com/starter/cost");

  final response = await http.post(url, body: {
    "origin": "144",
    "destination": "144",
    "weight": "900",
    "courier": "jne",
  }, headers: {
    "key": "6ad5c787375f05ff69fb31cfd255ec09",
    "content-type": "application/x-www-form-urlencoded",
  });
  var data = json.decode(response.body) as Map<String, dynamic>;
  var result = data["rajaongkir"]["results"] as List<dynamic>;

  var listAllCourier = CourierModel.fromJsonList(result);
  var courier = listAllCourier[0];
  print(courier.costs!);
}
