import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CallApi {
  final String _url = 'http://10.0.2.2:8080/Projects/INSUCARE/public/api';
  //if you are using android studio emulator, change localhost to 10.0.2.2
  // ignore: prefer_typing_uninitialized_variables
  var token;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token')!);
  }

  postDataWithToken(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    await _getToken();

    return await http.post(
      Uri.parse(fullUrl),
      body: jsonEncode(data),
      headers: _setHeadersWithToken(),
    );
  }

  postData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;

    return await http.post(
      Uri.parse(fullUrl),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }

  getDataWithToken(apiUrl) async {
    var fullUrl = _url + apiUrl;
    await _getToken();

    return await http.get(
      Uri.parse(fullUrl),
      headers: _setHeadersWithToken(),
    );
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl;

    return await http.get(
      Uri.parse(fullUrl),
      headers: _setHeaders(),
    );
  }

  _setHeadersWithToken() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
}
