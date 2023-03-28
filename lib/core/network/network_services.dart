import 'package:http/http.dart' as http;

class NetworkServices {
  final String baseUrl = 'dummyjson.com';

  final Map<String, String> header = {'Content-Type': 'application/json'};

  Future<http.Response> get({required String endpoint}) async {
    var url = Uri.https(baseUrl, endpoint);
    var response = await http.get(url, headers: header);
    return response;
  }
}
