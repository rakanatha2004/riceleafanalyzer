import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:riceleafanalyzer/response/predict_history.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static final String baseUrl = "http://192.168.100.7:8000";

  Future<bool> register(String username, String password) async {
    final url = Uri.parse("$baseUrl/register");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"username": username, "password": password}),
    );

    return response.statusCode == 200;
  }

  Future<bool> login(String username, String password) async {
    final url = Uri.parse("$baseUrl/login");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"username": username, "password": password}),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final token = body["access_token"];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", token);

      return true;
    }

    return false;
  }

  Future<Map<String, dynamic>?> predict(File image) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    final url = Uri.parse("$baseUrl/predict");

    final request = http.MultipartRequest("POST", url)
      ..headers['Authorization'] = "Bearer $token"
      ..files.add(await http.MultipartFile.fromPath("image", image.path));

    final streamed = await request.send();
    final response = await http.Response.fromStream(streamed);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  Future<List<PredictHistory>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    final response = await http.get(
      Uri.parse("$baseUrl/history"),
      headers: {"Authorization": "Bearer $token"},
    );

    print("DEBUG HISTORY: ${response.body}");

    if (response.statusCode == 200) {
      final List list = jsonDecode(response.body);
      return list.map((e) => PredictHistory.fromJson(e)).toList();
    }

    return [];
  }

  static Future logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    return true;
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }
}
