import 'package:http/http.dart' as http;

void main() async {
  Uri url = Uri.parse("https://api.rajaongkir.com/starter/province");

  final response = await http.get(url, headers: {
    "key": "6ad5c787375f05ff69fb31cfd255ec09",
  });

  print(response.body);
}
