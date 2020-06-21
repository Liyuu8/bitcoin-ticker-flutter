import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final String url;

  NetworkHelper(this.url);

  Future getData() async {
    print('NetworkHelper.getData(): url = $url');
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;
      print('NetworkHelper.getData(): statusCode = 200');
      return jsonDecode(data);
    } else {
      print('NetworkHelper.getData(): statusCode = ${response.statusCode}');
    }
  }
}
