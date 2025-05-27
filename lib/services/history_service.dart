import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sound_mp3/data/models/history.dart';
import 'package:sound_mp3/utils/api_endpoints.dart';
import 'package:sound_mp3/utils/app_config.dart';

class HistoryService {
  // Lay danh sach lich su bai hat tu user service (Map<date, List<songId>> =>> Map<date, List<Songs>>)
  Future<History> getSongHistoryWithDetails({
    required String accessToken,
    int todayOffset = 0,
    int yesterdayOffset = 0,
    int otherOffset = 0,
  }) async {
    final url = Uri.parse(
      '${AppConfig.baseUrl}${ApiEndpoints.getAllHistory}'
      '?todayOffset=$todayOffset&yesterdayOffset=$yesterdayOffset&otherOffset=$otherOffset',
    );

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      final errorJson = jsonDecode(response.body);
      throw Exception(errorJson['message'] ?? 'failed');
    }
    final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    final Map<String, dynamic> songMapJson = jsonResponse['data'];
    return History.fromJson(songMapJson);
  }

  // them vao history
  Future<void> addSongHistory(String accessToken, String songId) async {
    final response = await http.post(
      Uri.parse('${AppConfig.baseUrl}${ApiEndpoints.addSongHistory}'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json'
      },
      body: jsonEncode({
        'song': songId,
      }),
    );

    if (response.statusCode != 201) {
      final errorJson = jsonDecode(response.body);
      throw Exception(errorJson['message'] ?? 'failed');
    }
  }
}
